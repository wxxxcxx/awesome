local module={}
module.terminal = os.getenv('TERMINAL') or 'alacritty'
module.browser = 'chromium'
module.filemanager = module.terminal .. ' -e ranger'
module.gui_editor = 'code'
module.editor = os.getenv('EDITOR') or 'vim'
module.editor_cmd = module.terminal .. ' -e ' .. module.editor

return module