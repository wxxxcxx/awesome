local gears = require("gears")
local wibox = require("wibox")
-- local globalmenu = require('maf.globalmenu')
-- local tasklist = require('maf.widgets.tasklist')

local module={}

module.hide_all_menu=function()
    -- globalmenu:hide()
    -- if not (tasklist.tasklist_menu == nil) then
    --     tasklist.tasklist_menu:hide()
    -- end
end


local function find_widget_in_wibox(wb, wdg)
    local function traverse(hierarchy)
        if hierarchy:get_widget() == wdg then
            return hierarchy
        end
        for _, child in ipairs(hierarchy:get_children()) do
            local result = traverse(child)
            if result then
                return result
            end
        end
    end
    -- This gives you the instance of wibox.hierarchy.
    -- Note that this is updated lazily and might be out of date until the next main loop iteration!
    if wb._drawable and wb._drawable._widget_hierarchy then
        return traverse(wb._drawable._widget_hierarchy, 0)
    end
end

function module.get_widget_postion(wb, widget)
    local widget_hierarchy = find_widget_in_wibox(wb, widget)
    if widget_hierarchy then
        local x, y, w, h =
            gears.matrix.transform_rectangle(widget_hierarchy:get_matrix_to_device(), 0, 0, widget_hierarchy:get_size())
        local geo = wb:geometry()
        x, y = x + geo.x, y + geo.y
        return x, y, w, h
    end
    return 0, 0, 0, 0
end

function module.string_split(input, delimiter)
    input = tostring(input)
    delimiter = tostring(delimiter)
    if (delimiter == "") then
        return false
    end
    local pos, arr = 0, {}
    -- for each divider found
    for st, sp in function()
        return string.find(input, delimiter, pos, true)
    end do
        table.insert(arr, string.sub(input, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(input, pos))
    return arr
end

return module
