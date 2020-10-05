local awful = require("awful")
local module = {
    visable = false
}

local primary_geometry = {
    x = _G.screen.primary.geometry.x,
    y = _G.screen.primary.geometry.y,
    width = _G.screen.primary.geometry.width,
    height = _G.screen.primary.geometry.height
}

module.work_screen = _G.screen.fake_add(primary_geometry.width, primary_geometry.height, 0, 0)
function module:show(args)
    local args = args or {}

    local size = args.size or math.floor(primary_geometry.width * 0.6)

    module.work_screen:fake_resize(primary_geometry.width - size, 0, size, primary_geometry.height)
    _G.screen.primary:fake_resize(0, 0, primary_geometry.width - size, primary_geometry.height)

    awful.screen.focus(module.work_screen)
    module.visable = true
    if client.focus and #module.work_screen:get_all_clients() == 0 then
        client.focus:move_to_screen(module.work_screen)
    end
    client.focus:raise()
end

function module:hide()
    local size = 3

    _G.screen.primary:fake_resize(0, 0, primary_geometry.width, primary_geometry.height)
    local width = module.work_screen.geometry.width
    local height = module.work_screen.geometry.height
    module.work_screen:fake_resize(primary_geometry.width - size, primary_geometry.height - size, width, width)

    awful.screen.focus(_G.screen.primary)
    module.visable = false
end

function module:toggle(args)
    if module.visable then
        self:hide()
    else
        self:show(args)
    end
end

function module:toggle_focused()
    local work_screen_focused = module.work_screen == awful.screen.focused({client = true})
    if module.visable then
        if work_screen_focused then
            awful.screen.focus(_G.screen.primary)
            client.focus:raise()
        else
            if #module.work_screen:get_all_clients() > 0 then
                awful.screen.focus(module.work_screen)
                client.focus:raise()
            end
        end
    end
end

return module
