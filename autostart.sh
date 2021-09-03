if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then
    exit
fi
xrdb -merge <<<"awesome.started:true"
setxkbmap -option caps:ctrl_modifier
xset r rate 300 30

picom&
fcitx&

cd /usr/share/clash-dashboard-git&&python -m http.server 7090&

dex --environment Awesome --autostart
