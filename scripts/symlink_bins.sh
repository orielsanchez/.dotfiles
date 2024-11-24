# ~/.dotfiles/scripts/symlink_bins.sh
for file in ~/.dotfiles/bin/*; do
    ln -sf "$file" ~/.local/bin/$(basename "$file")
done
