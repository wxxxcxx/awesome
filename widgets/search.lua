local awful = require("awful")
local wibox = require("wibox")
local menubar = require("menubar")

local module = {}

function module.new()
    local search_buttons =
        gears.table.join(
        awful.button(
            {},
            1,
            function(c)
                awful.spawn.with_shell(
                    "rofi -modi 'window,drun' -show drun -drun-show-actions -display-drun '' -show-icons"
                )
            end
        )
    )
    return wibox.widget {
        image = beautiful.search_icon,
        resize = true,
        buttons = search_buttons,
        widget = wibox.widget.imagebox
    }
end

return setmetatable(
    module,
    {
        __call = function(_, ...)
            return module.new(...)
        end
    }
)
