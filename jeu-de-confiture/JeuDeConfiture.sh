#!/bin/sh
printf '\033c\033]0;%s\a' JeuDeConfiture
base_path="$(dirname "$(realpath "$0")")"
"$base_path/JeuDeConfiture.x86_64" "$@"
