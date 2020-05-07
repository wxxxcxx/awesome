require('awful.autofocus')
local awful = require('awful')
local gears = require('gears')
local error = require('desktop.error')
local bar = require('desktop.bar')
local dock = require('desktop.dock')
local globalkeys = require('desktop.globalkeys')
local client = require('desktop.client')
local utils = require('desktop.utils')
-- local lain = require('lain')

awful.mouse.resize.set_mode ("live")
root.keys(globalkeys)
root.buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            function()
                utils.hide_all_menu()
            end
        ),
        awful.button(
            {},
            3,
            function()
                utils.hide_all_menu()
            end
        ),
        awful.button({}, 4, awful.tag.viewnext),
        awful.button({}, 5, awful.tag.viewprev)
    )
)
awful.rules.rules = client.rules
-- lain.layout.cascade.offset_x = 32
-- lain.layout.cascade.offset_y = 26
awful.layout.layouts = {
    awful.layout.suit.floating,
    -- awful.layout.suit.tile,
    -- lain.layout.cascade,
    -- lain.layout.cascade.tile,
    -- lain.layout.centerwork,
    -- lain.layout.centerwork.horizontal,
    -- awful.layout.suit.tile.top,
    awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.fair,
    awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
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
            awful.tag.add("Default", {
                layout             = awful.layout.layouts[1],
                screen             = screen,
                selected           = true,
            })
            -- awful.tag({'1', '2', '3', '4', '5', '6'}, screen, awful.layout.layouts[1])

            bar:new({screen = screen})
            dock.new({screen = screen})
        end
    )
end


-- kg:start()
return module
