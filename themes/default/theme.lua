local gears = require("gears")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local cairo = require("lgi").cairo

xresources.set_dpi(120)
local dpi = xresources.apply_dpi

local themes_path = gears.filesystem.get_configuration_dir() .. "themes/default/"

local font = "Noto Sans Regular"
local icon_font = "Material Icons"

local theme = {}

theme.font_name = font
theme.icon_font_name = icon_font

local icon = function(args)
    local args = args or {}
    local text = args.text or ""
    local font = args.font or icon_font
    local tx = args.tx or 0
    local ty = args.ty or 0
    local color = args.color or theme.fg_normal
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

--[[
 ██████╗ ██████╗ ██╗      ██████╗ ██████╗
██╔════╝██╔═══██╗██║     ██╔═══██╗██╔══██╗
██║     ██║   ██║██║     ██║   ██║██████╔╝
██║     ██║   ██║██║     ██║   ██║██╔══██╗
╚██████╗╚██████╔╝███████╗╚██████╔╝██║  ██║
 ╚═════╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝

]]
local caa = "#252a33"
local cba = "#333842"
local cab = "#f0719b"
local cbb = "#f02e6e"
local cac = "#5af7b0"
local cbc = "#2ce592"
local cad = "#ffa56b"
local cbd = "#ff8537"
local cae = "#57c7ff"
local cbe = "#1da0e2"
local caf = "#c792ea"
local cbf = "#a742ea"
local cag = "#89edef"
local cbg = "#47eae8"
local cah = "#eeffff"
local cbh = "#dee6e7"

--[[
██████╗  █████╗ ███████╗███████╗
██╔══██╗██╔══██╗██╔════╝██╔════╝
██████╔╝███████║███████╗█████╗
██╔══██╗██╔══██║╚════██║██╔══╝
██████╔╝██║  ██║███████║███████╗
╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝

]]
theme.bg_normal = caa
theme.bg_focus = cba
theme.bg_urgent = cba
theme.bg_minimize = caa

theme.fg_normal = cbh
theme.fg_focus = cah
theme.fg_urgent = cah
theme.fg_minimize = cbh

theme.awesome_icon =
    icon(
    {
        text = utf8.char(0xe5c3),
        width = 50,
        height = 50,
        fontsize = 40,
        ty = -2
    }
)
theme.icon_theme = "Papirus"
theme.wallpaper = gears.filesystem.get_configuration_dir() .. "wallpapers/wallpaper.jpg"
theme.useless_gap = dpi(5)

--[[
███████╗ ██████╗ ███╗   ██╗████████╗
██╔════╝██╔═══██╗████╗  ██║╚══██╔══╝
█████╗  ██║   ██║██╔██╗ ██║   ██║
██╔══╝  ██║   ██║██║╚██╗██║   ██║
██║     ╚██████╔╝██║ ╚████║   ██║
╚═╝      ╚═════╝ ╚═╝  ╚═══╝   ╚═╝

]]
theme.font = font .. " 10"
theme.icon_font = icon_font .. " 20"

--[[
███╗   ███╗███████╗███╗   ██╗██╗   ██╗
████╗ ████║██╔════╝████╗  ██║██║   ██║
██╔████╔██║█████╗  ██╔██╗ ██║██║   ██║
██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║
██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝
╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝

]]
theme.menu_bg_normal = cba
theme.menu_font = font .. " 10"
theme.menu_submenu_icon =
    icon(
    {
        text = utf8.char(0xe5cc),
        width = 50,
        height = 50,
        fontsize = 40,
        ty = -2
    }
)
theme.menu_height = dpi(25)
theme.menu_width = dpi(220)
theme.menu_bg_focus = caa
theme.menu_border_width = 0

--[[
██╗    ██╗██╗██████╗  █████╗ ██████╗
██║    ██║██║██╔══██╗██╔══██╗██╔══██╗
██║ █╗ ██║██║██████╔╝███████║██████╔╝
██║███╗██║██║██╔══██╗██╔══██║██╔══██╗
╚███╔███╔╝██║██████╔╝██║  ██║██║  ██║
 ╚══╝╚══╝ ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝

]]
theme.wibar_height = 30
theme.wibar_bg = caa

