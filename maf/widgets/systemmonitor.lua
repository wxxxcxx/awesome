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

local widget = {}

local function worker(args)
    local args = args or {}

    local width = args.width or 50
    local step_width = args.step_width or 2
    local step_spacing = args.step_spacing or 1
    local color = args.color or beautiful.fg_normal

    local cpu_widget =
        wibox.widget {
        markup = "",
        align = "left",
        valign = "top",
        font = beautiful.font_name .. " 5",
        widget = wibox.widget.textbox
    }
    local ram_widget =
        wibox.widget {
        markup = "",
        align = "left",
        valign = "bottom",
        font = beautiful.font_name .. " 5",
        widget = wibox.widget.textbox
    }
    local wrapper =
        wibox.widget {
        {
            {
                image = beautiful.system_monitor,
                resize = true,
                widget = wibox.widget.imagebox
            },
            {
                cpu_widget,
                ram_widget,
                forced_width = 20,
                layout = wibox.layout.flex.vertical
            },
            layout = wibox.layout.fixed.horizontal
        },
        margins = 4,
        widget = wibox.container.margin
    }

    --- By default graph widget goes from left to right, so we mirror it and push up a bit
    -- local cpu_widget = wibox.container.margin(wibox.container.mirror(cpugraph_widget, { horizontal = true }), 0, 0, 0, 2)

    local total_prev = 0
    local idle_prev = 0

    watch(
        [[bash -c "cat /proc/stat | grep '^cpu '"]],
        1,
        function(widget, stdout)
            local user, nice, system, idle, iowait, irq, softirq, steal, guest, guest_nice =
                stdout:match("(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s")

            local total = user + nice + system + idle + iowait + irq + softirq + steal

            local diff_idle = idle - idle_prev
            local diff_total = total - total_prev
            local diff_usage = (1000 * (diff_total - diff_idle) / diff_total + 5) / 10

            widget.markup = string.format(" %.0f%%", diff_usage)
            total_prev = total
            idle_prev = idle
        end,
        cpu_widget
    )

    watch(
        'bash -c "LANGUAGE=en_US.UTF-8 free | grep -z Mem.*Swap.*"',
        1,
        function(widget, stdout, stderr, exitreason, exitcode)
            total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap =
                stdout:match("(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*Swap:%s*(%d+)%s*(%d+)%s*(%d+)")

            local percent = tonumber(used) / tonumber(total) * 100
            widget.markup = string.format(" %.0f%%", percent)
        end,
        ram_widget
    )

    return wrapper
end

return setmetatable(
    widget,
    {
        __call = function(_, ...)
            return worker(...)
        end
    }
)
