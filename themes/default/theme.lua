local gears = require('gears')
local theme_assets = require('beautiful.theme_assets')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi

local themes_path = gears.filesystem.get_configuration_dir() .. 'themes/default/'

local theme = {}

--[[
 ██████╗ ██████╗ ██╗      ██████╗ ██████╗
██╔════╝██╔═══██╗██║     ██╔═══██╗██╔══██╗
██║     ██║   ██║██║     ██║   ██║██████╔╝
██║     ██║   ██║██║     ██║   ██║██╔══██╗
╚██████╗╚██████╔╝███████╗╚██████╔╝██║  ██║
 ╚═════╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝

]]
local primary_color = '#bb3d6d'
local accent_color = '#bb3d6d'

local bg_normal = '#000000'
local bg_focus = '#008fee'
local bg_urgent = '#00ff00'
local bg_minimize = '#000000'

local fg_normal = '#ffffff'
local fg_focus = '#ffffff'
local fg_urgent = '#ffffff'
local fg_minimize = '#ffffff'

--[[
██╗    ██╗ █████╗ ██╗     ██╗     ██████╗  █████╗ ██████╗ ███████╗██████╗
██║    ██║██╔══██╗██║     ██║     ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗
██║ █╗ ██║███████║██║     ██║     ██████╔╝███████║██████╔╝█████╗  ██████╔╝
██║███╗██║██╔══██║██║     ██║     ██╔═══╝ ██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗
╚███╔███╔╝██║  ██║███████╗███████╗██║     ██║  ██║██║     ███████╗██║  ██║
 ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝

]]
theme.awesome_icon = themes_path .. 'assets/archlinux.png'
theme.icon_theme = 'ePapirus'
theme.wallpaper = gears.filesystem.get_configuration_dir() .. 'wallpapers/wallpaper-08.jpg'
theme.useless_gap = dpi(4)

--[[
███████╗ ██████╗ ███╗   ██╗████████╗
██╔════╝██╔═══██╗████╗  ██║╚══██╔══╝
█████╗  ██║   ██║██╔██╗ ██║   ██║
██╔══╝  ██║   ██║██║╚██╗██║   ██║
██║     ╚██████╔╝██║ ╚████║   ██║
╚═╝      ╚═════╝ ╚═╝  ╚═══╝   ╚═╝

]]
theme.font = 'Noto Sans Regular 12'

--[[
███╗   ███╗███████╗███╗   ██╗██╗   ██╗
████╗ ████║██╔════╝████╗  ██║██║   ██║
██╔████╔██║█████╗  ██╔██╗ ██║██║   ██║
██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║
██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝
╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝

]]
theme.menu_bg_normal = bg_normal .. '44'
theme.menu_font = 'Noto Sans Regular 10'
-- theme.menu_submenu_icon = themes_path .. 'assets/submenu.svg'
theme.menu_height = dpi(25)
theme.menu_width = dpi(220)
theme.menu_bg_focus = fg_normal .. '44'

--[[
██████╗  █████╗ ███████╗███████╗
██╔══██╗██╔══██╗██╔════╝██╔════╝
██████╔╝███████║███████╗█████╗
██╔══██╗██╔══██║╚════██║██╔══╝
██████╔╝██║  ██║███████║███████╗
╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝

]]
theme.bg_normal = bg_normal .. '99'
theme.bg_focus = bg_focus .. '99'
theme.bg_urgent = bg_urgent .. '99'
theme.bg_minimize = bg_minimize .. '99'

theme.fg_normal = fg_normal
theme.fg_focus = fg_focus
theme.fg_urgent = fg_urgent
theme.fg_minimize = fg_minimize

--[[
██╗    ██╗██╗██████╗  █████╗ ██████╗
██║    ██║██║██╔══██╗██╔══██╗██╔══██╗
██║ █╗ ██║██║██████╔╝███████║██████╔╝
██║███╗██║██║██╔══██╗██╔══██║██╔══██╗
╚███╔███╔╝██║██████╔╝██║  ██║██║  ██║
 ╚══╝╚══╝ ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝

]]
theme.wibar_height = 30
theme.wibar_bg = bg_normal .. 'bb'

--[[
████████╗ █████╗ ███████╗██╗  ██╗██╗     ██╗███████╗████████╗
╚══██╔══╝██╔══██╗██╔════╝██║ ██╔╝██║     ██║██╔════╝╚══██╔══╝
   ██║   ███████║███████╗█████╔╝ ██║     ██║███████╗   ██║
   ██║   ██╔══██║╚════██║██╔═██╗ ██║     ██║╚════██║   ██║
   ██║   ██║  ██║███████║██║  ██╗███████╗██║███████║   ██║
   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝╚══════╝   ╚═╝

]]
theme.tasklist_bg_focus = fg_normal .. 'aa'
theme.tasklist_bg_normal = fg_normal .. '33'
theme.tasklist_bg_minimize = bg_normal .. '00'

