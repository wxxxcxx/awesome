local awful = require("awful")
local wibox = require("wibox")
local animation = require("utils.animation")

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
    local easa_animation =
        animation.easa(
        {
            begin = 0,
            callback = function(a)
                client_preview.preview_popup.x = a
            end
        }
    )

    function client_preview.show(c, w)
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
        local current_widget_geometry = mouse.current_widget_geometry
        if not (current_widget_geometry == nil) then
            easa_animation.start(
                {
                    begin = client_preview.preview_popup.x,
                    target = current_widget_geometry.x + current_widget_geometry.width / 2 - preview_width / 2
                }
            )
            -- client_preview.preview_popup.x =
            --     current_widget_geometry.x + current_widget_geometry.width / 2 - preview_width / 2
            client_preview.preview_popup.y = screen.geometry.height - (100 + preview_height)
            client_preview.preview_popup.visible = true
        end
    end
    function client_preview.hide()
        client_preview.visual = false
        gears.timer.start_new(
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
