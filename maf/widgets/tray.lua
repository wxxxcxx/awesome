local awful = require("awful")
local wibox = require("wibox")

local module = {}

function module.new()
    local tray =
        wibox.widget {
        wibox.widget.systray(),
        top = 4,
        bottom = 4,
        left = 7,
        right = 7,
        widget = wibox.container.margin,
        visible = false
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
                if tray.visible then
                    toggle.markup = utf8.char(0xe5dc)
                else
                    toggle.markup = utf8.char(0xe5dd)
                end
                tray.visible = not tray.visible
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
            tray,
            layout = wibox.layout.fixed.horizontal
        },
        margins = 4,
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

