local awful = require("awful")
local wibox = require("wibox")
local tasklist = require("widget.tasklist")
local animation = require("utils.animation")

local module = {}

function module.new(args)
    local height = args.height or 70
    local dock = {}
    function dock:update_tasklist()
    end
    dock.widget =
        wibox(
        {
            x = 0,
            y = screen[mouse.screen].geometry.height - 1,
            ontop = true,
            -- border_width = 1,
            -- border_color = "#ff0000",
            width = screen[mouse.screen].geometry.width,
            height = height,
            screen = args.screen,
            visible = true,
            bg = "#00000000",
            type = "dnd"
            -- input_passthrough = true,
        }
    )

    local mytasklist =
        tasklist.new(
        {
            screen = args.screen
        }
    )

    local warpper = wibox.widget{
        mytasklist,
        valign = "center",
        layout = wibox.container.place
    }

    dock.widget:setup {
        layout = wibox.layout.align.horizontal,
        nil,
        warpper,
        nil
    }

    local easa_animation =
        animation.easa(
        {
            begin = screen[mouse.screen].geometry.height - 1,
            callback = function(a)
                dock.widget.y = a
            end
        }
    )
    function dock.show()
        -- gears.debug.dump(mytasklist.width, "tasklist", 1)
        easa_animation.start(
            {
                begin = screen[mouse.screen].geometry.height - 1,
                target = screen[mouse.screen].geometry.height - dock.widget.height
            }
        )
    end
    function dock.hide()
        easa_animation.start(
            {
                target = screen[mouse.screen].geometry.height - 1
            }
        )
    end

    dock.widget:connect_signal("mouse::enter", dock.show)

    dock.widget:connect_signal("mouse::leave", dock.hide)

    -- dock.show()
    return dock.widget
end

return module
