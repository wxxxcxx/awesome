local wibox = require("wibox")
local watch = require("awful.widget.watch")

local module = {}
-- dbus.request_name("session", "org.musicbox.Bus")
dbus.add_match("session", "interface='local.musicbox.Lyrics', member='lyrics_update'")

local lyrics_widget =
    wibox.widget {
    markup = "",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

dbus.connect_signal(
    "local.musicbox.Lyrics",
    function(sender, message)
        lyrics_widget.text = message
        -- gears.debug.dump(message, "", 1)
    end
)
watch(
    'bash -c "ps x |grep "musicbox" |wc -l"',
    1,
    function(widget, stdout)
        if tonumber(stdout) <= 2 then
            widget.visible = false
            widget.text = ""
        else
            widget.visible = true
        end
    end,
    lyrics_widget
)

function new(args)
    local args = args or {}
    local max_width = args.max_width or nil

    local wrapper_widget =
        wibox.widget {
        layout = wibox.container.scroll.horizontal,
        max_size = max_width,
        step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
        speed = 100,
        lyrics_widget
    }

    return wrapper_widget
end

return setmetatable(
    module,
    {
        __call = function(_, ...)
            return new(...)
        end
    }
)