--[[
████████╗ █████╗ ███████╗██╗  ██╗██╗     ██╗███████╗████████╗
╚══██╔══╝██╔══██╗██╔════╝██║ ██╔╝██║     ██║██╔════╝╚══██╔══╝
   ██║   ███████║███████╗█████╔╝ ██║     ██║███████╗   ██║
   ██║   ██╔══██║╚════██║██╔═██╗ ██║     ██║╚════██║   ██║
   ██║   ██║  ██║███████║██║  ██╗███████╗██║███████║   ██║
   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝╚══════╝   ╚═╝

]]
theme.tasklist_bg_focus = cah .. '66'
theme.tasklist_bg_normal = cba .. "00"
theme.tasklist_bg_minimize = caa .. '00'
theme.tasklist_indicator_focus = cbb
theme.tasklist_preview_box_bg = cba


--[[
████████╗ █████╗  ██████╗ ██╗     ██╗███████╗████████╗
╚══██╔══╝██╔══██╗██╔════╝ ██║     ██║██╔════╝╚══██╔══╝
   ██║   ███████║██║  ███╗██║     ██║███████╗   ██║
   ██║   ██╔══██║██║   ██ ║██║     ██║╚════██║   ██║
   ██║   ██║  ██║╚██████╔╝███████╗██║███████║   ██║
   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝╚══════╝   ╚═╝

]]
theme.taglist_bg_focus = cah
theme.taglist_bg_urgent = cbh
theme.taglist_bg_occupied = cbh
theme.taglist_bg_empty = cbh
theme.taglist_bg_volatile = cbh
theme.taglist_shape = gears.shape.circle
-- theme.taglist_shape_border_width_focus = 3
-- theme.taglist_shape_border_color_focus = fg_normal

--[[
██╗      █████╗ ██╗   ██╗ ██████╗ ██╗   ██╗████████╗██████╗  ██████╗ ██╗  ██╗
██║     ██╔══██╗╚██╗ ██╔╝██╔═══██╗██║   ██║╚══██╔══╝██╔══██╗██╔═══██╗╚██╗██╔╝
██║     ███████║ ╚████╔╝ ██║   ██║██║   ██║   ██║   ██████╔╝██║   ██║ ╚███╔╝
██║     ██╔══██║  ╚██╔╝  ██║   ██║██║   ██║   ██║   ██╔══██╗██║   ██║ ██╔██╗
███████╗██║  ██║   ██║   ╚██████╔╝╚██████╔╝   ██║   ██████╔╝╚██████╔╝██╔╝ ██╗
╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝  ╚═════╝    ╚═╝   ╚═════╝  ╚═════╝ ╚═╝  ╚═╝

]]
theme.layout_fairh = themes_path .. "assets/layouts/fairh.png"
theme.layout_fairv = themes_path .. "assets/layouts/fairv.png"
theme.layout_floating = themes_path .. "assets/layouts/floating.png"
theme.layout_magnifier = themes_path .. "assets/layouts/magnifier.png"
theme.layout_max = themes_path .. "assets/layouts/max.png"
theme.layout_fullscreen = themes_path .. "assets/layouts/fullscreen.png"
theme.layout_tilebottom = themes_path .. "assets/layouts/tilebottom.png"
theme.layout_tileleft = themes_path .. "assets/layouts/tileleft.png"
theme.layout_tile = themes_path .. "assets/layouts/tile.png"
theme.layout_tiletop = themes_path .. "assets/layouts/tiletop.png"
theme.layout_spiral = themes_path .. "assets/layouts/spiral.png"
theme.layout_dwindle = themes_path .. "assets/layouts/dwindle.png"
theme.layout_cornernw = themes_path .. "assets/layouts/cornernw.png"
theme.layout_cornerne = themes_path .. "assets/layouts/cornerne.png"
theme.layout_cornersw = themes_path .. "assets/layouts/cornersw.png"
theme.layout_cornerse = themes_path .. "assets/layouts/cornerse.png"
theme.layout_cornerse = themes_path .. "assets/layouts/cornerse.png"
theme.layout_cascade = themes_path .. "assets/layouts/dwindle.png"

