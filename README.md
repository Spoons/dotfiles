# dotfiles
----
Nothing is as comforting as sitting by a stoked fire on a cold winters day, obsessing over your dotfiles.

## Screenshots
## Introduction
This repository contains my personal dotfiles. I use yadm to manage the git repository and deploy them. However, uses of yadm is certainly not necessary. I would imagine you would be best served by looking through these files and adding what you like to your personal files. However, you certainly could deploy them directly to your machine. There exists only minimal configuration specific to me in this repository.

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

## Setup
To deploy this configuration install yadm through your distribution package manage and clone with `yadm clone https://https://gim/Spoons/dotfiles.git`.

Alternatively, clone this repository and import into your dotfile management scheme of your choice. Any missing dependencies will be automatically installed upon the next interactive invocation of zsh.

## Managing Files
Yadm is a thin wrapper around git. Simply use the default git subcommands to manage your files.

``` sh
yadm add .zshrc
yadm status
yadm commit -m "changes to zshrc"
yadm push
```

## ZSH Configuration
Zsh scripts are dynamically loaded in the `~/.zsh/load.d` directory. Place any additional zsh configuration into that directory and they will be read during interactive initialization. 
