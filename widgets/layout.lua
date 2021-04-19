local awful = require("awful")

local module = {}

function module.new(args)
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
    return mylayoutbox
end

return setmetatable(
    module,
    {
        __call = function(_, ...)
            return module.show(...)
        end
    }
)
