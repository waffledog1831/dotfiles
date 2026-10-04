#!/bin/bash

link_path() {
  local src="$1" dst="$2"
  if [ ! -e "$src" ]; then
    echo "ERROR: source does not exist: $src" >&2
    return 1
  fi
  if [ -d "$dst" ] && [ ! -L "$dst" ]; then
    echo "ERROR: $dst is a real directory, not a symlink. Back it up and move it manually." >&2
    return 1
  fi
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "unchanged: $dst"
    return 0
  fi
  ln -sfn "$src" "$dst"
  echo "linked: $dst"
}
