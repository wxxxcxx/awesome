-- local awful =require("awful")

-- local geo = screen[1].geometry
-- local new_width = math.ceil(geo.width/2)
-- local new_width2 = geo.width - new_width
-- screen[1]:fake_resize(geo.x, geo.y, new_width, geo.height)
-- screen.fake_add(geo.x + new_width, geo.y, new_width2, geo.height)

local virtualscreen = require("service.virtualscreen")

virtualscreen.new(
    {
        screen = screen.primary,
        size = 500
    }
)
