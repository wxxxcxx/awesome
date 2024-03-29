local gears = require('gears')
local cairo = require('lgi').cairo
local utils = require('utils')
local wibox = require('wibox')

local theme_assets = beautiful.theme_assets
local dpi = beautiful.xresources.apply_dpi
local gtk_theme = beautiful.gtk.get_theme_variables()

-- local gtk_theme = {
--     font_family = 'Noto Sans',
--     font_size = 10,
--     wm_bg_color = '#282b3a',
--     bg_color = '#282b3a',
--     fg_color = '#ffffff',
--     menubar_fg_color = '#ffffff',
--     selected_bg_color = '#3b4252',
--     selected_fg_color = '#ffffff',
--     tooltip_bg_color = '#282b3a',
--     tooltip_fg_color = '#ffffff'
-- }

local theme = {}
local themes_path = gears.filesystem.get_configuration_dir() .. 'themes/default/'
local naughty = require('naughty')
function notify(msg)
    naughty.notify(
        {
            border_width = 0,
            position = 'top_right',
            title = 'New message!',
            text = msg
        }
    )
end

--------------------------------------------------------------------
-- base
--------------------------------------------------------------------
local transparent = '#00000000'
local icon_font = 'Material Icons'

local wm_bg = '#282b3a'
-- local wm_bg = gtk_theme.wm_bg_color or '#282b3a'
local wm_fg = utils.color.auto_lighten_or_darken(gtk_theme.wm_bg_color, 70)

theme.icon_theme = 'Qogir'
theme.wallpaper = gears.filesystem.get_configuration_dir() .. 'wallpapers/seafloor.png'
theme.useless_gap = dpi(6)
theme.gtk_theme = gtk_theme

theme.icon_font_name = icon_font
theme.font = gtk_theme.font_family .. ' ' .. gtk_theme.font_size
theme.icon_font = icon_font .. ' 20'

theme.bg_normal = gtk_theme.bg_color
theme.fg_normal = gtk_theme.fg_color

theme.bg_focus = utils.color.auto_lighten_or_darken(gtk_theme.bg_color, 5)
theme.fg_focus = gtk_theme.fg_color

theme.bg_urgent = utils.color.auto_lighten_or_darken(gtk_theme.bg_color, 40)
theme.fg_urgent = gtk_theme.fg_color

theme.bg_minimize = utils.color.opacity(gtk_theme.bg_color, 0)
theme.fg_minimize = gtk_theme.fg_color

--------------------------------------------------------------------
-- menu
--------------------------------------------------------------------

theme.menu_submenu_icon =
    utils.image.iconfont {
    text = '›',
    width = 50,
    height = 50,
    fontsize = 40,
    ty = -8
}
theme.menu_bg = transparent
theme.menu_bg_normal = utils.color.opacity(wm_bg, 0.5)
theme.menu_fg_normal = gtk_theme.menubar_fg_color
theme.menu_bg_focus = utils.color.opacity(gtk_theme.selected_bg_color,0.5)
theme.menu_fg_focus = gtk_theme.selected_fg_color
theme.menu_height = dpi(25)
theme.menu_width = dpi(220)
theme.menu_border_width = 1
theme.menu_border_color = utils.color.auto_lighten_or_darken(theme.menu_bg_normal, 5)

--------------------------------------------------------------------
-- wibar
--------------------------------------------------------------------

theme.wibar_height = dpi(30)
theme.wibar_ontop = true
theme.wibar_fg = wm_fg
theme.wibar_bg = utils.color.opacity(wm_bg, 0.5)
theme.wibar_border_width = 1
theme.wibar_border_color = utils.color.auto_lighten_or_darken(theme.wibar_bg, 0)

--------------------------------------------------------------------
-- widgets
--------------------------------------------------------------------

-- search

theme.search_icon =
    gears.surface.load_from_shape(
    64,
    64,
    function(cr, width, height)
        gears.shape.arc(cr, width, height, nil, 0, 2 * math.pi)
    end,
    gtk_theme.fg_color
)
-- folder
theme.folder_icon =
    gears.surface.load_from_shape(
    64,
    64,
    function(cr, width, height)
        gears.shape.cross(cr, width, height)
    end,
    utils.color.auto_lighten_or_darken(theme.wibar_fg, 30)
)

theme.folder_bg = utils.color.auto_lighten_or_darken(theme.wibar_bg, 15)
-- tray

theme.systray_icon_spacing = 10
theme.bg_systray = utils.color.auto_lighten_or_darken(theme.wibar_bg, 15)

