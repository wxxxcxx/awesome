local gears = require("gears")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local gtk = require("beautiful.gtk")
local cairo = require("lgi").cairo
local utils = require("utils")

local theme = {}

local gtk_theme = gtk.get_theme_variables()
local themes_path = gears.filesystem.get_configuration_dir() ..
                        "themes/default/"

local transparent = "#00000000"
local icon_font = "Material Icons"
theme.icon_theme = "Flat-Remix-Blue"
theme.wallpaper = gears.filesystem.get_configuration_dir() ..
                      "wallpapers/sea.png"
theme.useless_gap = xresources.apply_dpi(7)
theme.gtk_theme = gtk_theme

theme.systray_icon_spacing = 10

--[[
███████╗ ██████╗ ███╗   ██╗████████╗
██╔════╝██╔═══██╗████╗  ██║╚══██╔══╝
█████╗  ██║   ██║██╔██╗ ██║   ██║
██╔══╝  ██║   ██║██║╚██╗██║   ██║
██║     ╚██████╔╝██║ ╚████║   ██║
╚═╝      ╚═════╝ ╚═╝  ╚═══╝   ╚═╝

]]
-- theme.font = font .. " 10"

theme.icon_font_name = icon_font
theme.font = gtk_theme.font_family .. " " .. gtk_theme.font_size
theme.icon_font = icon_font .. " 20"

theme.awesome_icon = utils.image.iconfont {
    text = utf8.char(0xe80e),
    width = 50,
    height = 50,
    fontsize = 40,
    ty = -2
}

--[[
██████╗  █████╗ ███████╗███████╗
██╔══██╗██╔══██╗██╔════╝██╔════╝
██████╔╝███████║███████╗█████╗
██╔══██╗██╔══██║╚════██║██╔══╝
██████╔╝██║  ██║███████║███████╗
╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝

]]
theme.bg_normal = gtk_theme.bg_color
theme.fg_normal = gtk_theme.fg_color

theme.bg_focus = utils.color.auto_lighten_or_darken(gtk_theme.bg_color, 5)
theme.fg_focus = gtk_theme.fg_color

theme.bg_urgent = utils.color.auto_lighten_or_darken(gtk_theme.bg_color, 40)
theme.fg_urgent = gtk_theme.fg_color

theme.bg_minimize = utils.color.opacity(gtk_theme.bg_color, 0)
theme.fg_minimize = gtk_theme.fg_color

--[[
███╗   ███╗███████╗███╗   ██╗██╗   ██╗
████╗ ████║██╔════╝████╗  ██║██║   ██║
██╔████╔██║█████╗  ██╔██╗ ██║██║   ██║
██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║
██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝
╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝

]]
theme.menu_bg_normal = gtk_theme.menubar_bg_color
theme.menu_fg_normal = gtk_theme.menubar_fg_color

theme.menu_bg_focus = gtk_theme.selected_bg_color
theme.menu_fg_focus = gtk_theme.selected_fg_color

theme.menu_submenu_icon = utils.image.iconfont {
    text = utf8.char(0xe5cc),
    width = 50,
    height = 50,
    fontsize = 40,
    ty = -2
}

theme.menu_height = xresources.apply_dpi(25)
theme.menu_width = xresources.apply_dpi(220)
theme.menu_border_width = 0
theme.menu_border_color = utils.color.auto_lighten_or_darken(
                              theme.menu_bg_normal, 20)

--[[
██╗    ██╗██╗██████╗  █████╗ ██████╗
██║    ██║██║██╔══██╗██╔══██╗██╔══██╗
██║ █╗ ██║██║██████╔╝███████║██████╔╝
██║███╗██║██║██╔══██╗██╔══██║██╔══██╗
╚███╔███╔╝██║██████╔╝██║  ██║██║  ██║
 ╚══╝╚══╝ ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝

]]
theme.wibar_height = xresources.apply_dpi(25)

theme.wibar_bg = utils.color.opacity(gtk_theme.bg_color, 1)
theme.wibar_border_width = 0
theme.wibar_border_color = utils.color
                               .auto_lighten_or_darken(theme.wibar_bg, 10)

