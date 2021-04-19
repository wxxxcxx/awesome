local menubar = require('menubar')
local awful = require('awful')
local environment = require('environment')
local hotkeys_popup = awful.hotkeys_popup

local moudle =
    awful.menu(
    {
        {
            'Terminal',
            environment.terminal
        },
        {
            'Browser',
            environment.browser
        },
        {
            'Files',
            environment.filemanager
        },
        {
            'Awesome',
            {
                {
                    'Help',
                    function()
                        return false, hotkeys_popup.show_help
                    end
                },
                {
                    'Manual',
                    environment.terminal .. ' -e man awesome'
                },
                {
                    'Settings',
                    environment.gui_editor .. ' ' .. awesome.conffile
                },
                {
                    'Restart',
                    awesome.restart
                },
                {
                    'Quit',
                    function()
                        awesome.quit()
                    end
                }
            }
        },
        {
            'System',
            {
                {
                    'Lock',
                    'light-locker-command --lock'
                },
                {
                    'Suspend',
                    'systemctl suspend'
                },
                {
                    'Reboot',
                    'systemctl reboot'
                },
                {
                    'Shutdown',
                    'systemctl poweroff'
                }
            }
        }
    }
)

root.buttons(
    gears.table.join(
        root.buttons(),
        awful.button(
            {},
            1,
            function()
                moudle:hide()
            end
        ),
        awful.button(
            {},
            3,
            function()
                moudle:show()
            end
        )
    )
)

client.connect_signal(
    'button::press',
    function(c)
        moudle:hide()
    end
)
client.connect_signal(
    'focus',
    function(c)
        moudle:hide()
    end
)

return moudle