--[[
██████╗  ██████╗ ████████╗██████╗ ███████╗██████╗
██╔══██╗██╔═══██╗╚══██╔══╝██╔══██╗██╔════╝██╔══██╗
██████╔╝██║   ██║   ██║   ██║  ██║█████╗  ██████╔╝
██╔══██╗██║   ██║   ██║   ██║  ██║██╔══╝  ██╔══██╗
██████╔╝╚██████╔╝   ██║   ██████╔╝███████╗██║  ██║
╚═════╝  ╚═════╝    ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝

]]
theme.border_width = dpi(0)
theme.border_normal = bg_normal
theme.border_focus = primary_color
theme.border_marked = accent_color

--[[
████████╗ █████╗  ██████╗ ██╗     ██╗███████╗████████╗
╚══██╔══╝██╔══██╗██╔════╝ ██║     ██║██╔════╝╚══██╔══╝
   ██║   ███████║██║  ███╗██║     ██║███████╗   ██║
   ██║   ██╔══██║██║   ██║██║     ██║╚════██║   ██║
   ██║   ██║  ██║╚██████╔╝███████╗██║███████║   ██║
   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝╚══════╝   ╚═╝

]]
theme.taglist_bg_focus = fg_normal
theme.taglist_bg_urgent = fg_normal
theme.taglist_bg_occupied = fg_normal
theme.taglist_bg_empty = fg_normal
theme.taglist_bg_volatile = fg_normal
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

--[[
████████╗ ██████╗  ██████╗ ██╗  ████████╗██╗██████╗
╚══██╔══╝██╔═══██╗██╔═══██╗██║  ╚══██╔══╝██║██╔══██╗
   ██║   ██║   ██║██║   ██║██║     ██║   ██║██████╔╝
   ██║   ██║   ██║██║   ██║██║     ██║   ██║██╔═══╝
   ██║   ╚██████╔╝╚██████╔╝███████╗██║   ██║██║
   ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚═╝   ╚═╝╚═╝

]]
-- theme.tooltip_shape = gears.shape.infobubble
theme.tooltip_bg = bg_normal .. '55'

--[[
██╗  ██╗ ██████╗ ████████╗██╗  ██╗███████╗██╗   ██╗███████╗
██║  ██║██╔═══██╗╚══██╔══╝██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔════╝
███████║██║   ██║   ██║   █████╔╝ █████╗   ╚████╔╝ ███████╗
██╔══██║██║   ██║   ██║   ██╔═██╗ ██╔══╝    ╚██╔╝  ╚════██║
██║  ██║╚██████╔╝   ██║   ██║  ██╗███████╗   ██║   ███████║
╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝

]]
theme.hotkeys_font = 'Noto Sans Regular 12'
theme.hotkeys_description_font = 'Noto Sans Italic 11'
theme.hotkeys_bg = bg_normal .. 'cc'
theme.hotkeys_fg = fg_minimize
theme.hotkeys_modifiers_fg = fg_normal
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
theme.notification_bg = bg_normal .. '55'
theme.notification_fg = fg_focus
theme.notification_border_width = 0
theme.notification_border_color = bg_normal .. '55'
theme.notification_margin = 30
-- theme.notification_shape = function(cr,w,h)
--    gears.shape.rounded_rect(cr,w,h,2)
-- end
-- theme.notification_opacity = 0.1

theme.systray_icon_spacing = 10

--[[
████████╗██╗████████╗██╗     ███████╗██████╗  █████╗ ██████╗
╚══██╔══╝██║╚══██╔══╝██║     ██╔════╝██╔══██╗██╔══██╗██╔══██╗
   ██║   ██║   ██║   ██║     █████╗  ██████╔╝███████║██████╔╝
   ██║   ██║   ██║   ██║     ██╔══╝  ██╔══██╗██╔══██║██╔══██╗
   ██║   ██║   ██║   ███████╗███████╗██████╔╝██║  ██║██║  ██║
   ╚═╝   ╚═╝   ╚═╝   ╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝

]]
theme.titlebar_bg_normal = '#00000055'
theme.titlebar_bg_focus = {
    type = 'linear',
    from = {0, 0},
    to = {100, 30},
    stops = {{0, '#ffffff55'}, {0.6, '#00000055'}, {1, '#00000055'}}
}

local cairo = require('lgi').cairo

local solid_font = 'Font Awesome 5 Free Solid'
local regular_font = 'Font Awesome 5 Free Regular'

