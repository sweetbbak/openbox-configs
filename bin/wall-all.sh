#!/bin/bash

# You can create a function for this in your shellrc (.bashrc, .zshrc).
wal -i "$1"
# nitrogen --set-zoom-fill "$(< "${HOME}/.cache/wal/wal")"
walthura > "$HOME"/.config/zathura/zathurarc
pywalfox update
cp ~/.cache/wal/colors.sh ~/Templates \
    && cat ~/Templates/pywal.zsh >> ~/Templates/colors.sh \
    && cat ~/Templates/colors.sh > ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/pywal.zsh
