local gears = require("gears")
local awful = require("awful")
local sequentialkey = require("maf.sequentialkey")
local keydefine = require("maf.keydefine")

return gears.table.join(
    awful.key(
        {keydefine.modkey},
        "Return",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {
            description = "(Un)Maximize client",
            group = "Client"
        }
    ),
    awful.key(
        {keydefine.modkey, keydefine.shift},
        "Return",
        function(c)
            c:swap(awful.client.getmaster())
        end,
        {description = "Move to master", group = "Client"}
    ),
    awful.key(
        {keydefine.modkey},
        "m",
        function(c)
            c.minimized = not c.minimized
        end,
        {
            description = "(Un)Minimize client",
            group = "Client"
        }
    ),
    awful.key(
        {keydefine.modkey},
        "q",
        function(c)
            c:kill()
        end,
        {
            description = "Close client",
            group = "Client"
        }
    ),
    awful.key(
        {keydefine.modkey},
        "t",
        function(c)
            c.ontop = not c.ontop
        end,
        {
            description = "Toggle ontop",
            group = "Client"
        }
    ),
    awful.key(
        {keydefine.modkey},
        "f",
        function(c)
            c.floating = not c.floating
        end,
        {
            description = "Toggle floating",
            group = "Client"
        }
    ),
    awful.key(
        {keydefine.modkey},
        "s",
        function(c)
            c.sticky = not c.sticky
        end,
        {
            description = "Toggle sticky",
            group = "Client"
        }
    ),
    awful.key(
        {keydefine.modkey},
        "Up",
        function(c)
            if c.floating or c.first_tag.layout.name == "floating" then
                c:relative_move(0, -20, 0, 0)
            else
                awful.client.swap.bydirection("up", c)
            end
        end,
        {
            description = "Move client",
            group = "Client"
        }
    ),
    awful.key(
        {keydefine.modkey},
        "Down",
        function(c)
            if c.floating or c.first_tag.layout.name == "floating" then
                c:relative_move(0, 20, 0, 0)
            else
                awful.client.swap.bydirection("down", c)
            end
        end,
        {
            description = "Move client",
            group = "Client"
        }
    ),
    awful.key(
        {keydefine.modkey},
        "Left",
        function(c)
            if c.floating or c.first_tag.layout.name == "floating" then
                c:relative_move(-20, 0, 0, 0)
            else
                awful.client.swap.bydirection("left", c)
            end
        end,
        {
            description = "Move client",
            group = "Client"
        }
    ),
    awful.key(
        {keydefine.modkey},
        "Right",
        function(c)
            if c.floating or c.first_tag.layout.name == "floating" then
                c:relative_move(20, 0, 0, 0)
            else
                awful.client.swap.bydirection("right", c)
            end
        end,
        {
            description = "Move client",
            group = "Client"
        }
    ),
    awful.key(
        {keydefine.modkey, keydefine.shift},
        "Up",
        function(c)
            if c.floating or c.first_tag.layout.name == "floating" then
                c:relative_move(0, 0, 0, -20)
            else
                awful.client.swap.bydirection("up", c)
            end
        end,
        {
            description = "Move client",
            group = "Client"
        }
    ),
    awful.key(
        {keydefine.modkey, keydefine.shift},
        "Down",
        function(c)
            if c.floating or c.first_tag.layout.name == "floating" then
                c:relative_move(0, 0, 0, 20)
            else
                awful.client.swap.bydirection("down", c)
            end
        end,
        {
            description = "Move client",
            group = "Client"
        }
    ),
    awful.key(
        {keydefine.modkey, keydefine.shift},
        "Left",
        function(c)
            if c.floating or c.first_tag.layout.name == "floating" then
                c:relative_move(0, 0, -20, 0)
            else
                awful.client.swap.bydirection("left", c)
            end
        end,
        {
            description = "Move client",
            group = "Client"
        }
    ),
    awful.key(
        {keydefine.modkey, keydefine.shift},
        "Right",
        function(c)
            if c.floating or c.first_tag.layout.name == "floating" then
                c:relative_move(0, 0, 20, 0)
            else
                awful.client.swap.bydirection("right", c)
            end
        end,
        {
            description = "Move client",
            group = "Client"
        }
    )
)
