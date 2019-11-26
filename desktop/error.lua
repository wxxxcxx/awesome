local naughty = require('naughty')

local module = {}

naughty.config.presets.critical.bg = '#33000055'
function module:init()
    if awesome.startup_errors then
        naughty.notify(
            {
                border_width = 0,
                border_color = naughty.config.presets.critical.bg,
                position = 'top_right',
                preset = naughty.config.presets.critical,
                title = utf8.char(0xf06a) .. ' Oops, there were errors during startup!',
                text = awesome.startup_errors
            }
        )
    end

    do
        local in_error = false
        awesome.connect_signal(
            'debug::error',
            function(err)
                -- Make sure we don't go into an endless error loop
                if in_error then
                    return
                end
                in_error = true

                naughty.notify(
                    {
                        border_width = 0,
                        border_color = naughty.config.presets.critical.bg,
                        position = 'top_right',
                        preset = naughty.config.presets.critical,
                        title = utf8.char(0xf06a) .. ' Oops, an error happened!',
                        text = tostring(err)
                    }
                )
                in_error = false
            end
        )
    end
end

return module
