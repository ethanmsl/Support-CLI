#!/bin/zsh

# Change cursor shape for different vi modes.
# 'echo -ne' : don't print newline at end and read '\'
function zle-keymap-select {
    if
        [[ ${KEYMAP} == vicmd ]] ||
        [[ $1 = 'block' ]]
    then
        echo -ne '\e[1 q'
    elif
        [[ ${KEYMAP} == main ]] ||
        [[ ${KEYMAP} == viins ]] ||
        [[ ${KEYMAP} = '' ]] ||
        [[ $1 = 'beam' ]]
    then
        echo -ne '\e[5 q'
    fi
}
zle -N zle-keymap-select
# ^create user-defined widget ('zle -N <func>')

# Use beam shape cursor on startup
echo -ne '\e[5 q'

# 'preexec()': executed right before entered command is
#  so it should effectively set the cursor shape for the next line
# (useful when a command is entered in <normal> mode,
#  to prevent inheriting the block-cursor shape)
preexec() { echo -ne '\e[5 q' ;}


########### back-pocket function ###########
# # this script starts us in <insert> mode AND sets cursor to blink-bar
# # the first part is redundant with standard behavior
# # the second is redundant with the "use beam shape cursor on startup" line
# # I'm removing this, but may be useful to have in future
# zle-line-init() {
#     zle -K viins
#     # ^select keymap ('zle -K <selected_keymap>'); starts us in <insert> mode
#     echo -ne "\e[5 q"
# }
# zle -N zle-line-init
# # ^create user-defined widget ('zle -N <func>')
