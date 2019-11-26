local awful = require('awful')
local wibox = require('wibox')
local cpu_ram_widget = require('widget.cpu-ram')
local volume_widget = require('widget.volume')
local net_widget = require('widget.net')
local taglist = require('widget.taglist')
local tasklist = require('widget.tasklist')
local launcher = require('widget.launcher')
local systray = require('widget.systray')
local globalmenu = require('desktop.globalmenu')

local module = {}

module.launcher =
    launcher.new(
    {
        margin = 4,
        menu = globalmenu
    }
)

module.clock = wibox.widget.textclock(' %H:%M ')
module.tray = systray.new()
module.myprompt =
    awful.widget.prompt {
    prompt = 'Imput: '
}
module.cpu_ram_widget =
    cpu_ram_widget(
    {
        width = 40,
        step_width = 2,
        step_spacing = 0,
        color = '#ffffff'
    }
)
module.volume_widget =
    volume_widget(
    {
        main_color = '#ffffff',
        mute_color = '#000000',
        thickness = 5,
        height = 25,
        get_volume_cmd = 'amixer sget Master',
        dec_volume_cmd = 'amixer sset Master 5%-',
        inc_volume_cmd = 'amixer sset Master 5%+',
        tog_volume_cmd = 'amixer sset Master toggle'
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

    local mytasklist =
        tasklist.new(
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

    local mywibar = awful.wibar({position = 'top', ontop = false, screen = args.screen})

    mywibar:setup {
        layout = wibox.layout.align.horizontal,
        {
            self.launcher,
            {
                mytaglist,
                left = 0,
                right = 10,
                widget = wibox.container.margin
            },
            layout = wibox.layout.fixed.horizontal
        },
        {
            {
                {
                    {
                        mytasklist,
                        widget = wibox.container.margin
                    },
                    shape_clip = true,
                    shape = function(cr, w, h)
                        gears.shape.rounded_rect(cr, w, h, 4)
                    end,
                    bg = '#ffffff33',
                    widget = wibox.container.background
                },
                margins = 3,
                widget = wibox.container.margin
            },
            args.screen.myprompt,
            -- halign = 'left',
            layout = wibox.layout.fixed.horizontal
        },
        {
            module.tray,
            {
                module.cpu_ram_widget,
                margins = 4,
                widget = wibox.container.margin
            },
            {
                module.volume_widget,
                margins = 5,
                widget = wibox.container.margin
            },
            {
                module.net_widget,
                margins = 4,
                left = 5,
                widget = wibox.container.margin
            },
            module.clock,
            {
                mylayoutbox,
                top = 2,
                bottom = 2,
                left = 2,
                right = 2,
                widget = wibox.container.margin
            },
            layout = wibox.layout.fixed.horizontal
        }
    }

    return mywibar
end

return module
