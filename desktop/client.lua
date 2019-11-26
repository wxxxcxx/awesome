local awful = require('awful')
local wibox = require('wibox')
local clientkeys = require('desktop.clientkeys')
local utils = require('desktop.utils')

client.connect_signal(
    'manage',
    function(c)
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- if not awesome.startup then awful.client.setslave(c) end
        -- c.shape = function(cr, w, h)
        --     gears.shape.rounded_rect(cr, w, h, 2)
        -- end
        if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
            -- Prevent clients from being unreachable after screen count changes.
            awful.placement.no_offscreen(c)
        end
    end
)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal(
    'request::titlebars',
    function(c)
        local top_titlebar =
            awful.titlebar(
            c,
            {
                size = 30
            }
        )
        -- buttons for the titlebar
        local buttons =
            gears.table.join(
            awful.button(
                {},
                1,
                function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end
            ),
            awful.button(
                {},
                3,
                function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end
            )
        )
        top_titlebar:setup {
            {
                -- Left
                {
                    awful.titlebar.widget.iconwidget(c),
                    buttons = buttons,
                    left = 10,
                    top = 5,
                    bottom = 5,
                    right = 15,
                    widget = wibox.container.margin
                },
                awful.titlebar.widget.ontopbutton(c),
                awful.titlebar.widget.floatingbutton(c),
                awful.titlebar.widget.stickybutton(c),
                layout = wibox.layout.fixed.horizontal()
            },
            {
                -- Middle
                {
                    -- Title
                    align = 'center',
                    widget = awful.titlebar.widget.titlewidget(c)
                },
                buttons = buttons,
                layout = wibox.layout.flex.horizontal
            },
            {
                -- Right
                awful.titlebar.widget.minimizebutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.closebutton(c),
                layout = wibox.layout.fixed.horizontal()
            },
            layout = wibox.layout.align.horizontal
        }
    end
)

client.connect_signal(
    'focus',
    function(c)
        c.border_color = beautiful.border_focus
        utils.hide_all_menu()
    end
)
client.connect_signal(
    'unfocus',
    function(c)
        c.border_color = beautiful.border_normal
    end
)

local module = {}

local clientbuttons =
    gears.table.join(
    awful.button(
        {},
        1,
        function(c)
            client.focus = c
            c:raise()
            utils.hide_all_menu()
        end
    ),
    awful.button({keydefine.modkey}, 1, awful.mouse.client.move),
    awful.button({keydefine.modkey}, 3, awful.mouse.client.resize)
)

module.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            size_hints_honor = false, -- Remove gaps between terminals
            screen = awful.screen.preferred,
            callback = awful.client.setslave,
            placement = awful.placement.centered,
            titlebars_enabled = false
        }
    }, -- Floating clients.
    {
        rule_any = {
            instance = {
                'DTA', -- Firefox addon DownThemAll.
                'copyq', -- Includes session name in class.
                'pinentry'
            },
            class = {
                'Arandr',
                'Blueman-manager',
                'Gpick',
                'Kruler',
                'MessageWin', -- kalarm.
                'Sxiv',
                'Tor Browser', -- Needs a fixed window size to avoid fingerprinting by screen size.
                'Wpa_gui',
                'veromix',
                'xtightvncviewer'
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                'Event Tester', -- xev.
                'win0' -- jetbrains
            },
            role = {
                'AlarmWindow', -- Thunderbird's calendar.
                'ConfigManager', -- Thunderbird's about:config.
                'pop-up' -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = {floating = true}
    },
    -- {
    --     rule = {
    --         class = 'mpv'
    --     },
    --     properties = {
    --         floating = true,
    --         ontop = true,
    --         placement = awful.placement.centered
    --     }
    -- },
    {
        rule_any = {
            class = {
                'VirtualBox Manager',
                'VirtualBox'
            }
        },
        properties = {
            floating = true,
            placement = awful.placement.centered,
            tag = ' w '
        }
    },
    {
        rule = {
            class = 'VirtualBox Machine'
        },
        properties = {
            floating = false,
            placement = awful.placement.centered,
            tag = ' w '
        }
    }
}

return module
