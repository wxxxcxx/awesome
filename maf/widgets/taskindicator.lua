local awful = require("awful")
local wibox = require("wibox")
local utils = require("utils")
local common = require("awful.widget.common")
local client_preview = require("widget.clientpreview")

local taskindicator = {mt = {}}

local function list_client(filter, s)
    local clients = {}
    local list = client.get()
    for _, c in ipairs(list) do
        if not (c.skip_taskbar or c.hidden or c.type == "splash" or c.type ==
            "dock" or c.type == "desktop") and filter(c, s) then
            table.insert(clients, c)
        end
    end
    return clients
end

local function group_client(list)
    local group = {}
    for k, c in ipairs(groups) do groups[k] = {} end
    for _, c in ipairs(list) do
        local k = c.instance
        if groups[k] == nil then groups[k] = {} end
        table.insert(groups[k], c)
    end
    return groups
end

local function new(args)
    local uf = args.update_function or common.list_update
    local w = wibox.widget.base.make_widget_from_value(
                  args.layout or wibox.layout.flex.horizontal)
end
function textbox.mt.__call(_, ...) return new(...) end

return setmetatable(taskindicator, taskindicator.mt)
