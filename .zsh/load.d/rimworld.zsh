#!/usr/bin/env zsh


compile_rimworld_mod() {
    FrameworkPathOverride=$(dirname $(which mono))/../lib/mono/4.7.2-api/ dotnet build "$1" /property:Configuration=Release
}

hash -d rw=~/apps/rimworld
hash -d mods=~/apps/rimworld/game/Mods
