#!/bin/zsh

# ########################## --git aliases(+)-- ############################# #
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
function gdback() {  # git diff against N commits ago
    git diff HEAD~$1 HEAD  # HEAD~X <-- head x commits ago
}
# NOTE: function used to syntatically allow concatination of argument

alias gf='git fetch'

alias ginit='git init'

alias glog='git log'
alias glg='git log --all --decorate --oneline --graph'  # commit graph

alias gm='git merge'
function gmpreview() {  # shows changes that would be merged
    git diff ...$1      # from supplied_branch (<arg>) to current_branch (inferred)
}
# NOTE: comparison branch must be provided; hence a function rather than alias:
#       to allow argument to concatenated with '...' + ' <arg>'  ~~> '...<arg>'

alias gpush='git push'  # minimally abbreviated due to similarity to 'git pull'
alias gpull='git pull'

alias grem='git remote'
alias gremv='git remote --verbose'

alias gs='git status'

alias gt='git ls-tree' # give content info about a git work-tree

