local awful = require("awful")
local wibox = require("wibox")
local utils = require("utils")

local module = {}

root.buttons(
    gears.table.join(
        root.buttons(),
        awful.button(
            {},
            1,
            function()
                if module.tasklist_menu then
                    module.tasklist_menu:hide()
                end
            end
        ),
        awful.button(
            {},
            3,
            function()
                if module.tasklist_menu then
                    module.tasklist_menu:hide()
                end
            end
        )
    )
)
client.connect_signal(
    "button::press",
    function(c)
        if module.tasklist_menu then
            module.tasklist_menu:hide()
        end
    end
)

local buttons =
    gears.table.join(
    awful.button(
        {},
        1,
        function(c)
            if module.tasklist_menu then
                module.tasklist_menu:hide()
            end
            if c == client.focus then
                c.minimized = true
            else
                -- Without this, the following
                -- :isvisible() makes no sense
                c.minimized = false
                if not c:isvisible() and c.first_tag then
                    c.first_tag:view_only()
                end
                -- This will also un-minimize
                -- the client, if needed
                client.focus = c
                c:raise()
            end
        end
    ),
    awful.button(
        {},
        3,
        function(c)
            if module.tasklist_menu then
                module.tasklist_menu:hide()
            end
            module.tasklist_menu =
                awful.menu(
                {
                    {
                        c.sticky == true and "> Sticky" or "  Sticky",
                        function()
                            c.sticky = not c.sticky
                        end
                    },
                    {
                        c.floating == true and "> Floating" or "  Floating",
                        function()
                            c.floating = not c.floating
                        end
                    },
                    {
                        c.ontop == true and "> Ontop" or "  Ontop",
                        function()
                            c.ontop = not c.ontop
                        end
                    },
                    {
                        c.minimized == true and "> Minimized" or "  Minimized",
                        function()
                            c.minimized = not c.minimized
                        end
                    },
                    {
                        c.maximized == true and "> Maximized" or "  Maximized",
                        function()
                            c.maximized = not c.maximized
                        end
                    },
                    {
                        "  Close",
                        function()
                            c:kill()
                        end
                    }
                }
            )
            module.tasklist_menu:show({})
        end
    ),
    awful.button(
        {},
        4,
        function()
            awful.client.focus.byidx(-1)
        end
    ),
    awful.button(
        {},
        5,
        function()
            awful.client.focus.byidx(1)
        end
    )
)

function module.new(args)
    local args = args or {}
    local screen = args.screen
    local layout = args.layout or wibox.layout.fixed.horizontal

    local tasklist =
        awful.widget.tasklist {
        screen = screen,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = buttons,
        style = {},
        layout = {
            spacing = 0,
            layout = layout
        },
        widget_template = {
            {
                {
                    wibox.widget.base.empty_widget(),
                    {
                        {
                            {
                                id = "icon_role",
                                image = beautiful.awesome_icon,
                                widget = wibox.widget.imagebox
                            },
                            valign = "center",
                            halign = "center",
                            widget = wibox.container.place
                        },
                        left = 3,
                        right = 3,
                        top = 7,
                        bottom = 2,
                        widget = wibox.container.margin
                    },
                    {
                        {
                            {
                                widget = wibox.widget.base.empty_widget(),
                                forced_height = 2,
                                
                            },
                            id = "background_role",
                            shape = gears.shape.rounded_rect,
                            widget = wibox.container.background
                        },
                        id = "indicator",
                        widget = wibox.container.margin
                    },
                    fill_space = false,
                    layout = wibox.layout.align.vertical
                },
                widget = wibox.container.background
            },
            margins = 0,
            widget = wibox.container.margin
        }
    }
    return tasklist
end

return setmetatable(
    module,
    {
        __call = function(_, ...)
            return module.new(...)
        end
    }
)
