## Symlink settings

```shell
ln -s ~/git/personal/environment/karabiner.json ~/.config/karabiner/karabiner.json
ln -s ~/git/personal/environment/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -s ~/git/personal/environment/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
ln -s ~/git/personal/environment/flake.nix ~/.config/nix-darwin/flake.nix
```

## Package manager

[Homebrew/brew: 🍺 The missing package manager for macOS (or Linux)](https://github.com/Homebrew/brew)

[LnL7/nix-darwin: nix modules for darwin](https://github.com/LnL7/nix-darwin)

[Nix is my favorite package manager to use on macOS - YouTube](https://www.youtube.com/watch?v=Z8BL8mdzWHI)

```shell
mkdir -p ~/.config/nix-darwin                                                                                   
cd ~/.config/nix-darwin
nix flake init -t nix-darwin --extra-experimental-features "nix-command flakes"
sed -i '' "s/simple/$(scutil --get LocalHostName)/" flake.nix

nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.config/nix-darwin#mbp

darwin-rebuild switch --flake ~/.config/nix-darwin#mbp --impure'  
```


## Finder context menu

[SzContext: Add context menu to macOS Finder](https://github.com/RoadToDream/SzContext)

## Window manager

[Magnet – Window manager for Mac](https://magnet.crowdcafe.com/)

[rcmd - Switch apps instantly using the ⌘ Right Command key](https://lowtechguys.com/rcmd/)

[lwouis/alt-tab-macos: Windows alt-tab on macOS](https://github.com/lwouis/alt-tab-macos)



## File manager

[Commander One](https://mac.eltima.com/file-manager.html)

why: https://airtable.com/shrbhfzUtnDA2B6Al/tblJj2orYPqJeVg80

## Terminal

[iTerm2 - macOS Terminal Replacement](https://iterm2.com/)

## system monitor

[stats: macOS system monitor in your menu bar](https://github.com/exelban/stats)
