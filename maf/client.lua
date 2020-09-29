local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local menubar = require("menubar")
local clientkeys = require("maf.clientkeys")
local utils = require("utils")
local keydefine = require("maf.keydefine")

client.connect_signal(
    "manage",
    function(c)
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- if not awesome.startup then awful.client.setslave(c) end
        c.shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, 2)
        end
        if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
            -- Prevent clients from being unreachable after screen count changes.
            awful.placement.no_offscreen(c)
        end
    end
)

client.connect_signal(
    "manage",
    function(c)
        if c.class == "VirtualBox Machine" then
            c.border_width = 0
            local tag =
                awful.tag.add(
                c.class,
                {
                    layout = awful.layout.suit.max,
                    screen = screen.primary,
                    gap_single_client = false,
                    gap = 0,
                    volatile = true
                }
            )
            c:move_to_tag(tag)
            tag:view_only()
        end
        local geometry = c:geometry()
        client.mask =
            wibox(
            {
                x = geometry.x,
                y = geometry.y,
                width = geometry.width,
                height = geometry.height,
                bg = "#00007799"
            }
        )
    end
)

client.connect_signal(
    "request::titlebars",
    function(c)
        if c.titlebars_enabled == false then
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
            ),
            awful.button(
                {keydefine.modkey},
                1,
                function()
                    client.focus = c
                    c:raise()
                    utils.client.reset_major_color(c)
                end
            ),
            awful.button(
                {keydefine.modkey},
                2,
                function()
                    client.focus = c
                    c:raise()
                    c.floating = not c.floating
                end
            )
        )
        local title_text_widget = awful.titlebar.widget.titlewidget(c)
        title_text_widget.align = "center"
        top_titlebar:setup {
            {
                -- Left
                awful.titlebar.widget.ontopbutton(c),
                awful.titlebar.widget.floatingbutton(c),
                awful.titlebar.widget.stickybutton(c),
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
        local function update_color(c)
            local color = utils.client.get_major_color(c)
            -- local luminance = utils.color.relative_luminance(color)
            -- local lighten_amount = luminance * 90 + 10
            -- local darken_amount = -(luminance * 70) + 100
            -- local inner_color = utils.color.lighten(color, lighten_amount)
            -- local outer_color = utils.color.darken(color, darken_amount)

            -- local major_color =
            --     gears.color.create_pattern(
            --     {
            --         type = "linear",
            --         from = {10, 0, 1},
            --         to = {0, 25, 1},
            --         stops = {{0, "#000000"}, {0.01, "#ffffff"}, {1, "#232323"}}
            --     }
            -- )

            top_titlebar:set_bg(color)
            top_titlebar:set_fg(utils.client.get_fg_color(c))
        end
        c:connect_signal("reset_major_color", update_color)
        c:connect_signal("focus", update_color)
        c:connect_signal("unfocus", update_color)
    end
)

client.connect_signal(
    "focus",
    function(c)
        c.border_color = beautiful.border_focus
    end
)
client.connect_signal(
    "unfocus",
    function(c)
        c.border_color = beautiful.border_normal
    end
)

local icon_map = {}
icon_map["code-oss"] = "code"
icon_map["alacritty"] = "terminal"
icon_map["jetbrains-idea"] = "idea"
icon_map["neovide"] = "nvim"

client.connect_signal(
    "manage",
    function(c)
        if c.instance ~= nil then
            local instance = c.instance:lower()
            local prefer_icon = menubar.utils.lookup_icon(icon_map[instance] or instance)
            local icon = menubar.utils.lookup_icon(c.instance)
            local lower_icon = menubar.utils.lookup_icon(c.instance:lower())

            -- gears.debug.dump(icon, c.instance, 2)

            --Check if the icon exists
            if prefer_icon ~= nil then
                --Check if the icon exists in the lowercase variety
                local temp_icon = gears.surface(prefer_icon)
                c.icon = temp_icon._native
            elseif icon ~= nil then
                --Check if the icon exists in the lowercase variety
                local temp_icon = gears.surface(icon)
                c.icon = temp_icon._native
            elseif lower_icon ~= nil then
                --Check if the client already has an icon. If not, give it a default.
                local temp_icon = gears.surface(lower_icon)
                c.icon = temp_icon._native
            elseif c.icon == nil then
                local temp_icon = gears.surface(menubar.utils.lookup_icon("application-default-icon"))
                c.icon = temp_icon._native
            end
        end
    end
)

-- client.connect_signal(
--     "mouse::move",
--     function(c)
--         gears.debug.dump(os.time() .. "move", "------", 1)
--         gears.debug.dump(c.cursor, "------", 1)

--         if not mousegrabber.isrunning() then
--             mousegrabber.run(
--                 function()
--                 end,
--                 "arrow"
--             )
--         end
--     end
-- )

local module = {}

function border_resize(c)
    client.focus = c
    c:raise()
    local coords = mouse.coords()
    if coords == nil then
        return
    end
    if c == nil then
        return
    end
    local geometry = c:geometry()
    local range = 5
    if
        (coords.x < geometry.x + range and coords.y < geometry.y + range) or --left top
            (coords.x > geometry.x + geometry.width - range and coords.y < geometry.y + range) or --right top
            (coords.x < geometry.x + range and coords.y > geometry.y + geometry.height - range) or --left bottom
            (coords.x > geometry.x + geometry.width - range and coords.y > geometry.y + geometry.height - range)
     then
        awful.mouse.client.resize(c)
    end
end

local clientbuttons =
    gears.table.join(
    awful.button({}, 1, border_resize),
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
            placement = awful.placement.centered,
            titlebars_enabled = true,
            tag = "normal",
            switchtotag = true
        }
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
    },
    {
        rule_any = {
            class = {
                "Wine"
            }
        },
        properties = {
            border_width = 0
        }
    },
    -- tag
    {
        rule_any = {
            class = {
                "Chromium"
            }
        },
        properties = {tag = "read"}
    },
    -- tag
    {
        rule_any = {
            class = {
                "Alacritty"
            }
        },
        properties = {tag = "terminal", switchtotag = true}
    },
    -- tag
    {
        rule_any = {
            class = {
                "Emacs"
            }
        },
        properties = {
            tag = "code",
            size_hints_honor = false,
            switchtotag = true
        }
    }
}





return module
