-------------------------------------------------
-- CPU Widget for Awesome Window Manager
-- Shows the current CPU utilization
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/cpu-widget

-- @author Pavel Makhov
-- @copyright 2019 Pavel Makhov
-------------------------------------------------

local watch = require("awful.widget.watch")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")

local widget = {}

local function worker(args)
    local args = args or {}

    local device = args.device or "enp0s31f6"
    local color = args.color or beautiful.fg_normal

    local tx_widget =
        wibox.widget {
        align = "left",
        valign = "bottom",
        font = beautiful.gtk_theme.font_family .. " 5",
        widget = wibox.widget.textbox
    }
    local rx_widget =
        wibox.widget {
        align = "left",
        valign = "top",
        font = beautiful.gtk_theme.font_family .. " 5",
        widget = wibox.widget.textbox
    }
    local net_widget =
        wibox.widget {
        {
            {
                image = beautiful.net_monitor_icon,
                resize = true,
                widget = wibox.widget.imagebox
            },
            {
                tx_widget,
                rx_widget,
                forced_width = xresources.apply_dpi(30),
                layout = wibox.layout.flex.vertical
            },
            layout = wibox.layout.fixed.horizontal
        },
        margins = xresources.apply_dpi(4),
        widget = wibox.container.margin
    }

    local last_tx_speed = 0
    local last_rx_speed = 0
    watch(
        "cat /sys/class/net/" .. device .. "/statistics/tx_bytes",
        1,
        function(widget, stdout)
            local now_speed = tonumber(stdout:match("(%d+)%s"))
            local tx_speed = now_speed - last_tx_speed
            last_tx_speed = now_speed
            local unit = "B"
            if tx_speed < 1000 then
                unit = "B"
            elseif tx_speed > 1000 and tx_speed < 1024000 then
                tx_speed = tx_speed / 1024
                unit = "K"
            else
                tx_speed = tx_speed / 1024 / 1024
                unit = "M"
            end
            tx_widget.markup = string.format("  %.2f", tx_speed) .. unit
        end,
        net_widget
    )
    watch(
        "cat /sys/class/net/" .. device .. "/statistics/rx_bytes",
        1,
        function(widget, stdout)
            local now_speed = tonumber(stdout:match("(%d+)%s"))
            local rx_speed = now_speed - last_rx_speed
            last_rx_speed = now_speed
            local unit = "B"
            if rx_speed < 1000 then
                unit = "B"
            elseif rx_speed > 1000 and rx_speed < 1024000 then
                rx_speed = rx_speed / 1024
                unit = "K"
            else
                rx_speed = rx_speed / 1024 / 1024
                unit = "M"
            end
            rx_widget.markup = string.format("  %.2f", rx_speed) .. unit
        end,
        net_widget
    )

    return net_widget
end

return setmetatable(
    widget,
    {
        __call = function(_, ...)
            return worker(...)
        end
    }
)
