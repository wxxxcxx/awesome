local module={}

function module.new(args)
    local base_screen = args.screen
    local postion = args.postion or "right"
    local size = args.size or 480
    local new_geometry = {}
    new_geometry.width = 0
    new_geometry.height = 0
    new_geometry.x = 0
    new_geometry.y = 0
    local base_geometry = base_screen.geometry
    local new_base_geometry = {}

    new_base_geometry.x = base_geometry.x
    new_base_geometry.y = base_geometry.y
    new_base_geometry.width = base_geometry.width
    new_base_geometry.height = base_geometry.height

    if postion == "right" then
        new_geometry.width = args.size
        new_geometry.height = base_geometry.height
        new_base_geometry.width = base_geometry.width - new_geometry.width
        new_geometry.x = new_base_geometry.width
    elseif postion == "left" then
    elseif postion == "top" then
        new_geometry.width = base_geometry.width
        new_geometry.height = base_geometry.size
    elseif postion == "bottom" then
    end
    -- gears.debug.dump(base_screen.workarea,"workarea",1)
    base_screen:fake_resize(new_base_geometry.x, new_base_geometry.y, new_base_geometry.width, new_base_geometry.height)
    local fscreen= screen.fake_add(new_geometry.x, new_geometry.y, new_geometry.width, new_geometry.height)
    gears.debug.dump(screen.workarea,"workarea",1)
    fscreen:fake_remove()
end

return module