--[[
████████╗ ██████╗  ██████╗ ██╗  ████████╗██╗██████╗
╚══██╔══╝██╔═══██╗██╔═══██╗██║  ╚══██╔══╝██║██╔══██╗
   ██║   ██║   ██║██║   ██║██║     ██║   ██║██████╔╝
   ██║   ██║   ██║██║   ██║██║     ██║   ██║██╔═══╝
   ██║   ╚██████╔╝╚██████╔╝███████╗██║   ██║██║
   ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚═╝   ╚═╝╚═╝

]]
-- theme.tooltip_shape = gears.shape.infobubble
theme.tooltip_bg = caa

--[[
██╗  ██╗ ██████╗ ████████╗██╗  ██╗███████╗██╗   ██╗███████╗
██║  ██║██╔═══██╗╚══██╔══╝██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔════╝
███████║██║   ██║   ██║   █████╔╝ █████╗   ╚████╔╝ ███████╗
██╔══██║██║   ██║   ██║   ██╔═██╗ ██╔══╝    ╚██╔╝  ╚════██║
██║  ██║╚██████╔╝   ██║   ██║  ██╗███████╗   ██║   ███████║
╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝

]]
theme.hotkeys_font = font .. "12"
theme.hotkeys_description_font = "Noto Sans Italic 11"
theme.hotkeys_bg = caa .. "cc"
theme.hotkeys_fg = cbh
theme.hotkeys_modifiers_fg = cbh
theme.hotkeys_group_margin = 40

--[[
███╗   ██╗ ██████╗ ████████╗██╗███████╗██╗ ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
████╗  ██║██╔═══██╗╚══██╔══╝██║██╔════╝██║██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
██╔██╗ ██║██║   ██║   ██║   ██║█████╗  ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║
██║╚██╗██║██║   ██║   ██║   ██║██╔══╝  ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
██║ ╚████║╚██████╔╝   ██║   ██║██║     ██║╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
╚═╝  ╚═══╝ ╚═════╝    ╚═╝   ╚═╝╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝

]]
theme.notification_font = theme.font
theme.notification_bg = caa
theme.notification_fg = cah
theme.notification_border_width = 0
theme.notification_border_color = caa
theme.notification_margin = 30
theme.notification_width= 400
theme.notification_icon_size = 150
-- theme.notification_shape = function(cr,w,h)
--    gears.shape.rounded_rect(cr,w,h,2)
-- end
-- theme.notification_opacity = 0.1

theme.systray_icon_spacing = 10

--[[
██████╗  ██████╗ ████████╗██████╗ ███████╗██████╗
██╔══██╗██╔═══██╗╚══██╔══╝██╔══██╗██╔════╝██╔══██╗
██████╔╝██║   ██║   ██║   ██║  ██║█████╗  ██████╔╝
██╔══██╗██║   ██║   ██║   ██║  ██║██╔══╝  ██╔══██╗
██████╔╝╚██████╔╝   ██║   ██████╔╝███████╗██║  ██║
╚═════╝  ╚═════╝    ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝

]]
theme.border_width = dpi(1)
theme.border_normal = caa .. "55"
theme.border_focus = cbf .. "55"
theme.border_marked = cba .. "55"
theme.border_select = cac .. "55"

--[[
████████╗██╗████████╗██╗     ███████╗██████╗  █████╗ ██████╗
╚══██╔══╝██║╚══██╔══╝██║     ██╔════╝██╔══██╗██╔══██╗██╔══██╗
   ██║   ██║   ██║   ██║     █████╗  ██████╔╝███████║██████╔╝
   ██║   ██║   ██║   ██║     ██╔══╝  ██╔══██╗██╔══██║██╔══██╗
   ██║   ██║   ██║   ███████╗███████╗██████╔╝██║  ██║██║  ██║
   ╚═╝   ╚═╝   ╚═╝   ╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
      
]]
theme.titlebar_bg_normal = caa .. '33'
theme.titlebar_bg_focus = caa .. '66'
theme.titlebar_font = font .. " 10"

