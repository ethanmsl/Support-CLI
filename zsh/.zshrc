# ~~~~~~~~ --order of sourcing-- ~~~~~~~~ #
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


# ~~~~~~~~ --useful documentation-- ~~~~~~~~ #
# Man-page with a ton of ZSH info:
#   'man zshcontrib'
# Man-page with many (not all) ZSH options:
#   'man zshoptions'

# while this did not directly contribute to much here due to timing 
# the following website deserves special mention:
#   https://thevaluable.dev/zsh-install-configure-mouseless/


# ############################ --ZSH Stuff-- ######################## #
# sets the zsh_history file in its typical location, preventing it from
# being placed in our git versioned  ZSH/ directory (due to $ZDOTDIR setting in .zshenv)
# this is principally as a backup defense (on top of gitignore) against accidentally
# synching terminal history (and possibly sensitive data)
# NOTE: also in .zshenv
export HISTFILE=$HOME/.zsh_history


# ######################### --ZSH Options --############################ #
# SHOW: 'setopt' <-- shows currently set options
# SEE: 'man zshoptions'

# set cd'ing with just directory names typed in
setopt auto_cd

# try to correct command and all arguments on line
setopt correct_all
export CORRECT_IGNORE_FILE='.vim|.nvim|.git'
# ^ list of *replacements* to NOT offer for correct_*all*
#   if you want to add anything to this list just add "|<the_correction>"
#   to the above

# all cd actions add last location to a stack (can used 'popd' to de-stack and travel to location)
setopt auto_pushd

# enable vi mode, increase visual responsiveness, load cursor change code
bindkey -v
export KEYTIMEOUT=1
source ~/.config/zsh/sources/cursor-reflect-vimode.zsh

# default editor
# "VISUAL" and "EDITOR" usually substitutable, best to set both to same
export EDITOR='nano'
export VISUAL='nano'
# alternatives: vim, nvim, helix


# ########################### --Aliases-- ############################## #
# ¡NOTE!:  'alias -g ...' allows alias to work even if not first word in command
#           e.g. say    'al='alias'
#                then   > al  ~~> > alias
#                       > fd whatever | al ~~> fd whatever | alias
#                BUT    > sudo al  ~~> sudo al     <-- no expansion
#                       > echo al ~~> echo al      <-- no expansion
#               this can be corrected by globaling the alias, with the caveat
#               that that letter word will *always* expand
#
#  SEE: `which <alias>` to find what something is aliased to

# ----------- shadow aliases (WoooOOOooo) -----------
# I'm including these aliases for simplicity of adoption and to assist
# with learning classic terminal commands
# I also have non-shadowed versions below
# feel free (as with everything) to remove or adjust the following

# ----- ls series, but with color -----
# clasic ls, list view ll, and then an alias for tree also offered as 'lt'
# NOTE: I have included '--all' ('-a') for all of the ls series
#       that is not default behavior, but shows "hidden" files by default
#       and will help when exploring the systems we're using.
alias -g ls='exa --all'
alias -g ll='exa --all --long'
alias -g lt='exa --all --tree --level=3'
alias -g tree='exa --all --tree --level=6'

# ----- cat, but with color -----
alias -g cat='bat --paging=never'

# ----- man(pages), but with color -----
alias -g man='batman'

# NOTE: three replacement commands are *NOT* shadowed here
#       they take different syntax
#       'rg' (ripgrep) mostly replaces 'grep', but has different syntax
#       'c'/'z' (zoxide) mostly replace 'cd', but fuzzy corrects to closest visisted dir
#       'fd' mostly replaces 'find', but has different syntax
#       (and not included as defaults in our repo, but 'sd' vs 'sed': same deal)
# ---------------------------

# ----------- git -----------
# git ~~()~~> "g"
# NOTE: similar, but different aliasing can be set in '.gitconfig'
#       those aliases are for the arguments that *follow* the 'git ' command

alias g='git'

alias ga='git add'
alias gau='git add --update'  # git add all tracked && updated files
alias grs='git restore --staged'  # un-stage files *specified*
alias gkh='git checkout HEAD'  # return files to last commit state (¡does not preserve changes as unstaged!)

