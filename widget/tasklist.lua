local awful = require('awful')
local wibox = require('wibox')

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
                        c.sticky == true and '> Sticky' or '  Sticky',
                        function()
                            c.sticky = not c.sticky
                        end
                    },
                    {
                        c.floating == true and '> Floating' or '  Floating',
                        function()
                            c.floating = not c.floating
                        end
                    },
                    {
                        c.ontop == true and '> Ontop' or '  Ontop',
                        function()
                            c.ontop = not c.ontop
                        end
                    },
                    {
                        c.minimized == true and '> Minimized' or '  Minimized',
                        function()
                            c.minimized = not c.minimized
                        end
                    },
                    {
                        c.maximized == true and '> Maximized' or '  Maximized',
                        function()
                            c.maximized = not c.maximized
                        end
                    },
                    {
                        '  Close',
                        function()
                            c:kill()
                        end
                    }
                }
            )
            module.tasklist_menu:show(
                {
                    coords = mouse.current_widget_geometry
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
    local preview_width = args.preview_width or 300
    local preview_height = args.preview_height or 200

    local preview_widget = wibox.widget.base.make_widget()
    function preview_widget:fit(context, width, height)
        return preview_width, preview_height
    end

    local preview_popup =
        awful.popup {
        widget = {
            preview_widget,
            margins = 10,
            widget = wibox.container.margin
        },
        ontop = true,
        border_color = '#00ff00',
        border_width = 5,
        border_width = 0,
        bg = '#00000055',
        visible = false
    }
    local hide_preview_popup_timer =
        gears.timer {
        timeout = 0.3,
        call_now = false,
        autostart = false,
        single_shot = true,
        callback = function()
            preview_popup.visible = false
        end
    }
    hide_preview_popup_timer:start()
    preview_popup:connect_signal(
        'mouse::enter',
        function()
            hide_preview_popup_timer:stop()
        end
    )
    preview_popup:connect_signal(
        'mouse::leave',
        function()
            hide_preview_popup_timer:again()
        end
    )

    local tasklist =
        awful.widget.tasklist {
        screen = screen,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        -- style={
        --     shape  = gears.shape.rounded_rect,
        -- },
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
                            id = 'icon_role',
                            image = beautiful.awesome_icon,
                            widget = wibox.widget.imagebox
                        },
                        left = 5,
                        right = 5,
                        top = 2,
                        bottom = 2,
                        widget = wibox.container.margin
                    },
                    -- {id = 'text_role', widget = wibox.widget.textbox},
                    layout = wibox.layout.fixed.vertical
                },
                widget = wibox.container.margin
            },
            id = 'background_role',
            -- forced_width = 200,
            widget = wibox.container.background,
            create_callback = function(self, c, index, clients)
                self:connect_signal(
                    'mouse::enter',
                    function()
                        if c.minimized then
                            return
                        end
                        hide_preview_popup_timer:stop()
                        function preview_widget:draw(context, cr, width, height)
                            local tmp = gears.surface(c.content)
                            cr:move_to(0, 0)
                            local sx = preview_width / c.width
                            local sy = preview_height / c.height
                            cr:scale(sx, sy)
                            cr:set_source_surface(tmp, 0, 0)
                            cr:paint()
                            tmp:finish()
                        end
                        preview_popup_buttons =
                            gears.table.join(
                            awful.button(
                                {},
                                1,
                                function()
                                    c.minimized = false
                                    if not c:isvisible() and c.first_tag then
                                        c.first_tag:view_only()
                                    end
                                    -- This will also un-minimize
                                    -- the client, if needed
                                    client.focus = c
                                    c:raise()
                                    preview_popup.visible = false
                                end
                            )
                        )
                        preview_popup:buttons(preview_popup_buttons)
                        if current_widget_geometry then
                            preview_popup.x = mouse.current_widget_geometry.x
                            preview_popup.y = mouse.current_widget_geometry.y + 30
                            preview_popup.visible = true
                        end
                    end
                )
                self:connect_signal(
                    'mouse::leave',
                    function()
                        hide_preview_popup_timer:again()
                    end
                )
            end
        }
    }
    return tasklist
end

return module
