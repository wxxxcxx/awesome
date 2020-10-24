local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local menubar = require("menubar")
local clientkeys = require("maf.clientkeys")
local utils = require("utils")
local keydefine = require("maf.keydefine")

client.connect_signal(
    "request::titlebars",
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
                size = 30,
                position = "top"
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
                        0.25,
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
        title_text_widget.align = "center"
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
        local darken_amount = -(luminance * 70) + 100
        border_color = utils.color.darken(color, darken_amount)
    else
        local lighten_amount = luminance * 90 + 10
        border_color = utils.color.lighten(color, lighten_amount)
    end
    c.border_color = border_color
    if c.top_titlebar then
        c.top_titlebar:set_bg(color)
        c.top_titlebar:set_fg(utils.client.get_fg_color(c))
    end
end
client.connect_signal("reset_major_color", update_decoration)
client.connect_signal("focus", update_decoration)
client.connect_signal("unfocus", update_decoration)

local module = {}

local clientbuttons =
    gears.table.join(
    awful.button(
        {},
        1,
        function(c)
            client.focus = c
            c:raise()
        end
    ),
    awful.button(
        {keydefine.modkey},
        1,
        function(c)
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end
    ),
    awful.button(
        {keydefine.modkey},
        3,
        function(c)
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end
    )
)

local function create_tag(c)
    local tag =
        awful.tag.add(
        c.instance,
        {
            layout = awful.layout.suit.floating,
            screen = screen.primary,
            gap_single_client = false,
            gap = 0,
            volatile = true
        }
    )
    c:move_to_tag(tag)
    tag:view_only()
end

local function placement(d, args)
    local args = args or {}
    args.parent = client.focus or screen.primary
    -- args.margins = {
    --     top = 25,
    --     left = 25
    -- }
    -- if d.maximized then
    --     args.margins.left = 0
    -- end
    -- args.attach = true
    args.store_geometry = true
    -- args.honor_workarea = true
    return awful.placement.centered(d, args)
end

module.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            size_hints_honor = false, -- Remove gaps between terminals
            screen = awful.screen.preferred,
            callback = awful.client.setslave,
            -- placement = awful.placement.centered,
            placement = placement,
            titlebars_enabled = true,
            switchtotag = true,
            tag = "normal"
        },
        callback = function(c)
            if c.transient_for then
                c:move_to_tag(c.transient_for.first_tag)
            end
        end
    }, -- Floating clients.
    {
        rule_any = {
            instance = {},
            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin", -- kalarm.--[[  ]]
                "Sxiv",
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
                "xtightvncviewer",
                "obs",
                "Qq",
                "Peek",
                "Anki",
                "Dragon-drag-and-drop"
            },
            name = {
                "Event Tester", -- xev.
                "win0" -- jetbrains
            },
            role = {
                "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = {floating = true}
    }, -- Sticky clients
    {
        rule_any = {
            class = {
                "Dragon-drag-and-drop"
            },
            type = {
                "utility"
            }
        },
        properties = {sticky = true}
    }, -- OnTop clients
    {
        rule_any = {
            class = {
                "Dragon-drag-and-drop"
            }
        },
        properties = {ontop = true}
    }, -- No border clients
    {
        rule_any = {
            class = {
                "Wine"
            },
            type = {
                "utility"
            }
        },
        properties = {
            border_width = 0
        }
    },
    {
        rule_any = {
            instance = {
                "chromium"
            }
        },
        properties = {
            tag = "view"
        }
    },
    {
        rule_any = {
            instance = {
                "jetbrains-idea",
                "jetbrains-datagrip",
                "emacs",
                "code-oss"
            }
        },
        properties = {
            tag = "work"
        }
    },
    {
        rule_any = {
            class = {
                "VirtualBox Machine"
            }
        },
        callback = create_tag
    },
    {
        rule = {
            class = "scrcpy"
        },
        properties = {
            floating = true
        }
    }
}

return module
