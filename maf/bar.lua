local awful = require("awful")
local wibox = require("wibox")
local systemmonitor = require("maf.widgets.systemmonitor")
local volumecontroller = require("maf.widgets.volumecontroller")
local netmonitor = require("maf.widgets.netmonitor")
local taglist = require("maf.widgets.taglist")
local tasklist = require("maf.widgets.tasklist")
local launcher = require("maf.widgets.launcher")
local tray = require("maf.widgets.tray")
local layoutcontroller = require("maf.widgets.layoutcontroller")
local utils = require("utils")
local xresources = require("beautiful.xresources")

local globalmenu = require("maf.globalmenu")

local module = {}
local launcher =
    launcher.new(
    {
        margin = 0,
        menu = globalmenu
    }
)
local tray = tray.new()

local volumecontroller =
    volumecontroller {
    main_color = beautiful.fg_normal,
    mute_color = utils.color.auto_lighten_or_darken(beautiful.fg_normal, 30),
    thickness = xresources.apply_dpi(3),
    height = xresources.apply_dpi(15),
    get_volume_cmd = "amixer sget Master",
    dec_volume_cmd = "amixer sset Master 5%-",
    inc_volume_cmd = "amixer sset Master 5%+",
    tog_volume_cmd = "amixer sset Master toggle"
}

local systemmonitor =
    systemmonitor {
    width = xresources.apply_dpi(40),
    step_width = xresources.apply_dpi(2),
    step_spacing = xresources.apply_dpi(0),
    color = beautiful.fg_normal
}

local netmonitor = netmonitor()

local time =
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
    margins = xresources.apply_dpi(4),
    widget = wibox.container.margin
}

function module:new(args)
    local default_bar =
        awful.wibar(
        {
            position = "top",
            ontop = false,
            screen = args.screen,
            y = -1
        }
    )

    if args.screen == screen.primary then
        default_bar:setup {
            layout = wibox.layout.align.horizontal,
            {
                launcher,
                layout = wibox.layout.fixed.horizontal
            },
            {
                {
                    tasklist.new {
                        screen = args.screen,
                        wibox = default_bar
                    },
                    left = xresources.apply_dpi(15),
                    right = xresources.apply_dpi(10),
                    widget = wibox.container.margin
                },
                layout = wibox.layout.flex.horizontal
            },
            {
                {
                    {
                        {
                            taglist {
                                screen = args.screen
                            },
                            left = xresources.apply_dpi(15),
                            widget = wibox.container.margin
                        },
                        tray,
                        volumecontroller,
                        systemmonitor,
                        netmonitor,
                        time,
                        {
                            layoutcontroller.new(args),
                            top = xresources.apply_dpi(2),
                            bottom = xresources.apply_dpi(2),
                            left = xresources.apply_dpi(5),
                            right = xresources.apply_dpi(2),
                            widget = wibox.container.margin
                        },
                        layout = wibox.layout.fixed.horizontal
                    },
                    bg = beautiful.transparent,
                    widget = wibox.container.background
                },
                layout = wibox.layout.fixed.horizontal
            }
        }
    else
        default_bar:setup {
            layout = wibox.layout.align.horizontal,
            nil,
            nil,
            {
                {
                    tasklist.new {
                        screen = args.screen,
                        wibox = default_bar
                    },
                    layoutcontroller.new(args),
                    layout = wibox.layout.fixed.horizontal
                },
                top = xresources.apply_dpi(2),
                bottom = xresources.apply_dpi(2),
                left = xresources.apply_dpi(5),
                right = xresources.apply_dpi(2),
                widget = wibox.container.margin
            }
        }
    end

    return default_bar
end

return module
