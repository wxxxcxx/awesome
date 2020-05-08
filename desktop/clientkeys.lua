local gears = require("gears")
local awful = require("awful")
local sequentialkey = require("desktop.sequentialkey")

return gears.table.join(
    awful.key(
        {keydefine.modkey},
        "Return",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}
    ),
    awful.key(
        {keydefine.modkey},
        "w",
        function(c)
            sequentialkey.show(
                {
                    {
                        {},
                        "f",
                        function(c)
                            c.floating = not c.floating
                        end,
                        {description = "toggle floating", group = "client"}
                    },
                    {
                        {},
                        "t",
                        function(c)
                            c.ontop = not c.ontop
                        end,
                        {description = "toggle keep on top", group = "client"}
                    },
                    {
                        {},
                        "a",
                        function(c)
                            awful.titlebar.toggle(c)
                        end,
                        {description = "toggle title bar", group = "client"}
                    },
                    {
                        {},
                        "m",
                        function(c)
                            c.minimized = true
                        end,
                        {description = "minimize", group = "client"}
                    },
                    {
                        {},
                        "q",
                        function(c)
                            c:kill()
                        end,
                        {
                            description = "close",
                            group = "client"
                        }
                    },
                    -- postion
                    {
                        {},
                        "h",
                        function(c)
                            if c.floating or awful.layout.getname() == "floating" then
                                c:relative_move(-10, 0, 0, 0)
                            end
                        end,
                        {
                            description = "move left",
                            group = "client",
                            hold = true
                        }
                    },
                    {
                        {},
                        "l",
                        function(c)
                            if c.floating or awful.layout.getname() == "floating" then
                                c:relative_move(10, 0, 0, 0)
                            end
                        end,
                        {
                            description = "move right",
                            group = "client",
                            hold = true
                        }
                    },
                    {
                        {},
                        "j",
                        function(c)
                            if c.floating or awful.layout.getname() == "floating" then
                                c:relative_move(0, 10, 0, 0)
                            end
                        end,
                        {
                            description = "move down",
                            group = "client",
                            hold = true
                        }
                    },
                    {
                        {},
                        "k",
                        function(c)
                            if c.floating or awful.layout.getname() == "floating" then
                                c:relative_move(0, -10, 0, 0)
                            end
                        end,
                        {
                            description = "move up",
                            group = "client",
                            hold = true
                        }
                    },
                    -- size
                    {
                        {keydefine.modkey},
                        "h",
                        function(c)
                            if c.floating or awful.layout.getname() == "floating" then
                                c:relative_move(0, 0, -10, 0)
                            end
                        end,
                        {
                            description = "resize client",
                            group = "client",
                            hold = true
                        }
                    },
                    {
                        {keydefine.modkey},
                        "l",
                        function(c)
                            if c.floating or awful.layout.getname() == "floating" then
                                c:relative_move(0, 0, 10, 0)
                            end
                        end,
                        {
                            description = "resize client",
                            group = "client",
                            hold = true
                        }
                    },
                    {
                        {keydefine.modkey},
                        "j",
                        function(c)
                            if c.floating or awful.layout.getname() == "floating" then
                                c:relative_move(0, 0, 0, 10)
                            end
                        end,
                        {
                            description = "resize client",
                            group = "client",
                            hold = true
                        }
                    },
                    {
                        {keydefine.modkey},
                        "k",
                        function(c)
                            if c.floating or awful.layout.getname() == "floating" then
                                c:relative_move(0, 0, 0, -10)
                            end
                        end,
                        {
                            description = "resize client",
                            group = "client",
                            hold = true
                        }
                    }
                },
                {
                    description = "client control",
                    args = c,
                    parent = c
                }
            )
        end,
        {
            description = "close",
            group = "client"
        }
    ),
    awful.key(
        {keydefine.modkey, keydefine.shift},
        "Return",
        function(c)
            c:swap(awful.client.getmaster())
        end,
        {description = "move to master", group = "client"}
    )
)
