local awful = require("awful")
local wibox = require("wibox")
local menubar = require("menubar")

local module = {}
module.instance_widget =
    wibox.widget {
    widget = wibox.container.background
}
module.icon_widget =
    wibox.widget {
    widget = wibox.container.background
}
module.title_widget =
    wibox.widget {
    widget = wibox.container.background
}
module.botton_widget =
    wibox.widget {
    widget = wibox.container.background
}

client.connect_signal(
    "focus",
    function(c)
        local buttons =
            gears.table.join(
            awful.button(
                {},
                1,
                function()
                    -- mouse.coords(
                    --     {
                    --         x = c.x + (c.width / 2),
                    --         y = c.y
                    --     }
                    -- )
                    -- client.focus = c
                    -- c:raise()
                    -- awful.mouse.client.move(c)
                end
            ),
            awful.button(
                {},
                3,
                function()
                    -- mouse.coords(
                    --     {
                    --         -- x = c.x + (c.width / 2),
                    --         y = c.y + c.height
                    --     }
                    -- )
                    -- client.focus = c
                    -- c:raise()
                    -- awful.mouse.client.resize(c)
                end
            )
        )
        local instance_text = (c.instance or ""):upper()
        local instance =
            wibox.widget {
            markup = "<b>[" .. instance_text .. "]</b>",
            align = "center",
            valign = "center",
            widget = wibox.widget.textbox
        }
        module.instance_widget:setup {
            instance,
            buttons = buttons,
            left = 3,
            -- bottom = 2,
            widget = wibox.container.margin
        }

        module.icon_widget:setup {
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            top = 5,
            bottom = 5,
            left = 10,
            right = 3,
            widget = wibox.container.margin
        }
        module.title_widget:setup {
            {
                awful.titlebar.widget.titlewidget(c),
                buttons = buttons,
                left = 10,
                -- bottom = 2,
                widget = wibox.container.margin
            },
            layout = wibox.layout.fixed.horizontal()
        }
        module.botton_widget:setup {
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.stickybutton(c),
            awful.titlebar.widget.minimizebutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal()
        }
    end
)
client.connect_signal(
    "unfocus",
    function(c)
        module.instance_widget:setup {
            widget = wibox.container.background
        }
        module.icon_widget:setup {
            widget = wibox.container.background
        }
        module.title_widget:setup {
            widget = wibox.container.background
        }
        module.botton_widget:setup {
            widget = wibox.container.background
        }
    end
)

return module
