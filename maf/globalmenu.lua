local menubar = require("menubar")
local awful = require("awful")
local environment = require("maf.environment")
local hotkeys_popup = require("awful.hotkeys_popup")

local moudle =
    awful.menu(
    {
        {
            "Terminal",
            environment.terminal
        },
        {
            "Browser",
            environment.browser
        },
        {
            "Files",
            environment.filemanager
        },
        {
            "Awesome",
            {
                {
                    "hotkeys",
                    function()
                        return false, hotkeys_popup.show_help
                    end
                },
                {
                    "manual",
                    environment.terminal .. " -e man awesome"
                },
                {
                    "edit config",
                    environment.gui_editor .. " " .. awesome.conffile
                },
                {
                    "restart",
                    awesome.restart
                }
            }
        },
        {
            "System",
            {
                {
                    "Lock",
                    "slimlock"
                },
                {
                    "Suspend",
                    "systemctl suspend"
                },
                {
                    "Reboot",
                    "systemctl reboot"
                },
                {
                    "Shutdown",
                    "systemctl poweroff"
                }
            }
        }
    }
)



return moudle
