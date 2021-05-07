local awful = require('awful')
local wibox = require('wibox')
local menubar = require('menubar')
local filesystem = require('gears.filesystem')

local prompt =
    awful.widget.prompt {
    prompt = ' <b>⇝</b> ',
    bg = '#00000000',
}

return prompt
