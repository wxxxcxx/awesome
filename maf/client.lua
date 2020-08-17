local awful = require("awful")
local wibox = require("wibox")
local menubar = require("menubar")
local clientkeys = require("maf.clientkeys")
local utils = require("maf.utils")
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
        c.border_width = 0
        if c.class == "VirtualBox Machine" then
            local tag =
                awful.tag.add(
                "VirtualBox Machine",
                {
                    layout = awful.layout.suit.max.fullscreen,
                    screen = screen.primary,
                    gap_single_client = false,
                    gap = 0,
                    volatile = true
                }
            )
            c:move_to_tag(tag)
            tag:view_only()
        end
    end
)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
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
                size = 5,
                position = "top"
            }
        )
        local bottom_titlebar =
            awful.titlebar(
            c,
            {
                size = 5,
                position = "bottom"
            }
        )
        local left_titlebar =
            awful.titlebar(
            c,
            {
                size = 5,
                position = "left"
            }
        )
        local right_titlebar =
            awful.titlebar(
            c,
            {
                size = 5,
                position = "right"
            }
        )

        c:connect_signal(
            "focus",
            function(c)
                top_titlebar:set_bg(beautiful.titlebar_bg_focus)
                bottom_titlebar:set_bg(beautiful.titlebar_bg_focus)
                left_titlebar:set_bg(beautiful.titlebar_bg_focus)
                right_titlebar:set_bg(beautiful.titlebar_bg_focus)
            end
        )
        c:connect_signal(
            "unfocus",
            function(c)
                top_titlebar:set_bg(beautiful.titlebar_bg_normal)
                bottom_titlebar:set_bg(beautiful.titlebar_bg_normal)
                left_titlebar:set_bg(beautiful.titlebar_bg_normal)
                right_titlebar:set_bg(beautiful.titlebar_bg_normal)
            end
        )
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
        -- right bottom
        awful.mouse.client.resize(c)
    elseif coords.y < geometry.y + range then
        awful.mouse.client.move(c)
    elseif coords.x < geometry.x + range then
        awful.mouse.client.resize(c, "left")
    elseif coords.x > geometry.x + geometry.width - range then
        awful.mouse.client.resize(c, "right")
    elseif coords.y > geometry.y + geometry.height - range then
        awful.mouse.client.resize(c, "bottom")
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
            titlebars_enabled = false,
            tag = "normal",
            switchtotag = true
        }
    }, -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA", -- Firefox addon DownThemAll.
                "copyq", -- Includes session name in class.
                "pinentry"
            },
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
                "Anki"
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester", -- xev.
                "win0" -- jetbrains
            },
            role = {
                "AlarmWindow", -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = {floating = true}
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
        properties = {tag = "code", switchtotag = true}
    }
}

return module
