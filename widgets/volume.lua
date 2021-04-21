local awful = require('awful')
local beautiful = require('beautiful')
local spawn = require('awful.spawn')
local watch = require('awful.widget.watch')
local wibox = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local GET_VOLUME_CMD = 'amixer sget Master'
local INC_VOLUME_CMD = 'amixer sset Master 5%+'
local DEC_VOLUME_CMD = 'amixer sset Master 5%-'
local TOG_VOLUME_CMD = 'amixer sset Master toggle'

local module = {}

module.widgets = {}

function update_by_alsa()
    spawn.easy_async_with_shell(
        "amixer sget Master",
        function(out)
            local mute_string = string.match(out, '%[(o%D%D?)%]') -- \[(o\D\D?)\] - [on] or [off]
            local volume_string = string.match(out, '(%d?%d?%d)%%') -- (\d?\d?\d)\%)
            local volume = tonumber(string.format('% 3d', volume_string))
            local mute = mute_string == 'off'
            update_widgets(volume, mute)
        end
    )
end

function update_by_pamixer()
    spawn.easy_async_with_shell(
        'pamixer --get-volume',
        function(out)
            local volume_string = out
            spawn.easy_async_with_shell(
                'pamixer --get-mute',
                function(out)
                    local mute_string = out
                    local volume = tonumber(volume_string)
                    local mute = mute_string == 'true\n'
                    update_widgets(volume, mute)
                end
            )
        end
    )
end

function update_widgets(volume, mute)
    for i, widget in ipairs(module.widgets) do
        local progressbar = widget:get_children_by_id('progress_bar')[1]
        progressbar:set_value(100)
        progressbar.color = {
            type = 'linear',
            from = {0, 0},
            to = {100, 0},
            stops = {
                {
                    0,
                    mute and (beautiful.volume_mute_progress_bg or '#00000000') or
                        (beautiful.volume_progress_bg or '#ffffff')
                },
                {volume / 100, beautiful.volume_bg or '#00000000'}
            }
        }
        local text_box = widget:get_children_by_id('text_box')[1]
        text_box.text = mute and 'M' or volume .. '%'
    end
end

gears.timer {
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = update_by_pamixer
}
function module.new()
    local widget =
        wibox.widget {
        {
            {
                {
                    {
                        id = 'progress_bar',
                        widget = wibox.widget.progressbar,
                        forced_width = dpi(60),
                        shape = function(cr, width, height)
                            gears.shape.rounded_rect(cr, width, height, dpi(5))
                        end,
                        background_color = beautiful.volume_bg or '#000000'
                    },
                    {
                        id = 'text_box',
                        align = 'center',
                        valign = 'center',
                        visible = false,
                        widget = wibox.widget.textbox
                    },
                    widget = wibox.widget,
                    layout = wibox.layout.stack
                },
                widget = wibox.container.margin,
                margins = dpi(3)
            },
            widget = wibox.container.background,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, dpi(8))
            end,
            bg = beautiful.volume_bg or '#000000'
        },
        widget = wibox.container.margin,
        margins = dpi(4)
    }
    table.insert(module.widgets, widget)
    widget:connect_signal(
        'button::press',
        function(_, _, _, button)
            if (button == 4) then
                awful.spawn("pamixer -i 5", false)
            elseif (button == 5) then
                awful.spawn("pamixer -d 5", false)
            elseif (button == 1) then
                awful.spawn("pamixer -t", false)
            end
            update_by_pamixer()
        end
    )

    widget:connect_signal(
        'mouse::enter',
        function(r)
            local text_box = widget:get_children_by_id('text_box')[1]
            text_box.visible = true
        end
    )
    widget:connect_signal(
        'mouse::leave',
        function(r)
            local text_box = widget:get_children_by_id('text_box')[1]
            text_box.visible = false
        end
    )

    return widget
end
return setmetatable(
    module,
    {
        __call = function(_, ...)
            return module.new(...)
        end
    }
)
