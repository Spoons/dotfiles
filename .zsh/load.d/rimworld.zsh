#!/usr/bin/env zsh


compile_rimworld_mod() {
    FrameworkPathOverride=$(dirname $(which mono))/../lib/mono/4.7.2-api/ dotnet build "$1" /property:Configuration=Release
}

