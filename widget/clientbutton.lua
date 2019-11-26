local cairo = require("lgi").cairo


local module={}
-- Create a surface
local img = cairo.ImageSurface.create(cairo.Format.ARGB32, 50, 50)

-- Create a context
local cr  = cairo.Context(img)

-- Set a red source
cr:set_source(1, 0, 0)
-- Alternative:
cr:set_source(gears.color("#ff0000"))

-- Add a 10px square path to the context at x=10, y=10
cr:rectangle(10, 10, 10, 10)

-- Actually draw the rectangle on img
cr:fill()

module.titlebar_close_button_normal = img

return module