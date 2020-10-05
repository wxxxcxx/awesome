local awful = require("awful")
local gears = require("gears")
local lgi = require("lgi")
local table = require("utils.table")
local color = require("utils.color")
require("utils.table")

local cairo = lgi.cairo
local gdk = lgi.Gdk

local color_rules_path = gears.filesystem.get_configuration_dir() .. "/color_rules"
local module = {}
module.fg_dark = "#252a33"
module.fg_light = "#dee6e7"
module._color_rules = table.load(color_rules_path) or {}

local function save_color(name, color)
    module._color_rules[name] = color
    table.save(module._color_rules, color_rules_path)
end

local function get_client_major_color(client)
    local content = gears.surface(client.content)
    -- content:write_to_png("/home/maf/".. client.instance .. ".png")
    local color_map = {}
    local client_geometry = client:geometry()
    local width = math.floor(client_geometry.width / 2)
    for x = 0, width, 2 do
        for y = 0, 8, 1 do
            local pixbuf = gdk.pixbuf_get_from_surface(content, x + 2, y + 2, 1, 1)
            if not pixbuf then
                return
            end
            local bytes = pixbuf:get_pixels()
            local color =
                "#" ..
                bytes:gsub(
                    ".",
                    function(c)
                        return ("%02x"):format(c:byte())
                    end
                )

            if not color_map[color] then
                color_map[color] = 1
            else
                color_map[color] = color_map[color] + 1
            end
        end
    end
    gears.debug.dump(color_map, "", 2)
    -- 获取出现次数最多的颜色
    local max = 0
    local major_color = "#00000000"
    for color, count in pairs(color_map) do
        if count > max then
            major_color = color
            max = count
        end
    end
    collectgarbage("collect")
    return major_color
end

function module.get_fg_color(client)
    local bg = module.get_major_color(client)
    return color.is_contrast_acceptable(module.fg_light, bg) and module.fg_light or module.fg_dark
end

function module.reset_major_color(client)
    local name = (client.instance or "") .. "_" .. client.type
    save_color(name .. "_focus", nil)
    save_color(name .. "_unfocus", nil)
    client:emit_signal("reset_major_color")
end

function module.get_major_color(client)
    local name = (client.instance or "") .. "_" .. client.type
    name = _G.client.focus == client and name .. "_focus" or name .. "_unfocus"
    if module._color_rules[name] then
        return module._color_rules[name]
    end
    local color = get_client_major_color(client)

    if not color then
        return "#00000000"
    end

    save_color(name, color)
    return color
end

function module.hide_content(client)
end

function module.show_content(client)
end

function module.toggle_content(client)
end

function module.enable_corner_resize(range)
    local function mouse_in_corner(client)
        local coords = mouse.coords()
        if coords == nil then
            return
        end
        if client == nil then
            return
        end
        local geometry = client:geometry()
        if
            (coords.x < geometry.x + range and coords.y < geometry.y + range) or --left top
                (coords.x > geometry.x + geometry.width - range and coords.y < geometry.y + range) or --right top
                (coords.x < geometry.x + range and coords.y > geometry.y + geometry.height - range) or --left bottom
                (coords.x > geometry.x + geometry.width - range and coords.y > geometry.y + geometry.height - range)
         then
            return true
        end
        return false
    end
    _G.client.connect_signal(
        "button::press",
        function(c, x, y, button, modifiers)
            if button == 1 and mouse_in_corner(c) then
                mousegrabber.stop() -- 防止mousegrabber冲突
                awful.mouse.client.resize(c)
            end
        end
    )
end

function module.enable_auto_titlebar()
    local function dynamic_title(c)
        if not c.first_tag then
            return
        end
        if c.floating or c.first_tag.layout.name == "floating" then
            awful.titlebar.show(c)
            client:emit_signal("reset_major_color")
        else
            awful.titlebar.hide(c)
        end
    end
    client.connect_signal("property::floating", dynamic_title)

    tag.connect_signal(
        "property::layout",
        function(t)
            local clients = t:clients()
            for k, c in pairs(clients) do
                dynamic_title(c)
            end
        end
    )
end

function module.get_client_preview(client)
    local surface = gears.surface(client.content)
    local cr = cairo.Context.create(surface)
    local sx = preview_width / c.width
    local sy = preview_height / c.height
    cr:scale(sx, sy)
    cr:set_source_surface(tmp, 0, 0)
    cr:paint()
    cr:destroy()
    surface:finish()
    return surface
end

return module
