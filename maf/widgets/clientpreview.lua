local awful = require("awful")
local wibox = require("wibox")

local module = {}

function module.new(args)
    local client_preview = {}
    local args = args or {}
    local screen = args.screen
    local preview_width = args.preview_width or 300
    local preview_height = args.preview_height or 200

    local preview_popup =
        awful.popup {
        widget = {
            nil,
            margins = 10,
            widget = wibox.container.margin
        },
        ontop = true,
        border_width = 0,
        bg = beautiful.tasklist_preview_box_bg,
        visible = false
    }

    preview_popup:connect_signal(
        "mouse::enter",
        function()
            preview_popup.visible = true
        end
    )
    preview_popup:connect_signal(
        "mouse::leave",
        function()
            preview_popup.visible = false
        end
    )

    client_preview.preview_popup = preview_popup
    client_preview.visual = false

    function client_preview.show(x, y, c)
        if c.minimized then
            return
        end
        client_preview.visual = true
        local preview_widget = wibox.widget.base.make_widget()
        function preview_widget:fit(context, width, height)
            return preview_width, preview_height
        end
        function preview_widget:draw(context, cr, width, height)
            local tmp = gears.surface(c.content)
            cr:move_to(0, 0)
            local sx = preview_width / c.width
            local sy = preview_height / c.height
            cr:scale(sx, sy)
            cr:set_source_surface(tmp, 0, 0)
            cr:paint()
            tmp:finish()
        end
        client_preview.preview_popup:setup(
            {
                {
                    preview_widget,
                    margins = 10,
                    widget = wibox.container.margin
                },
                layout = wibox.layout.fixed.vertical
            }
        )

        client_preview.preview_popup.x = x - (preview_width / 2)
        if client_preview.preview_popup.x < 0 then
            client_preview.preview_popup.x = 0
        end
        client_preview.preview_popup.y = y
        client_preview.preview_popup.visible = true
    end
    function client_preview.hide()
        client_preview.visual = false
        gears.timer.weak_start_new(
            0.5,
            function()
                if not client_preview.visual then
                    client_preview.preview_popup.visible = false
                end
            end
        )
    end
    return client_preview
end

return module
