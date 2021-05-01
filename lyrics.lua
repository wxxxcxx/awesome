local wibox = require('wibox')
local ypm = require('awm-ypm-lyrics')
local function get_lyrics_widget(args)
    local args = args or {}
    local current_fg = args.current_fg or '#b7cdff'
    local next_fg = args.next_fg or '#aaaaaa'
    local font = args.font or '20'
    local next_font = args.next_font or '15'
    return {
        {
            {
                {
                    {
                        {
                            {
                                id = 'current_lyric',
                                markup = '',
                                align = 'center',
                                valign = 'center',
                                font = font,
                                widget = wibox.widget.textbox
                            },
                            fg = '#000000',
                            widget = wibox.container.background
                        },
                        left = 2,
                        top = 2,
                        widget = wibox.container.margin
                    },
                    {
                        {
                            {
                                id = 'current_lyric',
                                markup = '',
                                align = 'center',
                                valign = 'center',
                                font = font,
                                widget = wibox.widget.textbox
                            },
                            fg = '#00000099',
                            widget = wibox.container.background
                        },
                        left = 4,
                        top = 4,
                        widget = wibox.container.margin
                    },
                    {
                        {
                            {
                                id = 'current_lyric',
                                markup = '',
                                align = 'center',
                                valign = 'center',
                                font = font,
                                widget = wibox.widget.textbox
                            },
                            fg = '#00000099',
                            widget = wibox.container.background
                        },
                        top = -2,
                        widget = wibox.container.margin
                    },
                    {
                        {
                            {
                                id = 'current_lyric',
                                markup = '',
                                align = 'center',
                                valign = 'center',
                                font = font,
                                widget = wibox.widget.textbox
                            },
                            fg = '#00000099',
                            widget = wibox.container.background
                        },
                        left = -2,
                        widget = wibox.container.margin
                    },
                    {
                        {
                            id = 'current_lyric',
                            markup = '',
                            align = 'center',
                            valign = 'center',
                            font = font,
                            widget = wibox.widget.textbox
                        },
                        fg = current_fg,
                        widget = wibox.container.background
                    },
                    layout = wibox.layout.stack
                },
                {
                    {
                        {
                            {
                                id = 'next_lyric',
                                markup = '',
                                align = 'center',
                                valign = 'center',
                                font = next_font,
                                widget = wibox.widget.textbox
                            },
                            fg = '#000000',
                            widget = wibox.container.background
                        },
                        left = 2,
                        top = 2,
                        widget = wibox.container.margin
                    },
                    {
                        {
                            {
                                id = 'next_lyric',
                                markup = '',
                                align = 'center',
                                valign = 'center',
                                font = next_font,
                                widget = wibox.widget.textbox
                            },
                            fg = '#00000099',
                            widget = wibox.container.background
                        },
                        left = 4,
                        top = 4,
                        widget = wibox.container.margin
                    },
                    {
                        {
                            {
                                id = 'next_lyric',
                                markup = '',
                                align = 'center',
                                valign = 'center',
                                font = next_font,
                                widget = wibox.widget.textbox
                            },
                            fg = '#00000099',
                            widget = wibox.container.background
                        },
                        top = -2,
                        widget = wibox.container.margin
                    },
                    {
                        {
                            {
                                id = 'next_lyric',
                                markup = '',
                                align = 'center',
                                valign = 'center',
                                font = next_font,
                                widget = wibox.widget.textbox
                            },
                            fg = '#00000099',
                            widget = wibox.container.background
                        },
                        left = -2,
                        widget = wibox.container.margin
                    },
                    {
                        {
                            id = 'next_lyric',
                            markup = '',
                            align = 'center',
                            valign = 'center',
                            font = next_font,
                            widget = wibox.widget.textbox
                        },
                        fg = next_fg,
                        widget = wibox.container.background
                    },
                    layout = wibox.layout.stack
                },
                layout = wibox.layout.fixed.vertical
            },
            bottom = 20,
            widget = wibox.container.margin
        },
        valign = 'bottom',
        widget = wibox.container.place
    }
end
ypm:setup(get_lyrics_widget())
client.connect_signal(
    'manage',
    function(c)
        if c.class == 'yesplaymusic' then
            ypm:start()
        end
    end
)

client.connect_signal(
    'unmanage',
    function(c)
        if c.class == 'yesplaymusic' then
            ypm:stop()
        end
    end
)
