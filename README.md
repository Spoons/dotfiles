# dotfiles
I find nothing more comforting that obsessing over my dotfiles. May my obsession help you on your Unix journey.

## Introduction
This repository contains my personal dotfiles. I use yadm to manage and deploy them. There is minimal machine specific configuration in the `.xinitrc`. 

| Application  | Choice         |
|--------------|----------------|
| Shell        | zsh            |
| WM / DE      | bspwm          |
| Editor       | neovim / emacs |
| Terminal     | kitty          |
| Multiplexer  | tmux / kitty   |
| Audio        | ncmpcpp / mpd  |
| Monitor      | polybar        |
| Mail         | thunderbird    |
| Irc          | circe          |
| File Manager | ranger         |

If you use an Nvidia GPU setup with X11, you may find the `.bin/nvffc` script useful for eliminating screen tearing. Additionally, I recommend my systemd aliases in `.zsh/load.d/systemd.zsh`.

## Setup
To deploy this configuration install yadm through your distribution package manage and clone with `yadm clone https://https://gim/Spoons/dotfiles.git`.

Alternatively, clone this repository and import into your dotfile management scheme of your choice. 

Any missing dependencies will be automatically installed upon the next interactive invocation of zsh.

## Managing Files
Yadm is a thin wrapper around git. Simply use the default git subcommands to manage your files.

``` sh
yadm add .zshrc
yadm status
yadm commit -m "changes to zshrc"
yadm push
```

## ZSH Configuration
Zsh scripts are dynamically loaded in the `~/.zsh/load.d` directory. Place any additional zsh configuration into that directory and they will be interpreted during zsh startup. Ensure they are executable.
