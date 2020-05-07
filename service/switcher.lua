local awful = require("awful")

local switcher = {}

switcher.grabber =
    awful.keygrabber {
    mask_modkeys = false,
    stop_key = "Escape",
    autostart = true,
    timeout = 5,
    start_callback = function(self)
        module.popup_indicator.visible = true
    end,
    stop_callback = function(self, stop_key, stop_mods, sequence)
        module.popup_indicator.visible = false
    end
}
