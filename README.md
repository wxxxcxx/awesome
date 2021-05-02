# My AwesomeWM Configuration 

## Features

+ Automatically adapt theme color by current GTK theme.
+ Automatically Set the title bar and border's color by window content. (`modkey+HOME` refreshed manually)
+ Global select and translate. ([awm-translator](https://github.com/meetcw/awm-translator) ,default bind to `modkey+z`)
+ Desktop lyrics for [YesPlayMusic](https://github.com/qier222/YesPlayMusic). ([awm-ypm-lyrics](https://github.com/meetcw/awm-ypm-lyrics))
  

## Dependencies

+ `pulseaudio` required by Volume controller widget.
+ `rofi` required by the launchpad.
+ Desktop menu use `light-lock` as the default screen locker.

## Installation

``` shell
git clone --recurse-submodules https://github.com/meetcw/awesome.git
```

## Structure

``` 
.
├── awm-translator      # desktop translate plugin, bind to `modkey+z` by default
├── awm-ypm-lyrics      # desktop lyrics plugin for `YesPlayMusic`
├── bar.lua             # default bar config
├── client.lua          # client config
├── clientkeys.lua      # keybindings for client, required by `client.lua`
├── clientrules.lua     # client rules, required by `client.lua`
├── desktop.lua         # export a init method to initialize desktop 
├── environment.lua     # some variables
├── error.lua           # show error by notification
├── globalkeys.lua      # global keybindings
├── globalmenu.lua      # menu for right-click on desktop
├── idot.yaml           # ignore, it's used by my dot file manager 
├── keydefine.lua       # define modifier key
├── lyrics.lua          # config for `desktop lyrics plugin`
├── misc                # misc files, e.g. launchpad theme for rofi
├── rc.lua              # default config file
├── README.md
├── screenshots
├── themes              # default theme
├── utils               # some helpers for awesomewm
├── wallpapers
└── widgets             # some custom widgets on default bar
```
## Screenshots
 
![A](./screenshots/01.png)

![B](./screenshots/02.png)