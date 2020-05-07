local timer = require("gears")

local module = {}

function module.easa(args)
    local animation = {}
    local args = args or {}
    animation.type = args.type or "number"
    animation.fps = args.fps or 30
    animation.easing = args.easing or 0.4
    animation.begin = args.begin or 0
    animation._postion = animation.begin
    animation.target = args.target or 0
    animation._direction = animation.target > animation.begin

    animation.timer =
        gears.timer {
        timeout = 1 / animation.fps,
        call_now = false,
        autostart = false,
        single_shot = false,
        callback = function()
            local temp = math.abs(animation.target - animation._postion) * animation.easing
            if temp < 1 then
                temp = 1
            end
            -- gears.debug.dump(animation.begin..'|'..animation._postion..'|'..animation.target, "animation", 1)

            if animation._direction then
                if animation._postion < animation.target then
                    animation._postion = animation._postion + temp
                else
                    animation._postion = animation.target
                    animation.timer:stop()
                end
            else
                if animation._postion > animation.target then
                    animation._postion = animation._postion - temp
                else
                    animation._postion = animation.target
                    animation.timer:stop()
                end
            end

            if args.callback ~= nil then
                args.callback(animation._postion)
            end
        end
    }

    function animation.start(args)
        -- animation.timer:stop()
        -- gears.debug.dump(animation,'animation',1)
        animation.target = args.target
        if args.begin == nil then
            animation.begin = animation._postion
        else
            animation.begin = args.begin
            animation._postion = animation.begin
        end
        -- gears.debug.dump(animation.begin..'|'..animation._postion..'|'..animation.target, "start", 1)
        animation._direction = animation.target > animation.begin
        animation.timer:again()
    end

    return animation
end

return module
