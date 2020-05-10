local gears = require("gears")
local wibox = require("wibox")

local module = {}

function module.find_widget_in_wibox(wb, wdg)
    local function traverse(hi)
        if hi:get_widget() == wdg then
            return hi
        end
        for _, child in ipairs(hi:get_children()) do
            return traverse(child)
        end
    end
    -- This gives you the instance of wibox.hierarchy.
    -- Note that this is updated lazily and might be out of date until the next main loop iteration!
    return traverse(wb._drawable._widget_hierarchy)
end

function module.get_postion()
    local x, y, w, h = gears.matrix.transform_rectangle(h:get_matrix_to_device(), 0, 0, hi:get_size())
    return x, y, w, h
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