local icon = function(args)
    local args = args or {}
    local text = args.text or ''
    local font = args.font or 'Font Awesome 5 Free'
    local tx = args.tx or 0
    local ty = args.ty or 0
    local color = args.color or fg_focus .. '88'
    local fontsize = args.fontsize or 20

    local is = cairo.ImageSurface.create(cairo.Format.ARGB32, 30, 30)
    local cr = cairo.Context(is)
    cr:set_source(gears.color(color))
    cr:select_font_face(font)
    cr:set_font_size(fontsize)
    local textWidth = cr:text_extents(text).width
    local textHeight = cr:text_extents(text).height
    cr:move_to(tx, textHeight + 3 + ty)
    cr:show_text(text)
    return is
end

theme.titlebar_close_button_normal =
    icon(
    {
        text = utf8.char(0xf410),
        font = regular_font
    }
)
theme.titlebar_close_button_focus =
    icon(
    {
        text = utf8.char(0xf410),
        font = regular_font
    }
)

theme.titlebar_maximized_button_normal_inactive =
    icon(
    {
        text = utf8.char(0xf2d0),
        font = regular_font
    }
)
theme.titlebar_maximized_button_focus_inactive =
    icon(
    {
        text = utf8.char(0xf2d0),
        font = regular_font
    }
)
theme.titlebar_maximized_button_normal_active =
    icon(
    {
        text = utf8.char(0xf2d2),
        font = regular_font
    }
)
theme.titlebar_maximized_button_focus_active =
    icon(
    {
        text = utf8.char(0xf2d2),
        font = regular_font
    }
)

theme.titlebar_minimize_button_normal =
    icon(
    {
        text = utf8.char(0xf2d1),
        font = regular_font,
        ty = 6
    }
)
theme.titlebar_minimize_button_focus =
    icon(
    {
        text = utf8.char(0xf2d1),
        font = regular_font,
        ty = 6
    }
)

theme.titlebar_ontop_button_normal_inactive =
    icon(
    {
        text = utf8.char(0xf111),
        font = solid_font,
        color = fg_focus .. '88',
        fontsize = 12,
        ty = 4
    }
)
theme.titlebar_ontop_button_focus_inactive =
    icon(
    {
        text = utf8.char(0xf111),
        font = solid_font,
        color = fg_focus .. '88',
        fontsize = 12,
        ty = 4
    }
)
theme.titlebar_ontop_button_normal_active =
    icon(
    {
        text = utf8.char(0xf192),
        font = solid_font,
        color = fg_focus .. '88',
        fontsize = 12,
        ty = 4
    }
)
theme.titlebar_ontop_button_focus_active =
    icon(
    {
        text = utf8.char(0xf192),
        font = solid_font,
        color = fg_focus .. '88',
        fontsize = 12,
        ty = 4
    }
)

theme.titlebar_sticky_button_normal_inactive =
    icon(
    {
        text = utf8.char(0xf111),
        font = solid_font,
        color = fg_focus .. '88',
        fontsize = 12,
        ty = 4
    }
)
theme.titlebar_sticky_button_focus_inactive =
    icon(
    {
        text = utf8.char(0xf111),
        font = solid_font,
        color = fg_focus .. '88',
        fontsize = 12,
        ty = 4
    }
)
theme.titlebar_sticky_button_normal_active =
    icon(
    {
        text = utf8.char(0xf192),
        font = solid_font,
        color = fg_focus .. '88',
        fontsize = 12,
        ty = 4
    }
)
theme.titlebar_sticky_button_focus_active =
    icon(
    {
        text = utf8.char(0xf192),
        font = solid_font,
        color = fg_focus .. '88',
        fontsize = 12,
        ty = 4
    }
)

theme.titlebar_floating_button_normal_inactive =
    icon(
    {
        text = utf8.char(0xf111),
        font = solid_font,
        color = fg_focus .. '88',
        fontsize = 12,
        ty = 4
    }
)
theme.titlebar_floating_button_focus_inactive =
    icon(
    {
        text = utf8.char(0xf111),
        font = solid_font,
        color = fg_focus .. '88',
        fontsize = 12,
        ty = 4
    }
)
theme.titlebar_floating_button_normal_active =
    icon(
    {
        text = utf8.char(0xf192),
        font = solid_font,
        color = fg_focus .. '88',
        fontsize = 12,
        ty = 4
    }
)
theme.titlebar_floating_button_focus_active =
    icon(
    {
        text = utf8.char(0xf192),
        font = solid_font,
        color = fg_focus .. '88',
        fontsize = 12,
        ty = 4
    }
)
--[[
██╗      █████╗ ██╗   ██╗ ██████╗ ██╗   ██╗████████╗
██║     ██╔══██╗╚██╗ ██╔╝██╔═══██╗██║   ██║╚══██╔══╝
██║     ███████║ ╚████╔╝ ██║   ██║██║   ██║   ██║
██║     ██╔══██║  ╚██╔╝  ██║   ██║██║   ██║   ██║
███████╗██║  ██║   ██║   ╚██████╔╝╚██████╔╝   ██║
╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝  ╚═════╝    ╚═╝

]]
theme.master_width_factor = 0.6
return theme
