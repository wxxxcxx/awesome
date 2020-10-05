local gears = require("gears")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local cairo = require("lgi").cairo
local utils = require("utils")

-- xresources.set_dpi(120)
local dpi = xresources.apply_dpi

local themes_path = gears.filesystem.get_configuration_dir() .. "themes/default/"

local theme = {}

--[[
███████╗ ██████╗ ███╗   ██╗████████╗
██╔════╝██╔═══██╗████╗  ██║╚══██╔══╝
█████╗  ██║   ██║██╔██╗ ██║   ██║
██╔══╝  ██║   ██║██║╚██╗██║   ██║
██║     ╚██████╔╝██║ ╚████║   ██║
╚═╝      ╚═════╝ ╚═╝  ╚═══╝   ╚═╝

]]
-- theme.font = font .. " 10"
local font = "Noto Sans Regular"
local icon_font = "Material Icons"
local small_font_size = 8
local font_size = 10
local large_font_size = 12
theme.font_name = font
theme.icon_font_name = icon_font
theme.font = font .. " 10"
theme.icon_font = icon_font .. " 20"

theme.awesome_icon =
    utils.image.iconfont(
    {
        text = utf8.char(0xe5c3),
        width = 50,
        height = 50,
        fontsize = 40,
        ty = -2
    }
)

theme.icon_theme = "Numix-White"
theme.wallpaper = gears.filesystem.get_configuration_dir() .. "wallpapers/bg.jpg"
theme.useless_gap = dpi(7)

--[[
 ██████╗ ██████╗ ██╗      ██████╗ ██████╗
██╔════╝██╔═══██╗██║     ██╔═══██╗██╔══██╗
██║     ██║   ██║██║     ██║   ██║██████╔╝
██║     ██║   ██║██║     ██║   ██║██╔══██╗
╚██████╗╚██████╔╝███████╗╚██████╔╝██║  ██║
 ╚═════╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝

]]
local major_color = "#21252b"
local minor_color = "#282c34"
local inverse_major_color = "#dee6e7"
local inverse_minor_color = "#eeffff"
local accent_color = "#aca2ec"
local transparent = "#00000000"
local caa = "#21252b"
local cba = "#333842"
local cab = "#f0719b"
local cbb = "#f02e4e"
local cac = "#5af7b0"
local cbc = "#2ce592"
local cad = "#ffd56b"
local cbd = "#ff8537"
local cae = "#00afff"
local cbe = "#1da0e2"
local caf = "#7065d1"
local cbf = "#b0a5f1"
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
theme.bg_normal = major_color
theme.fg_normal = inverse_major_color
theme.bg_focus = minor_color
theme.fg_focus = inverse_minor_color
theme.bg_urgent = major_color
theme.fg_urgent = inverse_major_color
theme.bg_minimize = major_color
theme.fg_minimize = inverse_major_color

--[[
███╗   ███╗███████╗███╗   ██╗██╗   ██╗
████╗ ████║██╔════╝████╗  ██║██║   ██║
██╔████╔██║█████╗  ██╔██╗ ██║██║   ██║
██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║
██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝
╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝

]]
theme.menu_bg_normal = minor_color
theme.menu_fg_normal = utils.color.auto_lighten_or_darken(inverse_minor_color, 20)
theme.menu_bg_focus = utils.color.auto_lighten_or_darken(minor_color, 10)
theme.menu_fg_focus = inverse_minor_color

