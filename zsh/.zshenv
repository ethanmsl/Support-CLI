## --order of sourcing--
# (ignoring /etc/* files)
# $ZDOTDIR/.zshenv
# $ZDOTDIR/.zprofile <-- XOR .zlogin  (by intention, but not enforced)
# $ZDOTDIR/.zshrc
# $ZDOTDIR/.zlogin  <-- XOR .zprofile  (by intention, but not enforced)
# $ZDOTDIR/.zlogout
#
# NOTES: env: sourced each shell
#        rc: sourced each *interactive* shell
#        profile|x|login : sourced each *login* shell 
#                           login-shells often not opened in linux, but
#                           opened with each new window or tab in macOS
#


# ########################## --Path Exports-- ###################### #
# ----------- ZSH ----------- 
export ZDOTDIR=$HOME/.config/zsh
export HISTFILE=$HOME/.zsh_history
# sets the xsh_history file in its typical location, preventing it from
# being placed in our git versioned  ZSH/ directory (due to $ZDOTDIR setting in .zshenv)

# ----------- starship (terminal prompt) ----------- 
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

# ----------- git ----------- 
export GIT_CONFIG_GLOBAL=$HOME/.config/git_global/.gitconfig
# "git_config_(global/system)": 
#       "..._global"" is for user (usually in "$HOME/...")
#       "..._system" is for system/computer (usually in "/etc/...")

# ----------- Go ----------- 
# note: these came up when trying to make the PagerDuty-Terraform Provider
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH

# ----------- Haskell ----------- 
# this was where haskell wanted to install >>stack install haskell-dap ghci-dap haskell-debug-adapter<<
export PATH=$PATH:$HOME/.local/bin

# ----------- Rust ----------- 
export PATH=$PATH:$HOME/.cargo/bin

# ########################## --Environment Sourcing-- ###################### #
# NOTE: "." is posix ~= of "source"
#   in zsh: 
#       "." looks in $PATH first and closes shell if it fails to find target
#       "source" looks in current directory first and only closes shell 
#           if run in posix mode

# ----------- Sourcing Rust-relevant environment variables ----------- 
# . "$HOME/.cargo/env"
# ^ this is just a PATH check and export if not found (made to be easily overidden)
# unecessary, as we are directly exporting the PATH above, but kept for reference

# -----------  Haskell -----------  #
# checks if file is present then sources
# [ -f "/Users/eskowronski-lutz/.ghcup/env" ] && source "/Users/eskowronski-lutz/.ghcup/env" # ghcup-env
