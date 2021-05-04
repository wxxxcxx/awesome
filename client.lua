local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local menubar = require('menubar')
local clientkeys = require('clientkeys')
local clientrules = require('clientrules')
local utils = require('utils')
local keydefine = require('keydefine')
local dpi = beautiful.xresources.apply_dpi

local module = {}

module.rules = clientrules

client.connect_signal(
    'request::activate',
    function(c)
        if client.focus ~= c then
            client.focus = c
        end
        c:raise()
        c.first_tag.selected = true
    end
)

client.connect_signal(
    'request::titlebars',
    function(c)
        if c.requests_no_titlebar then
            return
        end
        local title_widget = awful.titlebar.widget.titlewidget(c)
        title_widget.font = beautiful.titlebar_font
        local top_titlebar =
            awful.titlebar(
            c,
            {
                size = dpi(25),
                position = 'top'
            }
        )
        local click_times = 0
        local titlebar_buttons =
            gears.table.join(
            awful.button(
                {},
                1,
                function()
                    client.focus = c
                    c:raise()
                    -- 双击
                    click_times = click_times + 1
                    if click_times == 2 then
                        c.maximized = not c.maximized
                        click_times = 0
                        return
                    end
                    gears.timer.weak_start_new(
                        0.20,
                        function()
                            click_times = 0
                        end
                    )
                    awful.mouse.client.move(c)
                end
            ),
            awful.button(
                {},
                2,
                function()
                    client.focus = c
                    c:raise()
                    c.ontop = not c.ontop
                end
            ),
            awful.button(
                {},
                3,
                function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end
            )
        )
        local title_text_widget = awful.titlebar.widget.titlewidget(c)
        title_text_widget.align = 'center'
        top_titlebar:setup {
            {
                -- Left
                {
                    awful.widget.clienticon(c),
                    margins = 5,
                    widget = wibox.container.margin
                },
                {
                    awful.titlebar.widget.ontopbutton(c),
                    margins = 8,
                    widget = wibox.container.margin
                },
                {
                    awful.titlebar.widget.floatingbutton(c),
                    margins = 8,
                    widget = wibox.container.margin
                },
                {
                    awful.titlebar.widget.stickybutton(c),
                    margins = 8,
                    widget = wibox.container.margin
                },
                layout = wibox.layout.fixed.horizontal
            },
            {
                -- Middle
                title_text_widget,
                buttons = titlebar_buttons,
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
        c.top_titlebar = top_titlebar
    end
)

local function update_decoration(c)
    local color = utils.client.get_major_color(c)
    local border_width = beautiful.border_width
    local border_color = color
    local luminance = utils.color.relative_luminance(color)
    if luminance > 0.5 then
        local darken_amount = -(luminance * 70) + 85
        border_color = utils.color.darken(color, darken_amount)
    else
        local lighten_amount = luminance * 90 + 5
        border_color = utils.color.lighten(color, lighten_amount)
    end
    c.border_color = border_color
    if c.top_titlebar then
        c.top_titlebar:set_bg(color)
        c.top_titlebar:set_fg(utils.client.get_fg_color(c))
    end
end
client.connect_signal('reset_major_color', update_decoration)
client.connect_signal('focus', update_decoration)
client.connect_signal('unfocus', update_decoration)

client.connect_signal('unfocus', update_decoration)

client.connect_signal(
    'property::size',
    function(c)
        if c.fullscreen or c.maximized then
            c.border_width = 0
        else
            c.border_width = beautiful.border_width
        end
    end
)

-- client.connect_signal(
--     'manage',
--     function(c)
--         local icon = menubar.utils.lookup_icon(c.instance)
--         local lower_icon = menubar.utils.lookup_icon(c.instance:lower())

--         --Check if the icon exists
--         if icon ~= nil then
--             --Check if the icon exists in the lowercase variety
--             c.icon = gears.surface(icon)._native
--         elseif lower_icon ~= nil then
--             --Check if the client already has an icon. If not, give it a default.
--             c.icon = gears.surface(lower_icon)._native
--         elseif c.icon == nil then
--             c.icon = gears.surface(menubar.utils.lookup_icon('application-default-icon'))._native
--         end
--     end
-- )

return module
