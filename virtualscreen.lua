local module = {}

function module.new(args)
    local base_screen = args.screen

    -- gears.debug.dump(base_screen.workarea,"workarea",1)
    local fake_screen_width = math.floor(base_screen.geometry.width * 0.6)
    base_screen:fake_resize(
        0,
        0,
        base_screen.geometry.width - fake_screen_width,
        base_screen.geometry.height
    )
    local fake_screen = screen.fake_add(base_screen.geometry.width, 0, fake_screen_width, base_screen.geometry.height)
    -- gears.debug.dump(screen.workarea,"workarea",1)
    -- fscreen:fake_remove()
end

return module
