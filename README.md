Mac setup bash script
===

1. clone this repo
2. run `sh start.sh` in the directory
3. win!

---
## Additional Setup

### iTerm2 with Powerline
https://gist.github.com/kevin-smets/8568070
https://gist.github.com/agnoster/3712874
https://coderwall.com/p/yiot4q/setup-vim-powerline-and-iterm2-on-mac-os-x


### Install a patched font

- [Meslo](https://github.com/powerline/fonts/blob/master/Meslo%20Slashed/Meslo%20LG%20M%20Regular%20for%20Powerline.ttf) (the one in the screenshot). Click "view raw" to download the font.
- [Source Code Pro](https://github.com/powerline/fonts/blob/master/SourceCodePro/Sauce%20Code%20Powerline%20Regular.otf) has better alignment for the glyphs @14px.
- [Others @ powerline fonts](https://github.com/powerline/fonts)
    
Open the downloaded font and press "Install Font".

Set this font in iTerm2 (14px is my personal preference) (iTerm → Preferences → Profiles → Text → Change Font).

Restart iTerm2 for all changes to take effect.


### Disable the Character Accent Menu
```
defaults write -g ApplePressAndHoldEnabled -bool false
```


### Increase terminal cursor speed
```
System Preferences -> Keyboard -> Key Repeat Rate
System Preferences -> Keyboard -> Delay Until Repeat
```
