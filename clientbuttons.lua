local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local menubar = require('menubar')
local clientkeys = require('clientkeys')
local utils = require('utils')
local keydefine = require('keydefine')
local dpi = beautiful.xresources.apply_dpi

function border_control(c)
    if mousegrabber.isrunning() then
        return
    end
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
        (coords.x < geometry.x + range and coords.y < geometry.y + range) or -- left top
            (coords.x > geometry.x + geometry.width - range and coords.y < geometry.y + range) or -- right top
            (coords.x < geometry.x + range and coords.y > geometry.y + geometry.height - range) or -- left bottom
            (coords.x > geometry.x + geometry.width - range and coords.y > geometry.y + geometry.height - range)
     then
        -- right bottom
        awful.mouse.client.resize(c)
    elseif coords.y < geometry.y + range then
        awful.mouse.client.move(c)
    elseif coords.x < geometry.x + range then
        awful.mouse.client.resize(c, 'left')
    elseif coords.x > geometry.x + geometry.width - range then
        awful.mouse.client.resize(c, 'right')
    elseif coords.y > geometry.y + geometry.height - range then
        awful.mouse.client.resize(c, 'bottom')
    end
end

return gears.table.join(
    awful.button(
        {},
        1,
        function(c)
            if not awful.rules.match(c, {class = 'jetbrains-studio', name = '^win[0-9]+$'}) then
                client.focus = c
            end
            c:raise()
            border_control(c)
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
