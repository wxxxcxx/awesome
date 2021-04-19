local naughty = require('naughty')

local module = {}

function module:init()
   if awesome.startup_errors then
      naughty.notify(
         {
            bg = naughty.config.presets.critical.bg,
            fg = naughty.config.presets.critical.fg,
            border_color = naughty.config.presets.critical.bg,
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

                  bg = naughty.config.presets.critical.bg,
                  fg = naughty.config.presets.critical.fg,
                  border_color = naughty.config.presets.critical.bg,
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