--[[
████████╗ █████╗ ███████╗██╗  ██╗██╗     ██╗███████╗████████╗
╚══██╔══╝██╔══██╗██╔════╝██║ ██╔╝██║     ██║██╔════╝╚══██╔══╝
   ██║   ███████║███████╗█████╔╝ ██║     ██║███████╗   ██║
   ██║   ██╔══██║╚════██║██╔═██╗ ██║     ██║╚════██║   ██║
   ██║   ██║  ██║███████║██║  ██╗███████╗██║███████║   ██║
   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝╚══════╝   ╚═╝

]]
theme.tasklist_bg_focus = gtk_theme.selected_bg_color
theme.tasklist_bg_normal = utils.color.opacity(gtk_theme.selected_bg_color, 0.4)
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
theme.taglist_bg_focus = gtk_theme.selected_bg_color
theme.taglist_bg_urgent = utils.color.opacity(gtk_theme.selected_bg_color, 0.4)
theme.taglist_bg_occupied = utils.color
                                .opacity(gtk_theme.selected_bg_color, 0.4)
theme.taglist_bg_volatile = utils.color
                                .opacity(gtk_theme.selected_bg_color, 0.4)
theme.taglist_bg_empty = transparent

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
theme.tooltip_bg = gtk_theme.tooltip_bg_color
theme.tooltip_fg = gtk_theme.tooltip_fg_color
theme.tooltip_border_width = 1
theme.tooltip_border_color = utils.color.auto_lighten_or_darken(
                                 gtk_theme.tooltip_bg_color, 20)

-- --[[
-- ██╗  ██╗ ██████╗ ████████╗██╗  ██╗███████╗██╗   ██╗███████╗
-- ██║  ██║██╔═══██╗╚══██╔══╝██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔════╝
-- ███████║██║   ██║   ██║   █████╔╝ █████╗   ╚████╔╝ ███████╗
-- ██╔══██║██║   ██║   ██║   ██╔═██╗ ██╔══╝    ╚██╔╝  ╚════██║
-- ██║  ██║╚██████╔╝   ██║   ██║  ██╗███████╗   ██║   ███████║
-- ╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝

-- ]]
theme.hotkeys_font = gtk_theme.font_family .. " " .. gtk_theme.font_size
theme.hotkeys_description_font = gtk_theme.font_family .. " " ..
                                     gtk_theme.font_size * 0.8

theme.hotkeys_bg = gtk_theme.bg_color
theme.hotkeys_fg = gtk_theme.fg_color
theme.hotkeys_modifiers_fg = utils.color.auto_lighten_or_darken(
                                 gtk_theme.fg_color, 50)

theme.hotkeys_group_margin = 40

--[[
███╗   ██╗ ██████╗ ████████╗██╗███████╗██╗ ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
████╗  ██║██╔═══██╗╚══██╔══╝██║██╔════╝██║██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
██╔██╗ ██║██║   ██║   ██║   ██║█████╗  ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║
██║╚██╗██║██║   ██║   ██║   ██║██╔══╝  ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
██║ ╚████║╚██████╔╝   ██║   ██║██║     ██║╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
╚═╝  ╚═══╝ ╚═════╝    ╚═╝   ╚═╝╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝

]]
theme.notification_font = gtk_theme.font_family .. " " .. gtk_theme.font_size
theme.notification_bg = gtk_theme.bg_color
theme.notification_fg = gtk_theme.fg_color
theme.notification_border_width = 0
theme.notification_border_color = caa
theme.notification_margin = 30
theme.notification_width = 400
theme.notification_icon_size = 150

--[[
██████╗  ██████╗ ████████╗██████╗ ███████╗██████╗
██╔══██╗██╔═══██╗╚══██╔══╝██╔══██╗██╔════╝██╔══██╗
██████╔╝██║   ██║   ██║   ██║  ██║█████╗  ██████╔╝
██╔══██╗██║   ██║   ██║   ██║  ██║██╔══╝  ██╔══██╗
██████╔╝╚██████╔╝   ██║   ██████╔╝███████╗██║  ██║
╚═════╝  ╚═════╝    ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝

]]
theme.border_width = 1
theme.border_normal = transparent
-- theme.border_focus = caa
theme.border_focus = transparent
theme.border_marked = transparent
theme.border_select = transparent
theme.maximumed_hide_border = true

