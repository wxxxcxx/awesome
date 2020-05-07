local awful = require('awful')
local wibox = require('wibox')

local module = {}

local taglist_buttons =
    gears.table.join(
    awful.button(
        {},
        1,
        function(t)
            t:view_only()
        end
    ),
    awful.button(
        {keydefine.modkey},
        1,
        function(t)
            -- local t = awful.screen.focused().selected_tag
            if not t then
                return
            end

            t:delete()
        end
    ),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button(
        {keydefine.modkey},
        3,
        function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end
    ),
    awful.button(
        {},
        4,
        function(t)
            awful.tag.viewprev(t.screen)
        end
    ),
    awful.button(
        {},
        5,
        function(t)
            awful.tag.viewnext(t.screen)
        end
    )
)

function module.new(args)
    local args = args or {}
    local screen = args.screen

    local taglist =
        awful.widget.taglist {
        screen = screen,
        filter = awful.widget.taglist.filter.all,
        layout = {
            spacing = 2,
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    {
                        {
                            widget = wibox.widget.textbox
                        },
                        id = 'index_role',
                        margins = 4,
                        widget = wibox.container.margin
                    },
                    id = 'background_role',
                    shape = gears.shape.circle,
                    widget = wibox.container.background
                },
                halign = 'center',
                widget = wibox.container.place
            },
            margins = 0,
            forced_width = 10,
            -- margins = 10,
            widget = wibox.container.margin,
            -- Add support for hover colors and an index label
            create_callback = function(self, t, index, tags) --luacheck: no unused args
                if t.selected then
                    self:get_children_by_id('index_role')[1].margins = 6
                else
                    self:get_children_by_id('index_role')[1].margins = 3
                end
                self:connect_signal(
                    'mouse::enter',
                    function()
                        if not t.selected then
                            self:get_children_by_id('index_role')[1].margins = 6
                        end
                    end
                )
                self:connect_signal(
                    'mouse::leave',
                    function()
                        if not t.selected then
                            self:get_children_by_id('index_role')[1].margins = 3
                        end
                    end
                )
            end,
            update_callback = function(self, t, index, tags) --luacheck: no unused args
                if t.selected then
                    self:get_children_by_id('index_role')[1].margins = 6
                else
                    self:get_children_by_id('index_role')[1].margins = 3
                end
            end
        },
        buttons = taglist_buttons
    }

    local add_tag_buttons =
        gears.table.join(
        awful.button(
            {},
            1,
            function()
                awful.tag.add(
                    'NewTag',
                    {
                        screen = screen,
                        layout = awful.layout.suit.floating
                    }
                ):view_only()
            end
        )
    )

    local add_text =
        wibox.widget {
        markup = utf8.char(0xe3f1),
        font = 'Noto Sans Regular 10',
        align = 'center',
        valign = 'center',
        visible = false,
        widget = wibox.widget.textbox
    }

    local tag =
        wibox.widget {
        taglist,
        {
            add_text,
            left = 5,
            right = 5,
            buttons = add_tag_buttons,
            forced_width = 30,
            widget = wibox.container.margin
        },
        layout = wibox.layout.fixed.horizontal
    }
    tag:connect_signal(
        'mouse::enter',
        function()
            add_text.visible = true
        end
    )
    tag:connect_signal(
        'mouse::leave',
        function()
            add_text.visible = false
        end
    )
    return tag
end

return module
