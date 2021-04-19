local awful = require("awful")
local wibox = require("wibox")

local dpi = beautiful.xresources.apply_dpi

local module = {}

function module.new(inner_widget)
    inner_widget = wibox.widget {
        inner_widget,
        visible = false,
        widget = wibox.container.background
    }
    local toggle = wibox.widget {
        image = beautiful.folder_icon,
        resize = true,
        widget = wibox.widget.imagebox
    }
    local buttons = gears.table.join(awful.button({}, 1, nil, function()
        if inner_widget.visible then
            toggle.markup = utf8.char(0xe5dc)
        else
            toggle.markup = utf8.char(0xe5dd)
        end
        inner_widget.visible = not inner_widget.visible
    end))
    toggle:buttons(buttons)

    local widget = wibox.widget {

        {
            {

                {
                    toggle,
                    margins = dpi(5),
                    widget = wibox.container.margin
                },

                inner_widget,
                layout = wibox.layout.fixed.horizontal
            },
            widget = wibox.container.background,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, dpi(8))
            end,
            bg = beautiful.folder_bg
        },
        margins = dpi(4),
        widget = wibox.container.margin
    }
    return widget
end

return setmetatable(module, {
    __call = function(_, ...)
        return module.new(...)
    end
})
