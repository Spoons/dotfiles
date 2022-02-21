#!/bin/zsh

inotifywait -m . -e create --include "\pkg.tar.zst" | while read path action file; do
	repo-add -n custom.db.tar.zst "$file"
done
