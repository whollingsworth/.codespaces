#!/bin/bash

# Install Fish from PPA
sudo apt-add-repository ppa:fish-shell/release-4 --yes >/dev/null 2>&1
sudo apt update >/dev/null 2>&1
sudo apt install --assume-yes fish >/dev/null 2>&1

# Install plugins and prompt via reef
fish_theme=IlanCosman/tide

corals="danielb2/reef ${fish_theme} edc/bass jorgebucaran/autopair.fish patrickf1/colored_man_pages.fish patrickf1/fzf.fish"

reef_init_cmd="$(
  cat <<EOF
  curl --silent --location https://tinyurl.com/fish-reef | source &&
    reef add danielb2/reef && reef init && reef add ${corals}
EOF
)"

fish --command "${reef_init_cmd}"

tide_configure_cmd="$(
  cat <<EOF
  tide configure \
    --auto \
    --style=Lean \
    --prompt_colors='True color' \
    --show_time='24-hour format' \
    --lean_prompt_height='Two lines' \
    --prompt_connection=Solid \
    --prompt_connection_andor_frame_color=Darkest \
    --prompt_spacing=Sparse \
    --icons='Many icons' \
    --transient=Yes
EOF
)"

fish --command "${tide_configure_cmd} && reef theme ${fish_theme}"

# Install chruby-fish
build_dir=$(mktemp --directory)
cwd=$(pwd)
cd "${build_dir}"

wget --output-document=chruby-fish-1.0.0.tar.gz https://github.com/JeanMertz/chruby-fish/archive/v1.0.0.tar.gz >/dev/null 2>&1
tar --extract --gzip --verbose --file=chruby-fish-1.0.0.tar.gz >/dev/null 2>&1
cd chruby-fish-1.0.0/
sudo make install >/dev/null 2>&1

cd "${cwd}"
rm -rf "${build_dir}"
