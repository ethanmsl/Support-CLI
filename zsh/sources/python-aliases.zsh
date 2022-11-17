#!/bin/zsh

# ########################## --Python aliases(+)-- ############################# #


# ----------- Python run -----------
# python3 ~~()~~> "py"
alias py='python3'

# <(poetry) virtualized python3> ~~()~~> "ppy"
alias ppy='poetry run python3'


# ----------- Virtual (venv) Python -----------
# <venv _> ~~()~~> "vpy_"
alias vpyinit='python3 -m venv ./venv'
alias vpyon='source venv/bin/activate'
alias vpyoff='deactivate'


# ----------- Poetry (virtualization, dependencies, packaging, ...) -----------
# poetry _ ~~()~~> "poet_"
alias poet='poetry'

#       add
alias poeta='echo "did you mean '"'poetau(usr)'"' or '"'poetadv(dev)'"'?\nOtherwise, please use '"'poet add ... --.. --..'"'."'
alias poetau='poetry add'
alias poetadv='poetry add --group=dev'

#       cache & check
# alias poetcc='poetry cache clear'
# # ^not working correctly as of XI-16-'22 : see 'workarounds' below
alias poetck='poetry check'

#       export
alias poetexp='poetry export'
alias poetreq='poetry export --format=requirements.txt'
alias poetreqwrite='poetry export --format=requirements.txt --output=requirements.txt'
# Note: we can use 'poetreq' alongside '> requirements.txt' or use the given
#       syntax via 'poetreqout': ''--output=...'

#       init & install
alias poetini="poetry init"
alias poetinstall='poetry install'

#       list & lock
alias poetlist='poetry list'
alias poetlock='poetry lock'

#       new
# trying to prevent non-src based repo structs and remember that needs specification
alias poetn='echo "did you mean '"'poetns'"', i.e. '"'poetry new --src'"'?"'
alias poetns='poetry new --src'

#       shell & show
alias poets='poetry shell'
alias poetshll='poetry shell'
alias poetswt='poetry show --tree'

#       remove & run
alias poetrm='poetry remove'
alias poetrun='poetry run'

#       update
alias poetup='poetry update'

#       workarounds
alias poethashnotfoundworkaround='rg "not found in known hashes" | choose -f "archive" 1 | choose 0 | xargs -I_ fd _ $POETRY_CACHE_DIR | xargs -o rm -i'
# ^ pipe input from something complaining about hash not found -- to get problem item and (with confirmation) remove it
