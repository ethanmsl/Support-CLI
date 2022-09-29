#!/bin/zsh


# ########################### --ViMode Set-Up ####################### #

bindkey -v  # set vi-mode
bindkey -v '^?' backward-delete-char  # enable typical backspace in insert mode
export KEYTIMEOUT=1  # set wait time for possible multi-char sequences to 
                     # 1/100th of a second (0.01 seconds == 10ms)
                     # increases responsiveness when using escape to switch to
                     # <normal> mode


# ########################### --ViMode Cursor Shape-- ####################### #

# ----------- Cursor-Change with Mode-Change -----------
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


# ----------- Cursor+Mode Change with NewLine -----------
# this script starts us in <insert> mode AND sets cursor to blink-beam
# and fires on every new line
zle-line-init() {
    zle -K viins
    # ^select keymap ('zle -K <selected_keymap>'); starts us in <insert> mode
    echo -ne "\e[5 q"
}
zle -N zle-line-init
# ^create user-defined widget ('zle -N <func>')


# ----------- Cursor-Change with Terminal -----------
# Use beam shape cursor on startup
echo -ne '\e[5 q'


########### back-pocket function ###########
# INFO: as far as I can tell this behavior is reundant, 
#       but weaker, than zle-line-init()'s
#       Commenting out, but leaving for possible future use.
#
# # ----------- Cursor-Change before Command-Processing -----------
# # 'preexec()': executed right before entered command is
# #  so it should effectively set the cursor shape for the next line
# # (useful when a command is entered in <normal> mode,
# #  to prevent inheriting the block-cursor shape)
# #  NOTE: does NOT fire if no command (neither "good" nor "bad") is entered
# #        so '[enter]' on a blank line in <normal> mode will not fire preexec()
# preexec() { echo -ne '\e[5 q' ;}
