local awful = require('awful')
local hotkeys_popup = require('awful.hotkeys_popup')
local wibox = require('wibox')

local module = {}

function create_sequentialkey(key)
    local sequentialkey={}
    sequentialkey.mod = key.mod
    sequentialkey.key = key.key
    sequentialkey.has_child = type(key.callback) == 'table'
    sequentialkey.description= key.other.description

    sequentialkey.grabber = awful.keygrabber {
        mask_modkeys = false,
        stop_key = 'Escape',
        autostart = false,
        timeout = 5,
    }
    function sequentialkey:start ()

    end
end

function create_widget(sequentialkey)
    
    wibox.widget {
        -- Key description
        {
            markup = '<b>' .. sequentialkey.description  .. '</b>',
            -- font = 'Noto Sans Regular 20',
            align = 'center',
            valign = 'center',
            widget = wibox.widget.textbox
        },
        spacing = 20,
        layout = wibox.layout.flex.vertical
    }
end

function start()
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
