local color = {}

function color.relative_luminance(color)
    local r, g, b = gears.color.parse_color(color)
    local function from_sRGB(u)
        return u <= 0.0031308 and 25 * u / 323 or math.pow(((200 * u + 11) / 211), 12 / 5)
    end
    return 0.2126 * from_sRGB(r) + 0.7152 * from_sRGB(g) + 0.0722 * from_sRGB(b)
end

function color.contrast_ratio(fg, bg)
    return (color.relative_luminance(fg) + 0.05) / (color.relative_luminance(bg) + 0.05)
end

function color.is_contrast_acceptable(fg, bg)
    gears.debug.print_error(fg .. "|" .. bg .. "|" .. color.contrast_ratio(fg, bg))
    return color.contrast_ratio(fg, bg) >= 7 and true
end

-- Lightens a given hex color by the specified amount
function color.lighten(color, amount)
    local r, g, b
    r, g, b = gears.color.parse_color(color)
    r = 255 * r
    g = 255 * g
    b = 255 * b
    r = r + math.floor(2.55 * amount)
    g = g + math.floor(2.55 * amount)
    b = b + math.floor(2.55 * amount)
    r = r > 255 and 255 or r
    g = g > 255 and 255 or g
    b = b > 255 and 255 or b
    return ("#%02x%02x%02x"):format(r, g, b)
end

-- Darkens a given hex color by the specified amount
function color.darken(color, amount)
    local r, g, b
    r, g, b = gears.color.parse_color(color)
    r = 255 * r
    g = 255 * g
    b = 255 * b
    r = math.max(0, r - math.floor(r * (amount / 100)))
    g = math.max(0, g - math.floor(g * (amount / 100)))
    b = math.max(0, b - math.floor(b * (amount / 100)))
    return ("#%02x%02x%02x"):format(r, g, b)
end

return color
