local module = {}

function module.relative_luminance(color)
    local r, g, b = gears.color.parse_color(color)
    local function from_sRGB(u)
        return u <= 0.0031308 and 25 * u / 323 or math.pow(((200 * u + 11) / 211), 12 / 5)
    end
    return 0.2126 * from_sRGB(r) + 0.7152 * from_sRGB(g) + 0.0722 * from_sRGB(b)
end

function module.contrast_ratio(fg, bg)
    return (module.relative_luminance(fg) + 0.05) / (module.relative_luminance(bg) + 0.05)
end

function module.is_contrast_acceptable(fg, bg)
    return module.contrast_ratio(fg, bg) >= 5 and true
end

-- Lightens a given hex color by the specified amount
function module.lighten(color, amount)
    local r, g, b, a
    r, g, b, a = gears.color.parse_color(color)
    r = 255 * r
    g = 255 * g
    b = 255 * b
    a = 255 * a
    r = r + math.floor(2.55 * amount)
    g = g + math.floor(2.55 * amount)
    b = b + math.floor(2.55 * amount)
    r = r > 255 and 255 or r
    g = g > 255 and 255 or g
    b = b > 255 and 255 or b
    return ("#%02x%02x%02x%02x"):format(r, g, b, a)
end

-- Darkens a given hex color by the specified amount
function module.darken(color, amount)
    local r, g, b, a
    r, g, b, a = gears.color.parse_color(color)
    r = 255 * r
    g = 255 * g
    b = 255 * b
    a = 255 * a
    r = math.max(0, r - math.floor(r * (amount / 100)))
    g = math.max(0, g - math.floor(g * (amount / 100)))
    b = math.max(0, b - math.floor(b * (amount / 100)))
    return ("#%02x%02x%02x%02x"):format(r, g, b, a)
end

-- Darkens a given hex color by the specified amount
function module.auto_lighten_or_darken(color, amount)
    local luminance = module.relative_luminance(color)
    -- local luminance = 0.5
    if luminance > 0.5 then
        amount = amount or 0 - (luminance * 70) + 100
        return module.darken(color, amount)
    else
        amount = amount or luminance * 90 + 10
        return module.lighten(color, amount)
    end
end

function module.opacity(color, opacity)
    local r, g, b, a
    r, g, b, a = gears.color.parse_color(color)
    r = 255 * r
    g = 255 * g
    b = 255 * b
    a = math.floor(255 * opacity)

    return ("#%02x%02x%02x%02x"):format(r, g, b, a)
end

function module.inverse(color, opacity)
    local r, g, b, a
    r, g, b, a = gears.color.parse_color(color)
    r = 255 - 255 * r
    g = 255 - 255 * g
    b = 255 - 255 * b
    return ("#%02x%02x%02x%02x"):format(r, g, b, a)
end

return module
