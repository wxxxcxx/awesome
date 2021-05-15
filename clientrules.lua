local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local menubar = require('menubar')
local utils = require('utils')
local keydefine = require('keydefine')
local dpi = beautiful.xresources.apply_dpi

local clientkeys = require('clientkeys')
local clientbuttons = require('clientbuttons')

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

    if d.transient_for then
        -- args.parent = nil
        args.parent = d.transient_for
    elseif d.instance ~= nil and client.focus ~= nil and d.instance == client.focus.instance then
        args.parent = client.focus
        args.offset = {
            x = dpi(30),
            y = dpi(30),
            width = 0,
            height = 0
        }
    else
        args.parent = screen.primary
    end

    if d.fullscreen == true then
        args.parent = nil
        args.offset = {x = 0, y = 0, width = 0, height = 0}
    elseif d.maximized == true then
        args.parent = nil
        args.offset = {x = 0, y = 0, width = 0, height = 0}
        args.honor_workarea = true
    end
    -- notify(gears.debug.dump_return(args,"==",2))
    return awful.placement.centered(d, args)
end

local module = {
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
            tag = 'normal'
        },
        callback = function(c)
            if c.transient_for then
                c:move_to_tag(c.transient_for.first_tag)
            end
            if c.skip_taskbar then
                c.floating = true
            end
        end
    },
    -- Floating clients.
    {rule_any = {class = {}}, properties = {floating = true}},
    -- Sticky clients
    {rule_any = {class = {}}, properties = {sticky = true}},
    -- OnTop clients
    {rule_any = {class = {}}, properties = {ontop = true}},
    {
        rule_any = {
            instance = {'chromium', 'google-chrome'},
            class = {'firefox', 'qutebrowser', 'Chromium', 'Zathura'}
        },
        properties = {tag = 'view'}
    },
    {
        rule_any = {
            class = {'jetbrains-studio', 'QtCreator'},
            instance = {
                'jetbrains-idea',
                'jetbrains-datagrip',
                'emacs',
                'code',
                'code-oss'
            }
        },
        properties = {tag = 'work'}
    },
    {
        rule = {instance = 'VirtualBox Machine'},
        properties = {
            maximized = true,
            titlebars_enabled = false,
            border_width = 0
        },
        callback = create_tag
    }
}
-- GLava
-- table.insert(
--     module,
--     {
--         rule = {
--             class = 'GLava'
--         },
--         properties = {
--            type = "utility",
--            fullscreen = true,
--            maximized = true,
--            x = 0,
--            y = 0,
--            width = screen.primary.geometry.width
--         }
--     }
-- )
-- Alacritty
-- table.insert(
--     module,
--     {
--         rule = {
--             class = 'Alacritty'
--         },
--         properties = {
--             sticky = true,
--             floating = true,
--             switchtotag = false
--         }
--     }
-- )
-- polkit-dumb-agent
table.insert(
    module,
    {
        rule = {
            class = ' polkit-dumb-agent'
        },
        properties = {
            sticky = true,
            floating = true,
            switchtotag = false
        }
    }
)
-- Firefox
table.insert(
    module,
    {
        rule = {
            class = 'firefox',
            type = 'utility'
        },
        properties = {sticky = true}
    }
)
-- Enpass
table.insert(
    module,
    {
        rule = {class = 'Enpass'},
        properties = {
            sticky = true,
            switchtotag = false
        }
    }
)
-- Ranger dragon
table.insert(
    module,
    {
        rule = {class = 'Dragon-drag-and-drop'},
        properties = {ontop = true, sticky = true}
    }
)
-- Android Emulator
table.insert(
    module,
    {
        rule = {name = 'Emulator', type = 'utility'},
        properties = {sticky = false, ontop = false, skip_taskbar = true}
    }
)
table.insert(
    module,
    {
        rule = {name = 'Android Emulator.+'},
        properties = {ontop = false}
    }
)
-- Netease music
table.insert(
    module,
    {
        rule = {class = 'OSD Lyrics'},
        properties = {
            ontop = true,
            float = true,
            x = 500,
            placement = awful.placement.bottom
        }
    }
)

return module
