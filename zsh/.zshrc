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

# all cd actions add last location to a stack (can used 'popd' to de-stack and travel to location)
setopt auto_pushd

# don't play 'BEEP' sound when asked for non-definite completion
# (e.g. if you type 'cd .z[tab]' in a folder with '.zshrc' and '.zshenv' in it)
unsetopt LIST_BEEP

# try to correct command and all arguments on line
setopt correct_all
export CORRECT_IGNORE_FILE='.vim|.nvim|.git'
# ^ list of *replacements* to NOT offer for correct_*all*
#   if you want to add anything to this list just add "|<the_correction>"
#   to the above

# enable vi mode, increase visual responsiveness, load cursor change code
source ~/.config/zsh/sources/enhanced-vimode-setup.zsh
# ^ because there's enough going on in our set-up of vi-mode rather than
# dump all that info here, we've kept things clean and modular by putting that
# code in a separate file and then just calling it from here!
# if you're using something like NeoVim or VSCode you'll be able to easily
# open that file from this one if you have a project view open or LSP ready.
# (or just using <gf> for go to file on the path in default NeoVim or Vim)
#
# Quick lesson: "source" just takes a path to a ZSH file and then looks for and
#               runs it. (almost like it were in this file)
#               (Options also exist to allow sourcing other *SH files.)
#
# NOTE: you will see both
#           1) "source <some_path>"
#           2) ". <some_path>"
#       in various contexts.
#       In ZSH "." and "source" are **almost** the same thing.
#       They differ slightly in the where the file looks *first*
#       (locally or in established $PATH - "source" & ".", resp.)
#   Handy documentation references:
#       "source": https://zsh.sourceforge.io/Doc/Release/Shell-Builtin-Commands.html#index-source
#       ".": https://zsh.sourceforge.io/Doc/Release/Shell-Builtin-Commands.html#index-dot

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
# NOTE: `which <alias>` to find what something is aliased to
#        e.g. ``` ❯ which gs
#                 gs: aliased to git status  ```
#        'which' might seem like a funny command name, vs, say,'definition'.
#        The context was, presumably in disambiguiating *which* instance of a
#        command that was duplicated in the $PATH was being used
#        ('$PATH' is the main list of places your shell looks for stuff.)
#        e.g. "python3" could have been installed in two different places.
#             Maybe it was installed by default on some system and then you
#             installed your own.
#             so there could be two paths:
#             `~/python/python3` & `/usr/bin/python3`
#             when you type the command "python3" what happens is the machine
#             looks through the $PATH and finds the some instance of 'python3'
#             and then runs that.
#       If you were worried that this might be happening or knew it was but
#       wanted to know **which** version 'python3' calls you could then use:
#           'which python3'
#       and get told "which" of the python3 paths is being used.
#
#       `which <alias>` ~~~> definition
#       seems to be an extension of that functionality.
#       Hence, in this imagined history, the slightly off-seeming name.

# ----------- **shadow** aliases (WoooOOOooo) -----------
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
alias -g tree='exa --all --tree --level=6'  # 'tree' is a common cli command, 
                                            # though not pre-installed on mac

# ----- cat, but with color -----
alias -g cat='bat --paging=never'

# ----- man(pages), but with color -----
alias -g man='batman'
# NOTE: some commands do not have man pages, but often will respond to
#       '<command> --help'
#       when that help has man-like syntax we can simulate 'batman' 
#       by piping the help docs into our colored pager
#       '<command> --help | bat' (or, with shadowing: '<command> --help | cat')

# NOTE: three replacement commands are *NOT* shadowed here
#       they take different syntax
#       'rg' (ripgrep) mostly replaces 'grep', but has different syntax
#       'c'/'z' (zoxide) mostly replace 'cd', but fuzzy corrects to closest visited dir
#       'fd' mostly replaces 'find', but has different syntax
#       (and not included as defaults in our repo, but 'sd' vs 'sed': same deal)
# ---------------------------

# ----------- git -----------
# git ~~()~~> "g"
# NOTE: as/if you use the terminal more frequently you will find there are some
#       commands that are verbose relative to how often you use them.
#       You're no prisoner!  You can define your own vocabulary!
#       A common example of this is the git family of commands.
#       A list of simplified aliases for common commands is loaded in below.
#
#       It would be perfectly natural to have here, but to (a) keep this file
#       more legible to diverse backgrounds and (b) make removal doubly easy
#       (as many people will already have their own custom argot).
#       But please take a look for an example of making easy what YOU use.
source ~/.config/zsh/sources/git-aliases.zsh
# NOTE: similar, but different aliasing can be set in '.gitconfig'
#       those aliases are for the arguments that *follow* the 'git ' command
#       whereas the above are for the whole train.

# ----------- neovim -----------
# leaving these here for possible future use (by repo or you, personalyl:)

# nvim ~~()~~> "nn" Note: "nm" is a prexisting keyword AND 'nn' is apropos ;)
# alias nn='nvim'

# # neovide --multigrid ~~()~~> "nv"
# alias nv='neovide --multigrid'  # neovide is a GUI application for neovim

# ----------- Python -----------
# python3 ~~()~~> "py"
# <venv _> ~~()~~> "vpy_"
# poetry _ ~~()~~> "poet_"
source ~/.config/zsh/sources/python-aliases.zsh

# ----------- varied -----------
# batman ~~()~~> "mab"
alias mab='batman'

# exa ~~()~~> "e"_fam  (~= "ls"_fam)
alias es='exa --all --classify  --icons --sort="type"'
alias el='exa --long --numeric --all --classify --header --icons --sort="type" --time-style="long-iso"'
alias et='exa --tree --all --ignore-glob=".git" --icons --sort="type" --level=3'  # tree: max_depth 3
alias etall='exa --tree --all --ignore-glob=".git" --icons --sort="type"'         # tree: unlimited depth

# fd... ~~()~~> "fd"
alias fd='fd --hidden'

# fzf... ~~()~~> "fzf"
# NOTE: fzf is involved enough to have its own file.
#       See the "--fzf--" section (below) for source reference.
#       Defined in that source file:
# alias -g fzf --multi

# [ripgrep] rg... ~~()~~> "rg"
# '-s' to add case sensitivity
 alias rg='rg --hidden --smart-case'  # case-insensitive unless caps in query

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
#   /usr/local/share/zsh/site-functions


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
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
