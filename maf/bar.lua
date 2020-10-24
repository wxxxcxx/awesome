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
    thickness = 5,
    height = 25,
    get_volume_cmd = "amixer sget Master",
    dec_volume_cmd = "amixer sset Master 5%-",
    inc_volume_cmd = "amixer sset Master 5%+",
    tog_volume_cmd = "amixer sset Master toggle"
}

local systemmonitor =
    systemmonitor {
    width = 40,
    step_width = 2,
    step_spacing = 0,
    color = beautiful.fg_normal,
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
    margins = 4,
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
                    taglist {
                        screen = args.screen
                    },
                    left = 15,
                    widget = wibox.container.margin
                },
                {
                    layout = wibox.layout.fixed.horizontal
                },
                layout = wibox.layout.flex.horizontal
            },
            {
                {
                    {
                        {
                            tasklist.new {
                                screen = args.screen,
                                wibox = default_bar
                            },
                            left = 15,
                            right = 10,
                            widget = wibox.container.margin
                        },
                        tray,
                        volumecontroller,
                        systemmonitor,
                        netmonitor,
                        time,
                        {
                            layoutcontroller.new(args),
                            top = 2,
                            bottom = 2,
                            left = 5,
                            right = 2,
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
            {
                tasklist.new {
                    screen = args.screen,
                    wibox = default_bar
                },
                left = 3,
                right = 10,
                widget = wibox.container.margin
            },
            nil,
            {
                layoutcontroller.new(args),
                top = 2,
                bottom = 2,
                left = 5,
                right = 2,
                widget = wibox.container.margin
            }
        }
    end

    return default_bar
end

return module
