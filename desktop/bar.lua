local awful = require("awful")
local wibox = require("wibox")
local system_monitor_widget = require("widget.systemmonitor")
local volume_widget = require("widget.volume")
local net_widget = require("widget.net")
local taglist = require("widget.taglist")
local launcher = require("widget.launcher")
local systray = require("widget.systray")
local globalmenu = require("desktop.globalmenu")
local titlebar = require("widget.titlebar")
local lyrics_widget = require("widget.mblyrics")

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

module.titlebar = titlebar

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

    local mywibar = awful.wibar({position = "top", ontop = false, screen = args.screen})

    mywibar:setup {
        layout = wibox.layout.align.horizontal,
        {
            self.launcher,
            args.screen.myprompt,
            layout = wibox.layout.fixed.horizontal
        },
        {
            {
                module.titlebar.icon_widget,
                module.titlebar.instance_widget,
                module.titlebar.title_widget,
                layout = wibox.layout.fixed.horizontal
            },
            {
                {
                    lyrics_widget({}),
                    top = 2,
                    bottom = 5,
                    left = 5,
                    right = 15,
                    widget = wibox.container.margin
                },
                layout = wibox.layout.fixed.horizontal
            },
            layout = wibox.layout.flex.horizontal
        },
        {
            
            
            module.titlebar.other_botton_widget,
            module.titlebar.main_botton_widget,
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