theme.menu_font = font .. " 10"
theme.menu_submenu_icon =
    utils.image.iconfont(
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
theme.wibar_bg = major_color

--[[
████████╗ █████╗ ███████╗██╗  ██╗██╗     ██╗███████╗████████╗
╚══██╔══╝██╔══██╗██╔════╝██║ ██╔╝██║     ██║██╔════╝╚══██╔══╝
   ██║   ███████║███████╗█████╔╝ ██║     ██║███████╗   ██║
   ██║   ██╔══██║╚════██║██╔═██╗ ██║     ██║╚════██║   ██║
   ██║   ██║  ██║███████║██║  ██╗███████╗██║███████║   ██║
   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝╚══════╝   ╚═╝

]]
theme.tasklist_bg_focus = accent_color
theme.tasklist_bg_normal = accent_color .. "20"
theme.tasklist_bg_minimize = transparent

--[[
████████╗ █████╗  ██████╗ ██╗     ██╗███████╗████████╗
╚══██╔══╝██╔══██╗██╔════╝ ██║     ██║██╔════╝╚══██╔══╝
   ██║   ███████║██║  ███╗██║     ██║███████╗   ██║
   ██║   ██╔══██║██║   ██ ║██║     ██║╚════██║   ██║
   ██║   ██║  ██║╚██████╔╝███████╗██║███████║   ██║
   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝╚══════╝   ╚═╝

]]
-- theme.taglist_font = icon_font .. " 12"
theme.taglist_bg_focus = accent_color
theme.taglist_bg_urgent = accent_color .. "60"
theme.taglist_bg_occupied = accent_color .. "60"
theme.taglist_bg_empty = accent_color .. "00"
theme.taglist_bg_volatile = accent_color .. "60"

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
theme.tooltip_bg = minor_color
theme.tooltip_border_width = 0

-- --[[
-- ██╗  ██╗ ██████╗ ████████╗██╗  ██╗███████╗██╗   ██╗███████╗
-- ██║  ██║██╔═══██╗╚══██╔══╝██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔════╝
-- ███████║██║   ██║   ██║   █████╔╝ █████╗   ╚████╔╝ ███████╗
-- ██╔══██║██║   ██║   ██║   ██╔═██╗ ██╔══╝    ╚██╔╝  ╚════██║
-- ██║  ██║╚██████╔╝   ██║   ██║  ██╗███████╗   ██║   ███████║
-- ╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝

-- ]]
-- theme.hotkeys_font = font .. "12"
-- theme.hotkeys_description_font = "Noto Sans Italic 11"
-- theme.hotkeys_bg = caa .. "cc"
-- theme.hotkeys_fg = cbh
-- theme.hotkeys_modifiers_fg = cbh
-- theme.hotkeys_group_margin = 40

--[[
███╗   ██╗ ██████╗ ████████╗██╗███████╗██╗ ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
████╗  ██║██╔═══██╗╚══██╔══╝██║██╔════╝██║██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
██╔██╗ ██║██║   ██║   ██║   ██║█████╗  ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║
██║╚██╗██║██║   ██║   ██║   ██║██╔══╝  ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
██║ ╚████║╚██████╔╝   ██║   ██║██║     ██║╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
╚═╝  ╚═══╝ ╚═════╝    ╚═╝   ╚═╝╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝

]]
theme.notification_font = theme.font
theme.notification_bg = minor_color
theme.notification_fg = inverse_minor_color
theme.notification_border_width = 0
theme.notification_border_color = caa
theme.notification_margin = 30
theme.notification_width = 400
theme.notification_icon_size = 150

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
theme.border_normal = transparent
-- theme.border_focus = caa
theme.border_focus = transparent
theme.border_marked = transparent
theme.border_select = transparent

--[[
████████╗██╗████████╗██╗     ███████╗██████╗  █████╗ ██████╗
╚══██╔══╝██║╚══██╔══╝██║     ██╔════╝██╔══██╗██╔══██╗██╔══██╗
   ██║   ██║   ██║   ██║     █████╗  ██████╔╝███████║██████╔╝
   ██║   ██║   ██║   ██║     ██╔══╝  ██╔══██╗██╔══██║██╔══██╗
   ██║   ██║   ██║   ███████╗███████╗██████╔╝██║  ██║██║  ██║
   ╚═╝   ╚═╝   ╚═╝   ╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝

]]
theme.titlebar_bg_normal = transparent
theme.titlebar_bg_focus = transparent
theme.titlebar_font = transparent

local normal = {}
local focus = {
    bg = "#f02e4e"
}
local hover = {
    bg = "#f02e4e",
    text = utf8.char(0xe5cd)
}


theme.titlebar_close_button_normal = utils.image.titlebar_botton_image(normal)
theme.titlebar_close_button_normal_hover = utils.image.titlebar_botton_image(hover)
theme.titlebar_close_button_normal_press = utils.image.titlebar_botton_image(hover)
theme.titlebar_close_button_focus = utils.image.titlebar_botton_image(focus)
theme.titlebar_close_button_focus_hover = utils.image.titlebar_botton_image(hover)
theme.titlebar_close_button_focus_press = utils.image.titlebar_botton_image(hover)

focus.bg = "#2ce592"
hover.bg = "#2ce592"
hover.text = utf8.char(0xe5d0)
theme.titlebar_maximized_button_normal_inactive = utils.image.titlebar_botton_image(normal)
theme.titlebar_maximized_button_normal_inactive_hover = utils.image.titlebar_botton_image(hover)
theme.titlebar_maximized_button_normal_inactive_press = utils.image.titlebar_botton_image(hover)
theme.titlebar_maximized_button_focus_inactive = utils.image.titlebar_botton_image(focus)
theme.titlebar_maximized_button_focus_inactive_hover = utils.image.titlebar_botton_image(hover)
theme.titlebar_maximized_button_focus_inactive_press = utils.image.titlebar_botton_image(hover)
focus.bg = "#2c97df"
hover.bg = "#2c97df"
hover.text = utf8.char(0xe5d1)
theme.titlebar_maximized_button_normal_active = utils.image.titlebar_botton_image(normal)
theme.titlebar_maximized_button_normal_active_hover = utils.image.titlebar_botton_image(hover)
theme.titlebar_maximized_button_normal_active_press = utils.image.titlebar_botton_image(hover)
theme.titlebar_maximized_button_focus_active = utils.image.titlebar_botton_image(focus)
theme.titlebar_maximized_button_focus_active_hover = utils.image.titlebar_botton_image(hover)
theme.titlebar_maximized_button_focus_active_press = utils.image.titlebar_botton_image(hover)

focus.bg = "#ffd56b"
hover.bg = "#ffd56b"
hover.text = utf8.char(0xe313)
theme.titlebar_minimize_button_normal = utils.image.titlebar_botton_image(normal)
theme.titlebar_minimize_button_normal_hover = utils.image.titlebar_botton_image(hover)
theme.titlebar_minimize_button_normal_press = utils.image.titlebar_botton_image(hover)
theme.titlebar_minimize_button_focus = utils.image.titlebar_botton_image(focus)
theme.titlebar_minimize_button_focus_hover = utils.image.titlebar_botton_image(hover)
theme.titlebar_minimize_button_focus_press = utils.image.titlebar_botton_image(hover)

local active = {
    bg = "#7065d1"
}
local inactice = {
    bg = "#999999"
}

theme.titlebar_ontop_button_normal_inactive = utils.image.titlebar_botton_image(inactice)
theme.titlebar_ontop_button_normal_inactive_hover = utils.image.titlebar_botton_image(inactice)
theme.titlebar_ontop_button_focus_inactive = utils.image.titlebar_botton_image(inactice)
theme.titlebar_ontop_button_focus_inactive_hover = utils.image.titlebar_botton_image(inactice)

theme.titlebar_ontop_button_normal_active = utils.image.titlebar_botton_image(active)
theme.titlebar_ontop_button_normal_active_hover = utils.image.titlebar_botton_image(active)
theme.titlebar_ontop_button_focus_active = utils.image.titlebar_botton_image(active)
theme.titlebar_ontop_button_focus_active_hover = utils.image.titlebar_botton_image(active)

theme.titlebar_floating_button_normal_inactive = utils.image.titlebar_botton_image(inactice)
theme.titlebar_floating_button_normal_inactive_hover = utils.image.titlebar_botton_image(inactice)
theme.titlebar_floating_button_focus_inactive = utils.image.titlebar_botton_image(inactice)
theme.titlebar_floating_button_focus_inactive_hover = utils.image.titlebar_botton_image(inactice)

theme.titlebar_floating_button_normal_active = utils.image.titlebar_botton_image(active)
theme.titlebar_floating_button_normal_active_hover = utils.image.titlebar_botton_image(active)
theme.titlebar_floating_button_focus_active = utils.image.titlebar_botton_image(active)
theme.titlebar_floating_button_focus_active_hover = utils.image.titlebar_botton_image(active)

theme.titlebar_sticky_button_normal_inactive = utils.image.titlebar_botton_image(inactice)
theme.titlebar_sticky_button_normal_inactive_hover = utils.image.titlebar_botton_image(inactice)
theme.titlebar_sticky_button_focus_inactive = utils.image.titlebar_botton_image(inactice)
theme.titlebar_sticky_button_focus_inactive_hover = utils.image.titlebar_botton_image(inactice)

hover.text = utf8.char(0xe3f2)
theme.titlebar_sticky_button_normal_active = utils.image.titlebar_botton_image(active)
theme.titlebar_sticky_button_normal_active_hover = utils.image.titlebar_botton_image(active)
theme.titlebar_sticky_button_focus_active = utils.image.titlebar_botton_image(active)
theme.titlebar_sticky_button_focus_active_hover = utils.image.titlebar_botton_image(active)

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
    utils.image.iconfont(
    {
        text = utf8.char(0xe54a),
        fontsize = 30
    }
)

theme.net_monitor =
    utils.image.iconfont(
    {
        text = utf8.char(0xe2bd),
        fontsize = 30
    }
)
theme.time =
    utils.image.iconfont(
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
