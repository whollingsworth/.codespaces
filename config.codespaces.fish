# Set CDPATH
set --export CDPATH . /workspaces/monorama/apps $CDPATH

# Prevent Lynx from trying and failing to help us log in with AWS SSO
set --export BROWSER /bin/true

set --export PANORAMA_TOP /workspaces

if test "$CODESPACES" = true
    # Creates a conflict with chruby-fish
    # Shell includes from school-supplies export non-zsh related variables under a zsh check
    # bass source $HOME/.panoramarc
end

# Make sure chruby-fish is in and autoloaded path
set --universal XDG_DATA_DIRS /usr/local/share
