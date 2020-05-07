local awful = require('awful')
local hotkeys_popup = require('awful.hotkeys_popup')
local wibox = require('wibox')

local module = {}

module.indicator =
    wibox.widget {
    {
        {
            markup = '',
            font = 'Noto Sans Regular 20',
            align = 'center',
            valign = 'center',
            widget = wibox.widget.textbox
        },
        layout = wibox.layout.flex.vertical
    },
    margins = 20,
    widget = wibox.container.margin
}

module.popup_indicator =
    awful.popup {
    widget = module.indicator,
    ontop = true,
    border_color = '#00ff00',
    border_width = 5,
    border_width = 0,
    bg = '#000000',
    placement = awful.placement.centered,
    visible = false
}

create_key_bindings = function(keys, options)
    local indicator_text = options.indicator_text or ''
    local grabber =
        awful.keygrabber {
        mask_modkeys = false,
        stop_key = 'Escape',
        autostart = true,
        timeout = 5,
        start_callback = function(self)
            module.popup_indicator.visible = true
        end,
        stop_callback = function(self, stop_key, stop_mods, sequence)
            module.popup_indicator.visible = false
        end
    }

    local key_tips =
        wibox.widget {
        {
            markup = '<b>' .. indicator_text .. '</b>',
            -- font = 'Noto Sans Regular 20',
            align = 'center',
            valign = 'center',
            forced_height = 50,
            widget = wibox.widget.textbox
        },
        spacing = 20,
        layout = wibox.layout.flex.vertical
    }
    for i, item in ipairs(keys) do
        local mod, key, callback, other = item[1], item[2], item[3], item[4]

        if type(callback) == 'table' then
            grabber:add_keybinding(
                mod,
                key,
                function()
                    grabber:stop()
                    gears.debug.dump(create_key_bindings, '000000000000', 0)
                    create_key_bindings(
                        callback,
                        {
                            indicator_text = other.description,
                            args = options.args
                        }
                    )
                end,
                other
            )
        elseif type(callback) == 'function' then
            grabber:add_keybinding(
                mod,
                key,
                function()
                    callback(options.args, grabber)
                    if not (other.hold == true) then
                        grabber:stop()
                    end
                end,
                other
            )
        end
        local m_text = ''
        for _, m in ipairs(mod) do
            m_text = m .. '+'
        end

        key_tips:add(
            wibox.widget {
                markup = '<b>' .. m_text .. key .. '</b>\t<i>' .. other.description .. '</i>',
                align = 'left',
                valign = 'center',
                widget = wibox.widget.textbox
            }
        )
    end
    module.popup_indicator.widget =
        wibox.widget {
        key_tips,
        margins = 20,
        widget = wibox.container.margin
    }
    return grabber
end

module.new = function(mod, key, keys, other)
    return awful.key(
        mod,
        key,
        function(args)
            create_key_bindings(
                keys,
                {
                    indicator_text = other.description,
                    args = args
                }
            )
        end,
        other
    )
end

return setmetatable(
    module,
    {
        __call = function(_, ...)
            return module.new(...)
        end
    }
)
