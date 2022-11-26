#!/bin/zsh

# ############################# --fzf-- ################################ #
# fzf is amazing, but uncharacteristically ...wide for a terminal app
# below are multiple defaults that apply to various ways of calling
# the underlying functionality.
#
# Common themes: 
#   1) we use the much more efficient 'fd' to find items
#   2) we allow find to look at hidden and "ignored" files
#   3) we tell it to (separately) ignore .git folders


# ----------- ~Input (arguments to commands that feed fzf input)  -----------
# NOTE: most of the arguments listed below are arguments for **'fd'**
#       fzf is helping you sort through results fed to it
#       and the options we touch affect what's fed in (via 'fd')

# used when called as 'fzf'
#   e.g. 'fzf | xargs rm -i'
export FZF_DEFAULT_COMMAND='fd --type f --unrestricted --exclude .git'
    # use fd / type: files / show hidden & ignored (e.g. due to .gitignore)
    # / follow symlinkgs / exclude .git dirs

# used when called as the keybinding 'Cntl+t'
#   <C+t>: search files FROM LOCAL DIR DOWN and drop chosen into commandline
export FZF_CTRL_T_COMMAND='fd --type f --unrestricted --exclude .git' # . $HOME'

# used when called as the keybinding 'Alt+c'
#   <A+c>: search directories FROM $HOME DOWN and then cd to chosen
export FZF_ALT_C_COMMAND='fd --type d --unrestricted --follow . $HOME'
    # use fd / type: dirs / show hidden & ignored (e.g. due to .gitignore)
    # / follow symlinkgs / exclude .git dirs / use $HOME as dir_argument

# used when called as '**' and returning a file or directory path(s)
#   e.g. 'nano **' or 'nvim **'
_fzf_compgen_path() {
    fd --unrestricted --follow --exclude ".git" #  . "$HOME"
    # use fd / show hidden & ignored (e.g. due to .gitignore)
    # / follow symlinkgs / exclude .git dirs / dir_argument
}

# used when called as '**' and returning ONLY a directory path(s)
#   e.g. 'cd **'
_fzf_compgen_dir() {
    fd --type d --unrestricted --follow --exclude ".git" #  . "$HOME"
    # use fd / type: dirs / show hidden & ignored (e.g. due to .gitignore)
    # / follow symlinkgs / exclude .git dirs / dir_argument
}


# ----------- ~Output (arguments to fzf-proper)  -----------
# default options for fzf
# export FZF_DEFAULT_OPTS='--multi --preview "bat --style=numbers --color=always --line-range :500 {}"'
# enable multiple selection (with tab/shft+tab) 
# / preview with bat command [/show lines numbers / use color / line range 1through 500]

# fzf... ~~()~~> "fzf"
alias -g fzf='fzf --multi'

export FZF_CTRL_T_OPTS='--multi --preview "bat --style=numbers --color=always --line-range :500 {}"'
export FZF_CTRL_R_OPTS=''
export FZF_ALT_C_OPTS='--preview "'"exa --tree --all --ignore-glob="'".git"'" --icons {}"'"'
# ^NOTE: the above call involves triple-nested quotes.
#        to do this we've used double-quoted single-quotes ("'") 
#        at each inside level.

# the completion commands (<command> **[tab]) 
# use the following to determine output options
_fzf_comprun() {
    local command=$1
    shift

    # NOTE: uses input alias, not it's expansion (e.g. 'z' -!-> 'c')
    case "$command" in
        cd|c|z)       fzf "$@" --preview 'exa --tree --all --ignore-glob=".git" {}' ;;
        cp|mv)        fd --unrestricted --exclude .git . $HOME | fzf "$@" --preview 'exa --tree --all --ignore-glob=".git" {}' ;;
        export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
        ssh)          fzf "$@" --preview 'dig {}' ;;
        viu)          fzf "$@" --preview 'viu --blocks --height=20 {}' ;;
        nn|nvim|vim|nano|hx|sd|sed|awk)
            fzf "$@" --multi --preview 'bat --style=numbers --color=always --line-range :500 {}' ;;
        *)            fzf "$@" --multi ;;
    esac
}


# ----------- source (fzf)  -----------
# checks ("[ -f") if '.fzf.zsh' exists in ~ and then sources it if so
# note: .fzf.zsh will have a reference to the location of the keybindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
