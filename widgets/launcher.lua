local awful = require('awful')
local wibox = require('wibox')
local menubar = require('menubar')
local filesystem = require('gears.filesystem')

local dpi = beautiful.xresources.apply_dpi

local module = {}

function module.new(args)
    local args = args or {}

    return wibox.widget {
        awful.widget.launcher(
            {
                image = beautiful.awesome_icon,
                command = 'rofi -modi drun -dpi -me-select-entry \'\' -me-accept-entry MousePrimary -me-accept-custom MouseSecondary ' ..
                    awful.screen.focused().dpi ..
                        ' -show drun -theme ' ..
                            filesystem.get_configuration_dir() ..
                                'misc/launchpad.rasi -icon-theme ' .. beautiful.icon_theme
            }
        ),
        widget = wibox.container.margin,
        top = dpi(5),
        bottom = dpi(5),
        left = dpi(10),
        right = dpi(10)
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