alias gb='git branch'  # git list all branches if no further elaboration
alias gba='git branch --all --verbose --verbose' # also list:
#                           remote branches, last commit, and tracking branch
#                           (double '--verbose' is needed for last one)
alias gbv='git branch --verbose --verbose' # last commit & tracking branch
#                                            (double '--verbose' is needed)
alias gk='git checkout'

alias gc='git commit'
alias gcm='git commit --message'  # git commit along with commit message on line

alias gd='git diff'
alias gds='git diff --staged'

alias gf='git fetch'

alias glg='git log --all --decorate --oneline --graph'  # commit graph

alias gm='git merge'
function gmpreview() {  # shows changes that would be merged
    git diff ...$1      # from supplied_branch (<arg>) to current_branch (inferred)
}
# NOTE: comprison branch must be provided; hence a function to alow argument
#       to be easily combined with '...' + ' <arg>'  ~~> '...<arg>'

alias gpush='git push'  # minimally abbreviated due to similarity to 'git pull'
alias gpull='git pull'

alias grem='git remote'
alias gremv='git remote --verbose'

alias gs='git status'

alias gt='git ls-tree' # give content info about a git work-tree

# ----------- neovim -----------
# nvim ~~()~~> "nn" Note: "nm" is a prexisting keyword AND 'nn' is apropos
alias nn='nvim'

# # neovide --multigrid ~~()~~> "nv"
# alias nv='neovide --multigrid'  # neovide is a GUI application for neovim

# ----------- varied -----------
# batman ~~()~~> "mab"
alias mab='batman'

# exa ~~()~~> "e"_fam  (~= "ls"_fam)
alias es='exa --all --classify  --icons --sort="type"'
alias el='exa --long --numeric --all --classify --header --icons --sort="type" --time-style="long-iso"'
alias et='exa --tree --all --ignore-glob=".git" --icons --sort="type" --level=3'  # tree: max_depth 3
alias etall='exa --tree --all --ignore-glob=".git" --icons --sort="type"'         # tree: unlimited depth

# fzf... ~~()~~> "fzf"
# NOTE: fzf is involved enough to have its own file.
#       See the "--fzf--" section (below) for source reference.
#       Defined in that source file:
# alias -g fzf --<with bat preview>

# [ripgrep] rg... ~~()~~> "rg"
# '-s' to add case sensitivity back
alias -g rg='rg --hidden --ignore-case'
# ^global to prevent silent fall back and subtle confusions that would ensue

# sets up zoxide, which operates as "z"
# z ~~()~~> "c"  (easier to type and a partial version of "cd", lol)
eval "$(zoxide init zsh)"
alias c='z'


# ~~~~~~~~ --ZSH Completions ~~~~~~~~ #
# --not using completions, but leaving this here should there be sufficient future interest--
# --On Why:
#       arcane, maintenance heavy (new command/new options req changes),
#       can slow down shell, and, per purposes of this repo,
#       getting comfortable with  'man xxx' | 'xxx --help' is helpful :) --
# useful info on completion system: 
#   https://thevaluable.dev/zsh-completion-guide-examples/

# # as-needed-loading, without alias expansion and in in zsh-style, of comp(letion)init
# autoload -Uz compinit
# compinit

# brew folder important to adding completions:
#   /opt/homebrew/share/zsh/site-functions


# ############################# --fzf-- ################################ #
# fzf is amazing, but uncharacteristically ...wide for a terminal app
# below are multiple defaults that apply to various ways of calling
# the underlying functionality.
#
# So, for organizational purposes, we've moved it to it's own file.
# Which we simply source here. :)

source ~/.config/zsh/sources/fzf-call-settings.zsh


# ############################ --Prompt-- ############################# #
# My first prompt :)
# [leaving it here in case you ever want to go hyper-minimal or 
#  want a cue on tossing a bit of color into another setup without installs]
#PROMPT="%F{cyan}%n %1~ %# %f"

# Starship.rs initializer (to be at "end" of file, along with the following line)
eval "$(starship init zsh)"


# ########################### --ZSH Input Mods-- ####################### #
# NOTE: location may change for a given installation
#       if in doubt: 'brew reinstall ...' and check the output location
#       (it should give you an explicit "source ..." line to add)
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
