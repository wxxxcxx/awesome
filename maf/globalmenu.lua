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
            -- menubar.utils.lookup_icon('utilities-terminal')
        },
        {
            "Browser",
            environment.browser
            -- menubar.utils.lookup_icon('internet-web-browser')
        },
        {
            "Files",
            environment.filemanager
            -- menubar.utils.lookup_icon('system-file-manager')
        },
        {
            "Awesome",
            {
                {
                    "hotkeys",
                    function()
                        return false, hotkeys_popup.show_help
                    end
                    -- menubar.utils.lookup_icon('preferences-desktop-keyboard-shortcuts')
                },
                {
                    "manual",
                    environment.terminal .. " -e man awesome"
                    -- menubar.utils.lookup_icon('system-help')
                },
                {
                    "edit config",
                    environment.gui_editor .. " " .. awesome.conffile
                    -- menubar.utils.lookup_icon('accessories-text-editor')
                },
                {
                    "restart",
                    awesome.restart
                    -- menubar.utils.lookup_icon('system-restart')
                }
            },
            nil
        },
        {
            "System",
            {
                {
                    "Lock",
                    "slimlock"
                    -- menubar.utils.lookup_icon("system-lock")
                },
                {
                    "Logout",
                    function()
                        awesome.quit()
                    end
                    -- menubar.utils.lookup_icon("system-log-out")
                },
                {
                    "Suspend",
                    "systemctl suspend"
                    -- menubar.utils.lookup_icon("system-suspend")
                },
                -- { 'hibernate', 'systemctl hibernate', menubar.utils.lookup_icon('system-suspend-hibernate') },
                {
                    "Reboot",
                    "systemctl reboot"
                    -- menubar.utils.lookup_icon("system-reboot")
                },
                {
                    "Shutdown",
                    "poweroff"
                    -- menubar.utils.lookup_icon("system-shutdown")
                }
            },
            nil
        }
    }
)



return moudle
