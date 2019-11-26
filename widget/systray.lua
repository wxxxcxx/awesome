local awful = require('awful')
local wibox = require('wibox')

local module = {}

function module.new()
    local tray = wibox.widget.systray()
    tray.visible = false
    local toggle =
        wibox.widget {
        markup = utf8.char(0xf0a8),
	font = 'Noto Sans Regular 18',
        align = 'center',
        valign = 'center',
        widget = wibox.widget.textbox
    }
    local buttons =
        gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                if tray.visible then
                    toggle.markup = utf8.char(0xf0a8)
                else
                    toggle.markup = utf8.char(0xf0a9)
                end
                tray.visible = not tray.visible
            end
        )
    )
    toggle:buttons(buttons)

    local widget =
        wibox.widget {
        {
            toggle,
            left = 5,
            right = 5,
            widget = wibox.container.margin
        },
        {
            tray,
            top = 7,
            bottom = 7,
            left = 7,
            right = 7,
            widget = wibox.container.margin
        },
        layout = wibox.layout.fixed.horizontal
    }
    return widget
end

return module
