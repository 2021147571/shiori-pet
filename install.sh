#!/bin/sh
set -eu

base='https://raw.githubusercontent.com/2021147571/shiori-pet/main'
root="${CODEX_HOME:-$HOME/.codex}"
tmp=$(mktemp -d)
trap 'rm -f "$tmp/pet.json" "$tmp/spritesheet.webp"; rmdir "$tmp"' EXIT HUP INT TERM

for file in pet.json spritesheet.webp; do
    curl -fsSL "$base/$file" -o "$tmp/$file"
done

check() {
    if command -v sha256sum >/dev/null 2>&1; then
        actual=$(sha256sum "$tmp/$1" | cut -d ' ' -f 1)
    else
        actual=$(shasum -a 256 "$tmp/$1" | cut -d ' ' -f 1)
    fi
    [ "$actual" = "$2" ] || { printf 'Checksum mismatch: %s. No files installed.\n' "$1" >&2; exit 1; }
}
check pet.json 9eab6e55964421a6d6cbbd5c9ab332d54b05824fbecae15e66add0507f04ef66
check spritesheet.webp 0b26f4e95696f2c6bd2f3437fe679411296fde9b35d3148d54c3008552dce087

mkdir -p "$root/pets/shiori"
cp "$tmp/pet.json" "$tmp/spritesheet.webp" "$root/pets/shiori/"
printf 'Installed Shiori (水产) to %s/pets/shiori\n' "$root"
printf 'Open Settings > Pets, refresh, and select 水产.\n'