-- clock
theme.clock_bg = utils.color.auto_lighten_or_darken(theme.wibar_bg, 15)
-- volume
theme.volume_bg = utils.color.auto_lighten_or_darken(theme.wibar_bg, 15)
theme.volume_progress_bg = utils.color.opacity(theme.wibar_fg, 0.3)
theme.volume_mute_progress_bg = utils.color.auto_lighten_or_darken(theme.wibar_bg, 0)
-- layout
theme.layout_fairh = themes_path .. 'assets/layouts/fairh.png'
theme.layout_fairv = themes_path .. 'assets/layouts/fairv.png'
theme.layout_floating = themes_path .. 'assets/layouts/floating.png'
theme.layout_magnifier = themes_path .. 'assets/layouts/magnifier.png'
theme.layout_max = themes_path .. 'assets/layouts/max.png'
theme.layout_fullscreen = themes_path .. 'assets/layouts/fullscreen.png'
theme.layout_tilebottom = themes_path .. 'assets/layouts/tilebottom.png'
theme.layout_tileleft = themes_path .. 'assets/layouts/tileleft.png'
theme.layout_tile = themes_path .. 'assets/layouts/tile.png'
theme.layout_tiletop = themes_path .. 'assets/layouts/tiletop.png'
theme.layout_spiral = themes_path .. 'assets/layouts/spiral.png'
theme.layout_dwindle = themes_path .. 'assets/layouts/dwindle.png'
theme.layout_cornernw = themes_path .. 'assets/layouts/cornernw.png'
theme.layout_cornerne = themes_path .. 'assets/layouts/cornerne.png'
theme.layout_cornersw = themes_path .. 'assets/layouts/cornersw.png'
theme.layout_cornerse = themes_path .. 'assets/layouts/cornerse.png'
theme.layout_cornerse = themes_path .. 'assets/layouts/cornerse.png'
theme.layout_cascade = themes_path .. 'assets/layouts/dwindle.png'

-- tasklist
theme.tasklist_plain_task_name = true
theme.tasklist_fg_focus = theme.wibar_fg
theme.tasklist_fg_normal = theme.wibar_fg
theme.tasklist_fg_minimize = theme.wibar_fg
theme.tasklist_bg = utils.color.opacity(theme.wibar_fg, 0.2)
theme.tasklist_bg_focus = utils.color.opacity(theme.wibar_fg, 0.3)
theme.tasklist_bg_normal = utils.color.opacity(theme.wibar_fg, 0.1)
theme.tasklist_bg_minimize = utils.color.opacity(theme.wibar_fg, 0)

theme.tasklist_icon =
    gears.surface.load_from_shape(
    64,
    64,
    function(cr, width, height)
        gears.shape.hexagon(cr, width, height)
    end,
    gtk_theme.fg_color
)
-- taglist
theme.taglist_bg_focus = theme.wibar_fg
theme.taglist_bg = utils.color.auto_lighten_or_darken(wm_bg, 15)
-- theme.taglist_bg_focus = utils.color.opacity(gtk_theme.fg_color, 0.8)
theme.taglist_bg_urgent = utils.color.opacity(theme.wibar_fg, 0.4)
theme.taglist_bg_occupied = utils.color.opacity(theme.wibar_fg, 0.4)
theme.taglist_bg_volatile = utils.color.opacity(theme.wibar_fg, 0.4)
theme.taglist_bg_empty = utils.color.opacity(theme.wibar_fg, 0.2)

theme.tag_active_icon =
    gears.surface.load_from_shape(
    64,
    64,
    function(cr, width, height)
        gears.shape.losange(cr, width, height)
    end,
    gtk_theme.fg_color
)
theme.tag_inactive_icon =
    gears.surface.load_from_shape(
    64,
    64,
    function(cr, width, height)
        gears.shape.losange(cr, width, height)
    end,
    utils.color.auto_lighten_or_darken(gtk_theme.fg_color, 30)
)

theme.awesome_icon =
    gears.surface.load_from_shape(
    64,
    64,
    function(cr, width, height)
        gears.shape.arc(cr, width, height, nil, 0, 2 * math.pi)
    end,
    theme.wibar_fg
)

--------------------------------------------------------------------
-- tooltip
--------------------------------------------------------------------

-- theme.tooltip_shape = gears.shape.infobubble
theme.tooltip_bg = gtk_theme.tooltip_bg_color
theme.tooltip_fg = gtk_theme.tooltip_fg_color
theme.tooltip_border_width = dpi(1)
theme.tooltip_border_color = utils.color.auto_lighten_or_darken(gtk_theme.tooltip_bg_color, 10)

--------------------------------------------------------------------
-- hotkeys
--------------------------------------------------------------------
theme.hotkeys_font = gtk_theme.font_family .. ' ' .. gtk_theme.font_size * 1.2
theme.hotkeys_description_font = gtk_theme.font_family .. ' ' .. gtk_theme.font_size

theme.hotkeys_bg = utils.color.opacity(gtk_theme.bg_color, 0.8)
theme.hotkeys_fg = gtk_theme.fg_color
theme.hotkeys_modifiers_fg = utils.color.auto_lighten_or_darken(gtk_theme.fg_color, 20)
theme.hotkeys_border_width = dpi(1)
theme.hotkeys_border_color = utils.color.opacity(gtk_theme.bg_color, 0.5)
theme.hotkeys_group_margin = dpi(40)

--------------------------------------------------------------------
-- notify
--------------------------------------------------------------------

