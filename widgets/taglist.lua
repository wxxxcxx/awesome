local awful = require('awful')
local wibox = require('wibox')
local keydefine = require('keydefine')

local dpi = beautiful.xresources.apply_dpi

local module = {}

local taglist_buttons =
    gears.table.join(
    awful.button(
        {},
        1,
        function(t)
            if t.selected then
                awful.tag.viewtoggle(t)
            else
                t:view_only()
            end
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
    -- utf8.char()
    icon_map['normal'] = ''
    icon_map['view'] = ''
    icon_map['work'] = ''

    local taglist =
        awful.widget.taglist {
        screen = screen,
        filter = awful.widget.taglist.filter.all,
        layout = {
            spacing = dpi(5),
            layout = wibox.layout.fixed.horizontal
        },
        style = {
            shape = gears.shape.losange
        },
        widget_template = {
            {
                {
                    widget = wibox.widget.base.empty_widget(),
                    forced_height = dpi(12),
                    forced_width = dpi(12)
                },
                id = 'background_role',
                shape = gears.shape.losange,
                widget = wibox.container.background
            },
            margins = dpi(5),
            widget = wibox.container.margin
        },
        buttons = taglist_buttons
    }

    return wibox.widget {
        {
            {
                taglist,
                left = dpi(5),
                right = dpi(5),
                widget = wibox.container.margin
            },
            bg = beautiful.taglist_bg or '#000000',
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, dpi(8))
            end,
            widget = wibox.container.background
        },
        top = dpi(4),
        bottom = dpi(4),
        left = dpi(10),
        right = dpi(10),
        widget = wibox.container.margin
    }
end

return setmetatable(
    module,
    {
        __call = function(_, ...)
            return module.new(...)
        end
    }
)
