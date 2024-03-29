local gears = require('gears')
local awful = require('awful')
local hotkeys_popup = require('awful.hotkeys_popup')
local keydefine = require('keydefine')
local widgets = require('widgets')
local switcher = require('switcher')
local filesystem = require('gears.filesystem')

globalkeys =
    gears.table.join(
    awful.key(
        {},
        'Print',
        function()
            awful.spawn.with_shell('flameshot gui')
        end,
        {description = 'Screen capture', group = 'Application'}
    ),
    awful.key(
        {keydefine.alt},
        'space',
        function()
            awful.spawn.with_shell(
                "rofi -modi drun -dpi -me-select-entry '' -me-accept-entry MousePrimary -me-accept-custom MouseSecondary " ..
                    awful.screen.focused().dpi ..
                        ' -show drun -theme ' ..
                            filesystem.get_configuration_dir() ..
                                'misc/launcher.rasi -icon-theme ' .. beautiful.icon_theme
            )
        end,
        {description = 'Show rofi', group = 'Application'}
    )
)

globalkeys =
    gears.table.join(
    globalkeys,
    awful.key(
        {keydefine.modkey, keydefine.shift},
        '/',
        hotkeys_popup.show_help,
        {
            description = 'Show help',
            group = 'Awesome'
        }
    ),
    awful.key(
        {keydefine.modkey},
        'r',
        function()
            widgets.prompt:run()
        end,
        {description = 'Run command', group = 'Awesome'}
    ),
    awful.key(
        {keydefine.modkey, keydefine.control},
        'r',
        awesome.restart,
        {description = 'Reload awesome', group = 'Awesome'}
    ),
    awful.key(
        {
            keydefine.modkey,
            keydefine.control,
            keydefine.shift
        },
        'r',
        function()
            os.execute('systemctl reboot')
        end,
        {
            description = 'Reboot',
            group = 'Awesome'
        }
    ),
    awful.key(
        {keydefine.modkey, keydefine.control},
        'l',
        function()
            os.execute('slimlock')
        end,
        {description = 'Lock', group = 'Awesome'}
    ),
    awful.key(
        {keydefine.modkey, keydefine.control},
        's',
        function()
            os.execute('systemctl suspend')
        end,
        {description = 'Suspend', group = 'Awesome'}
    ),
    awful.key(
        {
            keydefine.modkey,
            keydefine.control,
            keydefine.shift
        },
        's',
        function()
            os.execute('systemctl poweroff')
        end,
        {
            description = 'Shutdown',
            group = 'Awesome'
        }
    )
)

-- Client
globalkeys =
    gears.table.join(
    globalkeys,
    awful.key(
        {keydefine.modkey},
        'h',
        function()
            awful.client.focus.byidx(-1)
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = 'Focus previous by index', group = 'Client'}
    ),
    awful.key(
        {keydefine.modkey},
        'j',
        function()
            awful.client.focus.byidx(1)
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = 'Focus next by index', group = 'Client'}
    ),
    awful.key(
        {keydefine.modkey},
        'k',
        function()
            awful.client.focus.byidx(-1)
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = 'Focus previous by index', group = 'Client'}
    ),
    awful.key(
        {keydefine.modkey},
        'l',
        function()
            awful.client.focus.byidx(1)
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = 'Focus next by index', group = 'Client'}
    ),
    awful.key(
        {keydefine.modkey, keydefine.shift},
        'h',
        function()
            awful.client.swap.byidx(-1)
        end,
        {description = 'Swap previous by index', group = 'Client'}
    ),
    awful.key(
        {keydefine.modkey, keydefine.shift},
        'j',
        function()
            awful.client.swap.byidx(1)
        end,
        {description = 'Swap next by index', group = 'Client'}
    ),
    awful.key(
        {keydefine.modkey, keydefine.shift},
        'k',
        function()
            awful.client.swap.byidx(-1)
        end,
        {description = 'Swap previous by index', group = 'Client'}
    ),
    awful.key(
        {keydefine.modkey, keydefine.shift},
        'l',
        function()
            awful.client.swap.byidx(1)
        end,
        {description = 'Swap next by index', group = 'Client'}
    ),
    awful.key(
        {keydefine.alt},
        'Tab',
        function()
            switcher.switch(1, keydefine.alt, 'Alt_L', keydefine.shift, 'Tab')
        end,
        {description = 'Switch to next', group = 'Client'}
    ),
    awful.key(
        {keydefine.alt, keydefine.shift},
        'Tab',
        function()
            switcher.switch(-1, keydefine.alt, 'Alt_L', keydefine.shift, 'Tab')
        end,
        {description = 'Switch to previous', group = 'Client'}
    ),
    awful.key(
        {keydefine.modkey},
        'Next',
        function()
            local c = client.focus
            if c then
                awful.tag.viewnext()
                c:move_to_tag(screen.primary.selected_tag)
                c:raise()
            end
        end,
        {description = 'Move client to next tag', group = 'Client'}
    ),
    awful.key(
        {keydefine.modkey},
        'Prior',
        function()
            local c = client.focus
            if c then
                awful.tag.viewprev()
                c:move_to_tag(screen.primary.selected_tag)
                c:raise()
            end
        end,
        {description = 'Move client to previous tag', group = 'Client'}
    )
)
-- Tag