theme.titlebar_close_button_normal =
    icon(
    {
        text = utf8.char(0xe5cd),
        font = icon_font
    }
)
theme.titlebar_close_button_focus = theme.titlebar_close_button_normal

theme.titlebar_close_button_normal_hover =
    icon(
    {
        text = utf8.char(0xe5cd),
        font = icon_font,
        color = cah,
        bg = cba
    }
)
theme.titlebar_close_button_normal_press = theme.titlebar_close_button_normal_hover
theme.titlebar_close_button_focus_hover = theme.titlebar_close_button_normal_hover
theme.titlebar_close_button_focus_press = theme.titlebar_close_button_normal_hover

theme.titlebar_maximized_button_normal_inactive =
    icon(
    {
        text = utf8.char(0xe5d0),
        font = icon_font
    }
)
theme.titlebar_maximized_button_focus_inactive = theme.titlebar_maximized_button_normal_inactive
theme.titlebar_maximized_button_normal_active =
    icon(
    {
        text = utf8.char(0xe5d1),
        font = icon_font
    }
)
theme.titlebar_maximized_button_focus_active = theme.titlebar_maximized_button_normal_active

theme.titlebar_maximized_button_normal_inactive_hover =
    icon(
    {
        text = utf8.char(0xe5d0),
        font = icon_font,
        color = cah,
        bg = cba
    }
)
theme.titlebar_maximized_button_normal_inactive_press = theme.titlebar_maximized_button_normal_inactive_hover
theme.titlebar_maximized_button_focus_inactive_hover = theme.titlebar_maximized_button_normal_inactive_hover
theme.titlebar_maximized_button_focus_inactive_press = theme.titlebar_maximized_button_normal_inactive_hover
theme.titlebar_maximized_button_normal_active_hover =
    icon(
    {
        text = utf8.char(0xe5d1),
        font = icon_font,
        color = cah,
        bg = cba
    }
)
theme.titlebar_maximized_button_normal_active_press = theme.titlebar_maximized_button_normal_active_hover
theme.titlebar_maximized_button_focus_active_hover = theme.titlebar_maximized_button_normal_active_hover
theme.titlebar_maximized_button_focus_active_press = theme.titlebar_maximized_button_normal_active_hover

theme.titlebar_minimize_button_normal =
    icon(
    {
        text = utf8.char(0xe313),
        font = icon_font
    }
)
theme.titlebar_minimize_button_focus = theme.titlebar_minimize_button_normal
theme.titlebar_minimize_button_normal_hover =
    icon(
    {
        text = utf8.char(0xe313),
        font = icon_font,
        color = cah,
        bg = cba
    }
)
theme.titlebar_minimize_button_normal_press = theme.titlebar_minimize_button_normal_hover
theme.titlebar_minimize_button_focus_hover = theme.titlebar_minimize_button_normal_hover
theme.titlebar_minimize_button_focus_press = theme.titlebar_minimize_button_normal_hover

theme.titlebar_ontop_button_normal_inactive =
    icon(
    {
        text = utf8.char(0xe5c7),
        font = icon_font,
        fontsize = 22
    }
)
theme.titlebar_ontop_button_focus_inactive = theme.titlebar_ontop_button_normal_inactive
theme.titlebar_ontop_button_normal_inactive_hover =
    icon(
    {
        text = utf8.char(0xe5c7),
        font = icon_font,
        fontsize = 22,
        bg = cba
    }
)
theme.titlebar_ontop_button_focus_inactive_hover = theme.titlebar_ontop_button_normal_inactive_hover
theme.titlebar_ontop_button_normal_active =
    icon(
    {
        text = utf8.char(0xe5c5),
        font = icon_font,
        fontsize = 22
    }
)
theme.titlebar_ontop_button_focus_active = theme.titlebar_ontop_button_normal_active
theme.titlebar_ontop_button_normal_active_hover =
    icon(
    {
        text = utf8.char(0xe5c5),
        font = icon_font,
        fontsize = 22,
        bg = cba
    }
)

