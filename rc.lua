pcall(require, 'luarocks.loader')
-- require("utils")
gears = require('gears')
beautiful = require('beautiful')
beautiful.init(gears.filesystem.get_configuration_dir() .. 'themes/default/theme.lua')
package.path = package.path .. ';' .. gears.filesystem.get_configuration_dir()

local naughty = require('naughty')

function notify(msg)
    naughty.notify(
        {
            border_width = 0,
            position = 'top_right',
            title = 'New message!',
            text = msg
        }
    )
end

local desktop = require('desktop')

desktop:init()

local awful = require('awful')

awful.spawn.with_shell('~/.config/awesome/autostart.sh')

-- require('lyrics')
