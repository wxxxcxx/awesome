local awful = require("awful")
local wibox = require("wibox")
-- local systemmonitor = require("maf.widgets.systemmonitor")
-- local volumecontroller = require("maf.widgets.volumecontroller")
-- local netmonitor = require("maf.widgets.netmonitor")
local taglist = require("maf.widgets.taglist")
local tasklist = require("maf.widgets.tasklist")
local launcher = require("maf.widgets.launcher")
local folder = require("maf.widgets.folder")
local search = require("maf.widgets.search")
local layoutcontroller = require("maf.widgets.layoutcontroller")
local utils = require("utils")
local xresources = require("beautiful.xresources")

local globalmenu = require("maf.globalmenu")

local module = {}
local launcher = launcher.new({
    margin = 0,
    menu = globalmenu
})

-- local volumecontroller =
--     volumecontroller {
--     main_color = beautiful.fg_normal,
--     mute_color = utils.color.auto_lighten_or_darken(beautiful.fg_normal, 30),
--     thickness = xresources.apply_dpi(3),
--     height = xresources.apply_dpi(15),
--     get_volume_cmd = "amixer sget Master",
--     dec_volume_cmd = "amixer sset Master 5%-",
--     inc_volume_cmd = "amixer sset Master 5%+",
--     tog_volume_cmd = "amixer sset Master toggle"
-- }

-- local systemmonitor =
--     systemmonitor {
--     width = xresources.apply_dpi(40),
--     step_width = xresources.apply_dpi(2),
--     step_spacing = xresources.apply_dpi(0),
--     color = beautiful.fg_normal
-- }

-- local netmonitor = netmonitor()

local tray = wibox.widget {
    wibox.widget.systray(),
    top = 6,
    bottom = 6,
    left = 4,
    right = 4,
    widget = wibox.container.margin
}

local folder = folder.new {
    tray,
    -- systemmonitor,
    -- netmonitor,
    -- volumecontroller,
    layout = wibox.layout.fixed.horizontal
}

local time = wibox.widget {
    {
        {
            image = beautiful.time_icon,
            resize = true,
            widget = wibox.widget.imagebox
        },
        wibox.widget.textclock(" %H:%M "),
        layout = wibox.layout.fixed.horizontal
    },
    margins = xresources.apply_dpi(4),
    widget = wibox.container.margin
}
local search = wibox.widget {
    search {},
    margins = xresources.apply_dpi(4),
    widget = wibox.container.margin
}

local tag_switch_buttons = gears.table.join(awful.button({}, 4, function(t)
    awful.tag.viewprev()
end), awful.button({}, 5, function(t)
    awful.tag.viewnext()
end))

function module:new(args)
    local default_bar = awful.wibar({
        position = "top",
        ontop = false,
        screen = args.screen,
        y = -1
    })

    if args.screen == screen.primary then
        default_bar:setup{
            layout = wibox.layout.align.horizontal,
            {
                launcher,
                {
                    taglist {
                        screen = args.screen
                    },
                    left = xresources.apply_dpi(5),
                    widget = wibox.container.margin
                },
                {
                    tasklist.new {
                        screen = args.screen,
                        wibox = default_bar
                    },
                    left = xresources.apply_dpi(10),
                    right = xresources.apply_dpi(10),
                    widget = wibox.container.margin
                },
                layout = wibox.layout.fixed.horizontal
            },
            {
                nil,
                {
                    markup = "",
                    align = "right",
                    valign = "center",
                    buttons = tag_switch_buttons,
                    widget = wibox.widget.textbox
                },
                nil,
                layout = wibox.layout.align.horizontal
            },
            {
                {
                    {
                        folder,
                        time,
                        search,
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
        default_bar:setup{
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
