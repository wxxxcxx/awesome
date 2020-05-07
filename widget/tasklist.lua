local awful = require("awful")
local wibox = require("wibox")
local client_preview =require('widget.clientpreview')

local module = {}

local tasklist_buttons =
    gears.table.join(
    awful.button(
        {},
        1,
        function(c)
            if not (module.tasklist_menu == nil) then
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
            if not (module.tasklist_menu == nil) then
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
            module.tasklist_menu:show(
                {
                    -- coords = mouse.current_widget_geometry
                }
            )
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
    local preview = client_preview.new({
        screen = screen
    })
    local tasklist =
        awful.widget.tasklist {
        screen = screen,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style={
            shape  = gears.shape.rounded_rect,
        },
        layout = {
            spacing = 0,
            forced_num_rows = 1,
            layout = wibox.layout.grid.horizontal
        },
        widget_template = {
            {
                {
                    {
                        {
                            id = "icon_role",
                            image = beautiful.awesome_icon,
                            -- forced_height = 48,
                            -- forced_width = 48,
                            widget = wibox.widget.imagebox
                        },
                        left = 5,
                        right = 5,
                        top = 4,
                        bottom = 4,
                        widget = wibox.container.margin
                    },
                    {
                        widget = wibox.widget.imagebox
                    },
                    {
                        {
                            widget = wibox.widget.imagebox
                        },
                        id = "indicator",
                        forced_height = 2,
                        bg = "#000000",
                        widget = wibox.container.background
                    },
                    fill_space = true,
                    -- {id = 'text_role', widget = wibox.widget.textbox},
                    layout = wibox.layout.fixed.vertical
                },
                widget = wibox.container.margin
            },
            id = "background_role",
            -- forced_width = 200,
            widget = wibox.container.background,
            create_callback = function(self, c, index, clients)
                if c == client.focus then
                    self:get_children_by_id("indicator")[1].bg = beautiful.tasklist_indicator_focus
                else
                    self:get_children_by_id("indicator")[1].bg = "#00000000"
                end
                self:connect_signal(
                    "mouse::enter",
                    function()
                        preview.show(c,self)
                    end
                )
                self:connect_signal(
                    "mouse::leave",
                    function()
                        preview.hide(c,nil)
                    end
                )
            end,
            update_callback = function(self, c, index, objects) --luacheck: no unused args
                if c == client.focus then
                    self:get_children_by_id("indicator")[1].bg = beautiful.tasklist_indicator_focus
                else
                    self:get_children_by_id("indicator")[1].bg = "#00000000"
                end
            end
        }
    }
    return tasklist
end

return module
