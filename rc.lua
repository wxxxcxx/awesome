pcall(require, "luarocks.loader")
gears = require("gears")
keydefine = require("keydefine")
beautiful = require("beautiful")
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/default/theme.lua")
local naughty = require("naughty")
local freedesktop = require("freedesktop")

function notify(msg)
    naughty.notify(
        {
            border_width = 0,
            position = "top_right",
            title = "New message!",
            text = msg
        }
    )
end

local desktop = require("desktop")

desktop:init()

local awful = require("awful")

function run_once(cmd)
    local findme = "ps x U $USER |grep '" .. cmd .. "' |wc -l"
    awful.spawn.easy_async_with_shell(
        findme,
        function(stdout, stderr, reason, exit_code)
            if tonumber(stdout) <= 2 then
                -- awful.spawn(cmd)
                awful.spawn.easy_async_with_shell(cmd, nil)
            end
        end
    )
end

local cmds = {
    "fcitx",
    "picom",
    "enpass",
    "nutstore",
    "flameshot",
    "python ~/.config/awesome/widget/mblyrics/main.py",
    "emacs --daemon",
    -- "easystroke"
}

for _, cmd in pairs(cmds) do
    run_once(cmd)
end

-- require("widget.musicboxlyrics.musicboxlyrics")

