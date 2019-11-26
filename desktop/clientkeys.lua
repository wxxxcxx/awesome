local gears = require('gears')
local awful = require('awful')
local awesomekey = require('desktop.awesomekey')

return gears.table.join(
    awful.key(
        {keydefine.modkey},
        'Return',
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = 'toggle fullscreen', group = 'client'}
    ),
    awesomekey(
        {keydefine.modkey},
        'w',
        {
            {
                {},
                'f',
                function(c)
                    c.floating = not c.floating
                end,
                {description = 'toggle floating', group = 'client'}
            },
            {
                {},
                't',
                function(c)
                    c.ontop = not c.ontop
                end,
                {description = 'toggle keep on top', group = 'client'}
            },
            {
                {},
                'a',
                function(c)
                    awful.titlebar.toggle(c)
                end,
                {description = 'toggle title bar', group = 'client'}
            },
            {
                {},
                'n',
                function(c)
                    c.minimized = true
                end,
                {description = 'minimize', group = 'client'}
            },
            {
                {},
                'm',
                function(c)
                    c.maximized = not c.maximized
                    c:raise()
                end,
                {description = 'maximize', group = 'client'}
            }
        },
        {description = 'client control'}
    ),
    awful.key(
        {keydefine.modkey},
        'q',
        function(c)
            c:kill()
        end,
        {
            description = 'close',
            group = 'client'
        }
    ),
    awful.key(
        {keydefine.modkey, keydefine.shift},
        'Return',
        function(c)
            c:swap(awful.client.getmaster())
        end,
        {description = 'move to master', group = 'client'}
    )
)
