local awful = require("awful")
local wibox = require("wibox")
local tasklist = require("widget.tasklist")
local taglist = require("widget.taglist")
local animation = require("utils.animation")

local module = {}

function module.new(args)
    local height = args.height or 70
    local show_geometry = {
        x = math.ceil(screen[mouse.screen].geometry.width / 4),
        y = screen[mouse.screen].geometry.height - height,
        height = height,
        width = math.ceil(screen[mouse.screen].geometry.width / 2)
    }
    local bar =
        wibox(
        {
            -- x=0,
            x = math.ceil(screen[mouse.screen].geometry.width / 4),
            y = screen[mouse.screen].geometry.height - height,
            ontop = true,
            -- width =screen[mouse.screen].geometry.width,
            width = math.ceil(screen[mouse.screen].geometry.width / 2),
            height = height,
            screen = args.screen,
            visible = true,
            bg = "#00000000",
            type = "dnd"
            -- border_width =1,
            -- border_color = "#000000"
        }
    )

    -- local preview_easa_animation =
    --     animation.easa(
    --     {
    --         begin = preview.preview_popup.x,
    --         callback = function(a)
    --             preview.preview_popup.x = a
    --         end
    --     }
    -- )

    local mytasklist =
        tasklist.new(
        {
            screen = args.screen,
            wibox = bar
        }
    )

    local mytaglist =
        taglist.new(
        {
            screen = args.screen
        }
    )

    bar:setup {
        {
            {
                mytasklist,
                valign = "center",
                layout = wibox.container.place
            },
            mytaglist,
            layout = wibox.layout.fixed.horizontal
        },
        valign = "center",
        halign = "center",
        widget = wibox.container.place
    }

    local easa_animation =
        animation.easa(
        {
            begin = screen[mouse.screen].geometry.height - height,
            callback = function(a)
                bar.y = a
            end
        }
    )
    function show()
        easa_animation.start(
            {
                -- begin = bar.y,
                target = screen[mouse.screen].geometry.height - bar.height
            }
        )
    end
    local function hide()
        easa_animation.start(
            {
                target = screen[mouse.screen].geometry.height - 1
            }
        )
    end
    bar:connect_signal("mouse::enter", show)
    bar:connect_signal("mouse::leave", hide)

    local function update_bar_visble(c)
        if c == client.focus then
            if not (c.skip_taskbar or c.hidden or c.type == "splash" or c.type == "dock" or c.type == "desktop") then
                if gears.geometry.rectangle.area_intersect_area(c:geometry(), show_geometry) then
                    hide()
                else
                    show()
                end
            end
        end
    end

    client.connect_signal("focus", update_bar_visble)
    client.connect_signal("request::geometry", update_bar_visble)
    client.connect_signal("manage", update_bar_visble)

    return bar
end

return module
