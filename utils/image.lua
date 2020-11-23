local gears = require("gears")
local cairo = require("lgi").cairo
local color = require("utils.color")
local xresources = require("beautiful.xresources")

local module = {}

function module.iconfont(args)
    local args = args or {}
    local text = args.text or ""
    local font = args.font or "Material Icons"
    local tx = args.tx or 0
    local ty = args.ty or 0
    local color = args.color or "#ffffff"
    local bg = args.bg or "#00000000"
    local width = args.width or 30
    local height = args.height or 30
    local fontsize = args.fontsize or 20

    local is = cairo.ImageSurface.create(cairo.Format.ARGB32, width, height)
    local cr = cairo.Context(is)

    cr:set_source(gears.color(bg))
    cr:rectangle(0, 0, 30, 30)
    cr:fill()

    cr:set_source(gears.color(color))
    cr:select_font_face(font)
    cr:set_font_size(fontsize)
    local textWidth = cr:text_extents(text).width
    local textHeight = cr:text_extents(text).height
    cr:move_to(width / 2 - fontsize / 2 + tx, height / 2 + fontsize / 2 + ty)
    cr:show_text(text)
    return is
end

function module.titlebar_botton_image(args)
    local size = args.size or xresources.apply_dpi(25)
    local text = args.text or ""
    local bg = args.bg or "#999999"
    local fg = args.fg or "#00000055"

    local surface = cairo.ImageSurface.create(cairo.Format.ARGB32, size, size)
    local cr = cairo.Context.create(surface)
    cr.antialias = cairo.Antialias.BEST

    local radius = size / 4.5

    cr:arc(
        size / 2 - xresources.apply_dpi(0.2),
        size / 2 - xresources.apply_dpi(0.2),
        radius,
        math.rad(0),
        math.rad(360)
    )
    cr:set_source(gears.color(color.darken(bg, 50)))
    cr:fill()
    cr:arc(size / 2, size / 2, radius, math.rad(0), math.rad(360))
    cr:set_source(gears.color(color.darken(bg, 10)))
    cr:fill()

    cr:select_font_face(icon_font)
    local fontsize = radius * 1.5
    cr:set_font_size(fontsize)
    cr:move_to(size / 2 - fontsize / 2, size / 2 + fontsize / 2)
    cr:text_path(text)
    cr:set_operator(cairo.Operator.XOR)
    cr:fill()
    cr:set_source(gears.color(fg))
    cr:show_text(text)

    return surface
end

return module