local naughty = require('naughty')
naughty.config.padding = dpi(5)
naughty.config.spacing = dpi(10)
naughty.config.defaults.margin = dpi(15)
theme.notification_font = gtk_theme.font_family .. ' ' .. gtk_theme.font_size
theme.notification_bg = gtk_theme.bg_color
theme.notification_fg = gtk_theme.fg_color
theme.notification_opacity = 0.95
theme.notification_border_width = 0
theme.notification_border_color = gtk_theme.bg_color
theme.notification_margin = dpi(15)
theme.notification_width = dpi(350)
theme.notification_max_width = dpi(400)
theme.notification_max_height = dpi(500)
theme.notification_icon_size = dpi(100)

--------------------------------------------------------------------
-- client
--------------------------------------------------------------------

-- border
theme.border_width = 1
theme.border_normal = transparent
-- theme.border_focus = caa
theme.border_focus = transparent
theme.border_marked = transparent
theme.border_select = transparent
theme.maximumed_hide_border = true

theme.snap_bg = gtk_theme.bg_color
theme.snap_border_width = 1
-- switcher
theme.switcher_bg = utils.color.opacity(gtk_theme.bg_color, 0.8)
theme.switcher_focus_bg = utils.color.opacity(utils.color.auto_lighten_or_darken(theme.switcher_bg, 40), 0.3)
theme.switcher_border_width = dpi(1)
theme.switcher_border_color = utils.color.auto_lighten_or_darken(gtk_theme.bg_color, 20)
theme.switcher_fg = gtk_theme.fg_color

-- titlebar
theme.titlebar_bg_normal = wm_bg
theme.titlebar_bg_focus = wm_bg

local normal = {
    bg = utils.color.auto_lighten_or_darken(gtk_theme.bg_color, 20)
}
local focus = {
    bg = utils.color.auto_lighten_or_darken(gtk_theme.bg_color, 20)
}
local hover = {
    bg = utils.color.auto_lighten_or_darken(gtk_theme.bg_color, 30)
}

theme.titlebar_close_button_normal = utils.image.titlebar_botton_image(normal)
theme.titlebar_close_button_normal_hover = utils.image.titlebar_botton_image(hover)
theme.titlebar_close_button_normal_press = utils.image.titlebar_botton_image(hover)
theme.titlebar_close_button_focus = utils.image.titlebar_botton_image(focus)
theme.titlebar_close_button_focus_hover = utils.image.titlebar_botton_image(hover)
theme.titlebar_close_button_focus_press = utils.image.titlebar_botton_image(hover)

theme.titlebar_maximized_button_normal_inactive = utils.image.titlebar_botton_image(normal)
theme.titlebar_maximized_button_normal_inactive_hover = utils.image.titlebar_botton_image(hover)
theme.titlebar_maximized_button_normal_inactive_press = utils.image.titlebar_botton_image(hover)
theme.titlebar_maximized_button_focus_inactive = utils.image.titlebar_botton_image(focus)
theme.titlebar_maximized_button_focus_inactive_hover = utils.image.titlebar_botton_image(hover)
theme.titlebar_maximized_button_focus_inactive_press = utils.image.titlebar_botton_image(hover)

theme.titlebar_maximized_button_normal_active = utils.image.titlebar_botton_image(normal)
theme.titlebar_maximized_button_normal_active_hover = utils.image.titlebar_botton_image(hover)
theme.titlebar_maximized_button_normal_active_press = utils.image.titlebar_botton_image(hover)
theme.titlebar_maximized_button_focus_active = utils.image.titlebar_botton_image(focus)
theme.titlebar_maximized_button_focus_active_hover = utils.image.titlebar_botton_image(hover)
theme.titlebar_maximized_button_focus_active_press = utils.image.titlebar_botton_image(hover)

theme.titlebar_minimize_button_normal = utils.image.titlebar_botton_image(normal)
theme.titlebar_minimize_button_normal_hover = utils.image.titlebar_botton_image(hover)
theme.titlebar_minimize_button_normal_press = utils.image.titlebar_botton_image(hover)
theme.titlebar_minimize_button_focus = utils.image.titlebar_botton_image(focus)
theme.titlebar_minimize_button_focus_hover = utils.image.titlebar_botton_image(hover)
theme.titlebar_minimize_button_focus_press = utils.image.titlebar_botton_image(hover)

local active = {
    bg = utils.color.auto_lighten_or_darken(gtk_theme.bg_color, 40)
}
local inactice = {
    bg = utils.color.auto_lighten_or_darken(gtk_theme.bg_color, 20)
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

theme.titlebar_sticky_button_normal_active = utils.image.titlebar_botton_image(active)
theme.titlebar_sticky_button_normal_active_hover = utils.image.titlebar_botton_image(active)
theme.titlebar_sticky_button_focus_active = utils.image.titlebar_botton_image(active)
theme.titlebar_sticky_button_focus_active_hover = utils.image.titlebar_botton_image(active)

return theme
