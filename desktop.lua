require('awful.autofocus')

local awful = require('awful')
local gears = require('gears')
local error = require('error')
local bar = require('bar')
local globalkeys = require('globalkeys')
local globalmenu = require('globalmenu')
local client_config = require('client')
local utils = require('utils')


awful.mouse.resize.set_mode('live')
awful.mouse.snap.edge_enabled = false
awful.mouse.snap.client_enabled = false
awful.mouse.drag_to_tag.enabled = false
root.keys(globalkeys)

root.buttons(root.buttons())
awful.rules.rules = client_config.rules
-- awful.layout.append_default_layouts(awful.layout.suit.floating)
-- awful.layout.append_default_layouts(awful.layout.suit.tile.left)
-- awful.layout.append_default_layouts(awful.layout.suit.tile)
-- awful.layout.append_default_layouts(awful.layout.suit.spiral.dwindle)
awful.layout.layouts = {
    awful.layout.suit.floating,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.tile.top,
    awful.layout.suit.tile.left
    -- awful.layout.suit.tile,
    -- awful.layout.suit.tile.bottom
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.spiral.dwindle
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

local module = {}

local function set_wallpaper(screen)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == 'function' then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, screen, true)
    end
end

function module:init()
    error:init()

    -- screen.connect_signal('property::geometry', set_wallpaper)
    awful.screen.connect_for_each_screen(
        function(screen)
            set_wallpaper(screen)

            awful.tag.add(
                'normal',
                {
                    layout = awful.layout.layouts[1],
                    screen = screen,
                    selected = true
                }
            )
            awful.tag.add(
                'view',
                {
                    layout = awful.layout.layouts[2],
                    screen = screen,
                    selected = false
                }
            )
            awful.tag.add(
                'work',
                {
                    layout = awful.layout.layouts[2],
                    screen = screen,
                    selected = false
                }
            )
        end
    )
    local default_bar = bar:new({screen = screen.primary})
end

return module
