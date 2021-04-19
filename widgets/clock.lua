local awful = require("awful")
local wibox = require("wibox")
local menubar = require("menubar")

local dpi = beautiful.xresources.apply_dpi

local module = {}

function module.new()
    return wibox.widget {
        {
            {
                {
                    widget = wibox.widget.textclock(" %H:%M ")
                },
                widget = wibox.container.place,
                halign = "center"
            },
            forced_width = dpi(50),
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, dpi(8))
            end,
            widget = wibox.container.background,
            bg = beautiful.clock_bg or "#00000000"
        },
        widget = wibox.container.margin,
        margins = dpi(4)
    }
end

return setmetatable(module, {
    __call = function(_, ...)
        return module.new(...)
    end
})