theme.snap_bg = gtk_theme.bg_color
theme.snap_border_width = 1

--[[
████████╗██╗████████╗██╗     ███████╗██████╗  █████╗ ██████╗
╚══██╔══╝██║╚══██╔══╝██║     ██╔════╝██╔══██╗██╔══██╗██╔══██╗
   ██║   ██║   ██║   ██║     █████╗  ██████╔╝███████║██████╔╝
   ██║   ██║   ██║   ██║     ██╔══╝  ██╔══██╗██╔══██║██╔══██╗
   ██║   ██║   ██║   ███████╗███████╗██████╔╝██║  ██║██║  ██║
   ╚═╝   ╚═╝   ╚═╝   ╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝

]]
theme.titlebar_bg_normal = gtk_theme.bg_color
theme.titlebar_bg_focus = gtk_theme.bg_color

local normal = {}
local focus = {bg = "#d31919"}
local hover = {bg = "#d31919", text = utf8.char(0xe5cd)}

theme.titlebar_close_button_normal = utils.image.titlebar_botton_image(normal)
theme.titlebar_close_button_normal_hover =
    utils.image.titlebar_botton_image(hover)
theme.titlebar_close_button_normal_press =
    utils.image.titlebar_botton_image(hover)
theme.titlebar_close_button_focus = utils.image.titlebar_botton_image(focus)
theme.titlebar_close_button_focus_hover =
    utils.image.titlebar_botton_image(hover)
theme.titlebar_close_button_focus_press =
    utils.image.titlebar_botton_image(hover)

focus.bg = "#2777ff"
hover.bg = "#2777ff"
hover.text = utf8.char(0xe5d0)
theme.titlebar_maximized_button_normal_inactive =
    utils.image.titlebar_botton_image(normal)
theme.titlebar_maximized_button_normal_inactive_hover =
    utils.image.titlebar_botton_image(hover)
theme.titlebar_maximized_button_normal_inactive_press =
    utils.image.titlebar_botton_image(hover)
theme.titlebar_maximized_button_focus_inactive =
    utils.image.titlebar_botton_image(focus)
theme.titlebar_maximized_button_focus_inactive_hover =
    utils.image.titlebar_botton_image(hover)
theme.titlebar_maximized_button_focus_inactive_press =
    utils.image.titlebar_botton_image(hover)
focus.bg = "#19a187"
hover.bg = "#19a187"
hover.text = utf8.char(0xe5d1)
theme.titlebar_maximized_button_normal_active =
    utils.image.titlebar_botton_image(normal)
theme.titlebar_maximized_button_normal_active_hover =
    utils.image.titlebar_botton_image(hover)
theme.titlebar_maximized_button_normal_active_press =
    utils.image.titlebar_botton_image(hover)
theme.titlebar_maximized_button_focus_active =
    utils.image.titlebar_botton_image(focus)
theme.titlebar_maximized_button_focus_active_hover =
    utils.image.titlebar_botton_image(hover)
theme.titlebar_maximized_button_focus_active_press =
    utils.image.titlebar_botton_image(hover)

focus.bg = "#ff6600"
hover.bg = "#ff6600"
hover.text = utf8.char(0xe313)
theme.titlebar_minimize_button_normal = utils.image
                                            .titlebar_botton_image(normal)
theme.titlebar_minimize_button_normal_hover =
    utils.image.titlebar_botton_image(hover)
theme.titlebar_minimize_button_normal_press =
    utils.image.titlebar_botton_image(hover)
theme.titlebar_minimize_button_focus = utils.image.titlebar_botton_image(focus)
theme.titlebar_minimize_button_focus_hover =
    utils.image.titlebar_botton_image(hover)
theme.titlebar_minimize_button_focus_press =
    utils.image.titlebar_botton_image(hover)

local active = {bg = "#19a187"}

