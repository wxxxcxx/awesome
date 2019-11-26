local globalmenu = require('desktop.globalmenu')
local tasklist = require('widget.tasklist')

local module={}

module.hide_all_menu=function()
    globalmenu:hide()
    if not (tasklist.tasklist_menu == nil) then
        tasklist.tasklist_menu:hide()
    end
end

return module