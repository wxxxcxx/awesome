local awful = require("awful")
local wibox = require("wibox")
local utils = require("utils")

local dpi = beautiful.xresources.apply_dpi

local module = {}

root.buttons(gears.table.join(root.buttons(), awful.button({}, 1, function()
    if module.tasklist_menu then
        module.tasklist_menu:hide()
    end
end), awful.button({}, 3, function()
    if module.tasklist_menu then
        module.tasklist_menu:hide()
    end
end)))
client.connect_signal("button::press", function(c)
    if module.tasklist_menu then
        module.tasklist_menu:hide()
    end
end)

local buttons = gears.table.join(awful.button({}, 1, function(c)
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
end), awful.button({}, 3, function(c)
    if module.tasklist_menu then
        module.tasklist_menu:hide()
    end
    module.tasklist_menu = awful.menu({{c.sticky == true and "> Sticky" or "  Sticky", function()
        c.sticky = not c.sticky
    end}, {c.floating == true and "> Floating" or "  Floating", function()
        c.floating = not c.floating
    end}, {c.ontop == true and "> Ontop" or "  Ontop", function()
        c.ontop = not c.ontop
    end}, {c.minimized == true and "> Minimized" or "  Minimized", function()
        c.minimized = not c.minimized
    end}, {c.maximized == true and "> Maximized" or "  Maximized", function()
        c.maximized = not c.maximized
    end}, {"  Close", function()
        c:kill()
    end}})
    module.tasklist_menu:show({})
end), awful.button({}, 4, function()
    awful.client.focus.byidx(-1)
end), awful.button({}, 5, function()
    awful.client.focus.byidx(1)
end))

function module.new(args)
    local args = args or {}
    local screen = args.screen

    local tasklist = awful.widget.tasklist {
        screen = screen,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = buttons,
        style = {
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 8)
            end,
            shape_border_width = dpi(1),
            shape_border_color = beautiful.tasklist_bg
        },
        layout = {
            spacing = dpi(4),
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {

            {
                {
                    {

                        {
                            {
                                id = "icon_role",
                                -- image = beautiful.awesome_icon,
                                resize = true,
                                widget = wibox.widget.imagebox
                            },
                            id = "icon_margin_role",
                            widget = wibox.container.margin,
                            left = dpi(4),
                            right = dpi(8),
                            top = dpi(3),
                            bottom = dpi(3)
                        },
                        {

                            {
                                id = "text_role",
                                widget = wibox.widget.textbox
                            },
                            id = "text_margin_role",
                            widget = wibox.container.margin,
                            left = dpi(4),
                            right = dpi(8),
                            top = dpi(2),
                            bottom = dpi(2)
                        },
                        layout = wibox.layout.fixed.horizontal
                    },
                    widget = wibox.container.margin,
                    left = dpi(4),
                    right = dpi(4)
                },
                id = "background_role",
                widget = wibox.container.background
            },
            widget = wibox.container.margin,
            margins = dpi(1),
            forced_width = dpi(150)
        }
    }
    return {
        tasklist,
        top = dpi(2),
        bottom = dpi(2),
        left = dpi(10),
        right = dpi(10),
        widget = wibox.container.margin
    }
end

return setmetatable(module, {
    __call = function(_, ...)
        return module.new(...)
    end
})