theme.titlebar_ontop_button_focus_active_hover = theme.titlebar_ontop_button_normal_active_hover

theme.titlebar_floating_button_normal_inactive =
    icon(
    {
        text = utf8.char(0xe15a),
        fontsize = 15
    }
)
theme.titlebar_floating_button_focus_inactive = theme.titlebar_floating_button_normal_inactive
theme.titlebar_floating_button_normal_inactive_hover =
    icon(
    {
        text = utf8.char(0xe15a),
        fontsize = 15,
        bg = cba
    }
)
theme.titlebar_floating_button_focus_inactive_hover = theme.titlebar_floating_button_normal_inactive_hover

theme.titlebar_floating_button_normal_active =
    icon(
    {
        text = utf8.char(0xe166),
        fontsize = 15
    }
)
theme.titlebar_floating_button_focus_active = theme.titlebar_floating_button_normal_active
theme.titlebar_floating_button_normal_active_hover =
    icon(
    {
        text = utf8.char(0xe166),
        fontsize = 15,
        bg = cba
    }
)
theme.titlebar_floating_button_focus_active_hover = theme.titlebar_floating_button_normal_active_hover

theme.titlebar_sticky_button_normal_inactive =
    icon(
    {
        text = utf8.char(0xe3f1),
        fontsize = 15
    }
)
theme.titlebar_sticky_button_focus_inactive = theme.titlebar_sticky_button_normal_inactive
theme.titlebar_sticky_button_normal_inactive_hover =
    icon(
    {
        text = utf8.char(0xe3f1),
        fontsize = 15,
        bg = cba
    }
)
theme.titlebar_sticky_button_focus_inactive_hover = theme.titlebar_sticky_button_normal_inactive_hover

theme.titlebar_sticky_button_normal_active =
    icon(
    {
        text = utf8.char(0xe3f2),
        fontsize = 15
    }
)
theme.titlebar_sticky_button_focus_active = theme.titlebar_sticky_button_normal_active
theme.titlebar_sticky_button_normal_active_hover =
    icon(
    {
        text = utf8.char(0xe3f2),
        fontsize = 15,
        bg = cba
    }
)

theme.titlebar_sticky_button_focus_active_hover = theme.titlebar_sticky_button_normal_active_hover

--[[
██╗      █████╗ ██╗   ██╗ ██████╗ ██╗   ██╗████████╗
██║     ██╔══██╗╚██╗ ██╔╝██╔═══██╗██║   ██║╚══██╔══╝
██║     ███████║ ╚████╔╝ ██║   ██║██║   ██║   ██║
██║     ██╔══██║  ╚██╔╝  ██║   ██║██║   ██║   ██║
███████╗██║  ██║   ██║   ╚██████╔╝╚██████╔╝   ██║
╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝  ╚═════╝    ╚═╝

]]
theme.master_width_factor = 0.6

theme.system_monitor =
    icon(
    {
        text = utf8.char(0xe54a),
        fontsize = 30
    }
)

theme.net_monitor =
    icon(
    {
        text = utf8.char(0xe2bd),
        fontsize = 30
    }
)
theme.time =
    icon(
    {
        text = utf8.char(0xe01b),
        fontsize = 30
    }
)

-- Switcher
theme.switcher_preview_box_delay = 10
theme.switcher_preview_box_border = caa
theme.switcher_preview_box_bg = caa .. "dd"
theme.switcher_preview_box_title_color = cbh
theme.switcher_client_bg_selected = cbe
theme.switcher_client_bg_normal = cba .. "dd"
theme.switcher_client_border_color = cac
return theme
