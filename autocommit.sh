#!/bin/bash

cd ~/.dotfiles

git add .
git commit -m "Auto-commit: $(date)"
git push origin main
