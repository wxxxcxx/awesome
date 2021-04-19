local awful = require("awful")
local wibox = require("wibox")
local widgets = require("widgets")
local utils = require("utils")
local globalmenu = require("globalmenu")

local dpi = beautiful.xresources.apply_dpi

local module = {}

local tag_switch_buttons = gears.table.join(awful.button({}, 4, function(t)
    awful.tag.viewprev()
end), awful.button({}, 5, function(t)
    awful.tag.viewnext()
end))

function module:new(args)
    local default_bar = awful.wibar({
        position = "bottom",
        ontop = true,
        screen = args.screen,
    })

    client.connect_signal("property::fullscreen", function(c)
        default_bar.ontop = not c.fullscreen
    end)

    default_bar:setup{
        layout = wibox.layout.align.horizontal,
        {
            widgets.launcher {
                margin = 0,
                menu = globalmenu
            },
            widgets.taglist {
                screen = args.screen
            },

            layout = wibox.layout.fixed.horizontal
        },
        {
            widgets.tasklist.new {
                screen = args.screen,
                wibox = default_bar
            },
            halign = "center",
            widget = wibox.container.place
        },
        {
            {
                {

                    widgets.folder.new {
                        wibox.widget {
                            wibox.widget.systray(),
                            margins = dpi(4),
                            widget = wibox.container.margin
                        },
                        layout = wibox.layout.fixed.horizontal
                    },
                    widgets.volume {},
                    widgets.clock {},
                    {
                        widgets.layout.new(args),
                        top = dpi(2),
                        bottom = dpi(2),
                        left = dpi(5),
                        right = dpi(2),
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

    return default_bar
end

return module
