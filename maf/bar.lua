local awful = require("awful")
local wibox = require("wibox")
local system_monitor_widget = require("maf.widgets.systemmonitor")
local volume_widget = require("maf.widgets.volume")
local net_widget = require("maf.widgets.net")
local taglist = require("maf.widgets.taglist")
local tasklist = require("maf.widgets.tasklist")
local launcher = require("maf.widgets.launcher")
local systray = require("maf.widgets.systray")

local globalmenu = require("maf.globalmenu")

local module = {}

module.launcher =
    launcher.new(
    {
        margin = 0,
        menu = globalmenu
    }
)

module.clock =
    wibox.widget {
    {
        {
            image = beautiful.time,
            resize = true,
            widget = wibox.widget.imagebox
        },
        wibox.widget.textclock(" %H:%M "),
        layout = wibox.layout.fixed.horizontal
    },
    margins = 4,
    widget = wibox.container.margin
}

module.tray = systray.new()
module.myprompt =
    awful.widget.prompt {
    prompt = "Imput: "
}
module.system_monitor_widget =
    system_monitor_widget(
    {
        width = 40,
        step_width = 2,
        step_spacing = 0,
        color = beautiful.fg_normal
    }
)
module.volume_widget =
    volume_widget(
    {
        main_color = beautiful.fg_normal,
        mute_color = beautiful.fg_normal .. "88",
        thickness = 5,
        height = 25,
        get_volume_cmd = "amixer sget Master",
        dec_volume_cmd = "amixer sset Master 5%-",
        inc_volume_cmd = "amixer sset Master 5%+",
        tog_volume_cmd = "amixer sset Master toggle"
    }
)
module.net_widget = net_widget()

function module:new(args)
    local mytaglist =
        taglist.new(
        {
            screen = args.screen
        }
    )

    local mylayoutbox = awful.widget.layoutbox(args.screen)

    mylayoutbox:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {},
                3,
                function()
                    awful.layout.inc(-1)
                end
            ),
            awful.button(
                {},
                4,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {},
                5,
                function()
                    awful.layout.inc(-1)
                end
            )
        )
    )

    args.screen.myprompt = module.myprompt

    local task_wibar =
        awful.wibar(
        {
            position = "right",
            ontop = false,
            screen = args.screen,
            bg = "#00000000",
            width = 40
        }
    )
    local mytasklist =
        tasklist.new(
        {
            screen = args.screen,
            wibox = task_wibar
        }
    )
    task_wibar:setup {
        mytasklist,
        valign = "top",
        widget = wibox.container.place
    }

    local mywibar =
        awful.wibar(
        {
            position = "top",
            ontop = false,
            screen = args.screen,
            bg = "#00000000"
        }
    )
    mywibar:setup {
        layout = wibox.layout.align.horizontal,
        {
            self.launcher,
            args.screen.myprompt,
            layout = wibox.layout.fixed.horizontal
        },
        {
            {
                {
                    mytaglist,
                    left = 15,
                    widget = wibox.container.margin
                },
                {
                    -- mytasklist,
                    left = 15,
                    right = 10,
                    widget = wibox.container.margin
                },
                layout = wibox.layout.fixed.horizontal
            },
            {
                layout = wibox.layout.fixed.horizontal
            },
            layout = wibox.layout.flex.horizontal
        },
        {
            {
                {
                    module.tray,
                    module.volume_widget,
                    module.system_monitor_widget,
                    module.net_widget,
                    module.clock,
                    {
                        mylayoutbox,
                        top = 2,
                        bottom = 2,
                        left = 5,
                        right = 2,
                        widget = wibox.container.margin
                    },
                    layout = wibox.layout.fixed.horizontal
                },
                bg = beautiful.bg_focus,
                widget = wibox.container.background
            },
            layout = wibox.layout.fixed.horizontal
        }
    }
    return mywibar
end

return module
