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
        {description = "Toggle maximized", group = "Client"}
    ),
    awful.key(
        {keydefine.modkey},
        "w",
        function(c)
            sequentialkey.show(
                {
                    {
                        {},
                        "q",
                        function(c)
                            c:kill()
                        end,
                        {
                            description = "Close",
                            group = "Client"
                        }
                    },
                    {
                        {},
                        "f",
                        function(c)
                            c.floating = not c.floating
                        end,
                        {description = "Toggle floating", group = "Client"}
                    },
                    {
                        {},
                        "t",
                        function(c)
                            c.ontop = not c.ontop
                        end,
                        {description = "Toggle keep on top", group = "Client"}
                    },
                    {
                        {},
                        "m",
                        function(c)
                            c.minimized = true
                        end,
                        {description = "Minimize", group = "Client"}
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
                            description = "Move left",
                            group = "Client",
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
                            description = "Move right",
                            group = "Client",
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
                            description = "Move down",
                            group = "Client",
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
                            description = "Move up",
                            group = "Client",
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
                            description = "Decrease width",
                            group = "Client",
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
                            description = "Increase width",
                            group = "Client",
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
                            description = "Increase height",
                            group = "Client",
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
                            description = "Increase height",
                            group = "Client",
                            hold = true
                        }
                    }
                },
                {
                    description = "Client control",
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
        {description = "Move to master", group = "Client"}
    )
)
