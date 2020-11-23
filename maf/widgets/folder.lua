local awful = require("awful")
local wibox = require("wibox")

local module = {}

function module.new(inner_widget)
    inner_widget =
        wibox.widget {
        inner_widget,
        visible=false,
        widget = wibox.container.background
    }
    local toggle =
        wibox.widget {
        markup = utf8.char(0xe5dc),
        font = "Noto Sans 20",
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox
    }
    local buttons =
        gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                if inner_widget.visible then
                    toggle.markup = utf8.char(0xe5dc)
                else
                    toggle.markup = utf8.char(0xe5dd)
                end
                inner_widget.visible = not inner_widget.visible
            end
        )
    )
    toggle:buttons(buttons)

    local widget =
        wibox.widget {
        {
            {
                toggle,
                left = 5,
                right = 5,
                widget = wibox.container.margin
            },
            inner_widget,
            layout = wibox.layout.fixed.horizontal
        },
        left = 4,
        right = 4,
        widget = wibox.container.margin
    }
    return widget
end

return setmetatable(
    module,
    {
        __call = function(_, ...)
            return module.new(...)
        end
    }
)
