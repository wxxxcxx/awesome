local awful = require("awful")
local wibox = require("wibox")
local utils = require("utils")

local client_preview = require("widget.clientpreview")
local preview =
    client_preview.new(
    {
        screen = screen
    }
)

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
    local height = args.height or 70

    local task_switcher = {
        current = 1,
        map = {}
    }

    function task_switcher:next()
        for i, m in self.map do
            if m.client.valid then
                if m.client == client.focus then
                    self.current = i
                end
            end
        end
    end

    local tasklist =
        awful.widget.tasklist {
        screen = screen,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style = {
            shape = gears.shape.rounded_rect
        },
        layout = {
            spacing = 0,
            forced_num_rows = 1,
            forced_height = height,
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    {
                        {
                            {
                                id = "icon_role",
                                image = beautiful.awesome_icon,
                                widget = wibox.widget.imagebox,
                                forced_height = (height - 22)
                            },
                            valign = "center",
                            halign = "center",
                            widget = wibox.container.place
                        },
                        left = 5,
                        right = 5,
                        top = 4,
                        bottom = 0,
                        widget = wibox.container.margin
                    },
                    {
                        {
                            {
                                widget = wibox.widget.base.empty_widget(),
                                forced_height = 4,
                                forced_width = 4
                            },
                            id = "indicator",
                            bg = "#00000000",
                            shape = gears.shape.rounded_rect,
                            widget = wibox.container.background
                        },
                        valign = "center",
                        halign = "center",
                        widget = wibox.container.place
                    },
                    fill_space = false,
                    layout = wibox.layout.fixed.vertical
                },
                id = "background_role",
                widget = wibox.container.background
            },
            margins = 5,
            widget = wibox.container.margin,
            create_callback = function(self, c, index, clients)
                if c == client.focus then
                    self:get_children_by_id("indicator")[1].bg = beautiful.tasklist_indicator_focus
                else
                    self:get_children_by_id("indicator")[1].bg = "#00000000"
                end
                self:connect_signal(
                    "mouse::enter",
                    function()
                        local x, y, w, h = utils.get_widget_postion(args.wibox, self)
                        preview.show(x + (w / 2), screen.geometry.height - height - 30, c)
                    end
                )
                self:connect_signal(
                    "mouse::leave",
                    function()
                        preview.hide()
                    end
                )
            end,
            update_callback = function(self, c, index, objects) --luacheck: no unused args
                if c == client.focus then
                    self:get_children_by_id("indicator")[1].bg = beautiful.tasklist_indicator_focus
                else
                    self:get_children_by_id("indicator")[1].bg = "#00000000"
                end

                task_switcher.map[c] = self
            end
        }
    }
    return tasklist
end

return module
