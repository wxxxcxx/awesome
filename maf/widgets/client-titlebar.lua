local awful = require('awful')
local wibox = require('wibox')
local menubar = require('menubar')

local module =
    wibox.widget {
    widget = wibox.container.margin
}

client.connect_signal(
    'focus',
    function(c)
        local buttons =
            gears.table.join(
            awful.button(
                {},
                1,
                function()
                    mouse.coords(
                        {
                            x = c.x + (c.width / 2),
                            y = c.y
                        }
                    )
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end
            ),
            awful.button(
                {},
                3,
                function()
                    mouse.coords(
                        {
                            -- x = c.x + (c.width / 2),
                            y = c.y + c.height
                        }
                    )
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end
            )
        )
        module:setup {
            {
                -- Left
                {
                    -- awful.titlebar.widget.iconwidget(c),
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
    'unfocus',
    function(c)
        module:setup {
            widget = wibox.container.margin
        }
    end
)

return module
