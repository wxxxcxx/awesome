local awful = require("awful")
local wibox = require("wibox")

local keydefine = require("maf.keydefine")

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

    local icon_map = {}
    icon_map["normal"] = ""
    icon_map["terminal"] = ""
    icon_map["read"] = ""
    icon_map["code"] = ""

    local taglist =
        awful.widget.taglist {
        screen = screen,
        filter = awful.widget.taglist.filter.all,
        layout = {
            spacing = 0,
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    nil,
                    {
                        {
                            {
                                id = "text",
                                widget = wibox.widget.textbox
                            },
                            layout = wibox.layout.fixed.horizontal
                        },
                        left = 5,
                        right = 5,
                        top = 5,
                        bottom = 5,
                        widget = wibox.container.margin
                    },
                    {
                        {
                            {
                                widget = wibox.widget.base.empty_widget(),
                                forced_height = 2
                            },
                            id = "background_role",
                            shape = gears.shape.rounded_rect,
                            widget = wibox.container.background
                        },
                        widget = wibox.container.margin
                    },
                    layout = wibox.layout.align.vertical
                },
                widget = wibox.container.background
            },
            margins = 0,
            widget = wibox.container.margin,
            create_callback = function(self, tag, index, objects) --luacheck: no unused args
                local textbox = self:get_children_by_id("text")[1]
                textbox.text = icon_map[tag.name] or ""
                textbox.markup = icon_map[tag.name] or ""
            end,
            update_callback = function(self, tag, index, objects) --luacheck: no unused args
                local textbox = self:get_children_by_id("text")[1]
                textbox.text = icon_map[tag.name] or ""
                textbox.markup = icon_map[tag.name] or ""
            end
        },
        buttons = taglist_buttons
    }

    return taglist
end

return module