local inactice = {bg = "#999999"}
theme.titlebar_ontop_button_normal_inactive =
    utils.image.titlebar_botton_image(inactice)
theme.titlebar_ontop_button_normal_inactive_hover =
    utils.image.titlebar_botton_image(inactice)
theme.titlebar_ontop_button_focus_inactive =
    utils.image.titlebar_botton_image(inactice)
theme.titlebar_ontop_button_focus_inactive_hover =
    utils.image.titlebar_botton_image(inactice)

theme.titlebar_ontop_button_normal_active =
    utils.image.titlebar_botton_image(active)
theme.titlebar_ontop_button_normal_active_hover =
    utils.image.titlebar_botton_image(active)
theme.titlebar_ontop_button_focus_active =
    utils.image.titlebar_botton_image(active)
theme.titlebar_ontop_button_focus_active_hover =
    utils.image.titlebar_botton_image(active)

theme.titlebar_floating_button_normal_inactive =
    utils.image.titlebar_botton_image(inactice)
theme.titlebar_floating_button_normal_inactive_hover =
    utils.image.titlebar_botton_image(inactice)
theme.titlebar_floating_button_focus_inactive =
    utils.image.titlebar_botton_image(inactice)
theme.titlebar_floating_button_focus_inactive_hover =
    utils.image.titlebar_botton_image(inactice)

theme.titlebar_floating_button_normal_active =
    utils.image.titlebar_botton_image(active)
theme.titlebar_floating_button_normal_active_hover =
    utils.image.titlebar_botton_image(active)
theme.titlebar_floating_button_focus_active =
    utils.image.titlebar_botton_image(active)
theme.titlebar_floating_button_focus_active_hover =
    utils.image.titlebar_botton_image(active)

theme.titlebar_sticky_button_normal_inactive =
    utils.image.titlebar_botton_image(inactice)
theme.titlebar_sticky_button_normal_inactive_hover =
    utils.image.titlebar_botton_image(inactice)
theme.titlebar_sticky_button_focus_inactive =
    utils.image.titlebar_botton_image(inactice)
theme.titlebar_sticky_button_focus_inactive_hover =
    utils.image.titlebar_botton_image(inactice)

hover.text = utf8.char(0xe3f2)
theme.titlebar_sticky_button_normal_active =
    utils.image.titlebar_botton_image(active)
theme.titlebar_sticky_button_normal_active_hover =
    utils.image.titlebar_botton_image(active)
theme.titlebar_sticky_button_focus_active =
    utils.image.titlebar_botton_image(active)
theme.titlebar_sticky_button_focus_active_hover =
    utils.image.titlebar_botton_image(active)

--[[
██╗      █████╗ ██╗   ██╗ ██████╗ ██╗   ██╗████████╗
██║     ██╔══██╗╚██╗ ██╔╝██╔═══██╗██║   ██║╚══██╔══╝
██║     ███████║ ╚████╔╝ ██║   ██║██║   ██║   ██║
██║     ██╔══██║  ╚██╔╝  ██║   ██║██║   ██║   ██║
███████╗██║  ██║   ██║   ╚██████╔╝╚██████╔╝   ██║
╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝  ╚═════╝    ╚═╝

]]
theme.master_width_factor = 0.6

-- Switcher
theme.switcher_preview_box_delay = 10
theme.switcher_preview_box_border = major_color
theme.switcher_preview_box_bg = major_color
theme.switcher_preview_box_title_color = inverse_major_color
theme.switcher_client_bg_selected = accent_color
theme.switcher_client_bg_normal = minor_color
theme.switcher_client_border_color = minor_color

-- icon
theme.system_monitor_icon = utils.image.iconfont(
                                {text = utf8.char(0xe54a), fontsize = 30})

theme.net_monitor_icon = utils.image.iconfont(
                             {text = utf8.char(0xe2bd), fontsize = 30})
theme.time_icon = utils.image.iconfont({text = "", fontsize = 30})

theme.search_icon = utils.image.iconfont(
                        {text = utf8.char(0xe8b6), fontsize = 30})
return theme
