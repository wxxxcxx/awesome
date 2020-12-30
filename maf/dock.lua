local awful = require("awful")
local wibox = require("wibox")

local module = {}

function module:new(args)
    local screen = args.screen or screen.primay
    local position = args.position or "bottom"
    local size = args.size or 60
    local margins = args.margins or
                        {left = 50, right = 50, top = 50, bottom = 10}
    local x = margins.left
    local y = screen.geometry.height - margins.bottom - size
    local width = screen.geometry.width - margins.left - margins.right
    local height = size
    -- TODO
    if position == "right" then
    elseif postion == "left" then
    else
    end
    local dock = wibox({
        x = x,
        y = y,
        width = width,
        height = height,
        visible = true,
        bg = "#ffffff55",
        screen = screen
    })
    local w = wibox.widget.base.make_widget()
    w.draw = function(widget, parent, cr, width, height)
        cr:set_source(gears.color("#ff00ff"))
        cr:rectangle(0, 0, 50, 50)
        cr:fill()
        cr:set_source(gears.color("#0000ff"))
        -- cr:arc_negative(25, 25, 25, 0, 180)
        -- cr:fill()
        cr:curve_to(0, 0, 0,50, 50, 50)
        cr:curve_to( 50, 50,50, 0, 0,0)
        -- cr:stroke()
        cr:fill()
    end
    w.fit = function(widget, parent, width, height)
        return width > height and height or width
    end
    dock:setup{
        w,
        {
            markup = "lllllllllllllllll",
            align = "right",
            valign = "center",
            buttons = tag_switch_buttons,
            widget = wibox.widget.textbox
        },
        w,
        layout = wibox.layout.align.horizontal
    }
    w:emit_signal("widget::updated")
end

return module