globalkeys =
    gears.table.join(
    globalkeys,
    awful.key(
        {keydefine.modkey},
        'Tab',
        function()
            awful.tag.viewnext()
        end,
        {
            description = 'Focus next by index',
            group = 'Tag'
        }
    ),
    awful.key(
        {keydefine.modkey, keydefine.shift},
        'Tab',
        function()
            awful.tag.viewprev()
        end,
        {description = 'view previous tag', group = 'Tag'}
    )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys =
        gears.table.join(
        globalkeys, -- View tag only.
        awful.key(
            {keydefine.modkey},
            '#' .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {description = 'View tag #' .. i, group = 'Tag'}
        ),
        awful.key(
            {keydefine.modkey, keydefine.shift},
            '#' .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                        tag:view_only()
                    end
                end
            end,
            {description = 'Move focused client to tag #' .. i, group = 'Tag'}
        ),
        awful.key(
            {keydefine.modkey, keydefine.control},
            '#' .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = 'Toggle tag #' .. i, group = 'Tag'}
        )
    )
end

-- Media control
globalkeys =
    gears.table.join(
    globalkeys,
    awful.key(
        {},
        'XF86AudioLowerVolume',
        function()
            awful.spawn('pamixer -d 5', false)
        end,
        {description = 'Lower volume', group = 'Media'}
    ),
    awful.key(
        {},
        'XF86AudioRaiseVolume',
        function()
            awful.spawn('pamixer -i 5', false)
        end,
        {description = 'Raise volume', group = 'Media'}
    ),
    awful.key(
        {},
        'XF86AudioMute',
        function()
            awful.spawn('pamixer -t', false)
        end,
        {description = 'Toggle mute volume', group = 'Media'}
    )
)

local at = require('awm-translator')

-- local selection = require("selection")
-- Volume control
-- 是否使用 rofi 展示单词，false 则使用通知展示
-- at.enable_rofi = false
-- 是否启用 anki
at.enable_anki = true
-- Anki保存单词的 Desk
at.anki.desk = 'Word'
-- Anki保存单词的 NodeType
at.anki.model = 'Word'
-- Anki-Connect 的端口号
at.anki.connect_port = 8701
-- 单词字段
at.anki.word_field = 'Word'
-- 释义字段
at.anki.definition_field = 'Definition'
-- 美式音标
at.anki.us_pronunciation_field = 'USPronunciation'
-- 英式音标
at.anki.uk_pronunciation_field = 'UKPronunciation'
-- Anki保存美式发音的字段
at.anki.us_audio_field = 'USAudio'
-- Anki保存英式发音的字段
at.anki.uk_audio_field = 'UKAudio'
globalkeys =
    gears.table.join(
    globalkeys,
    awful.key(
        {keydefine.modkey},
        'z',
        function()
            at.query(selection())
        end
    )
)

return globalkeys
