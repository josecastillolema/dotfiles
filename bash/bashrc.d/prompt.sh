shopt -s autocd # auto cd if only the directory name is given
shopt -s cdspell    # corrects cd mispells
shopt -s checkhash # Check the hash table for a command name before searching $PATH.
shopt -s checkwinsize # check windows size if windows is resized
shopt -s cmdhist    # save multi line commands as one command
shopt -s dirspell   # corrects mispell with tab-completion
shopt -s dotglob # include .files when globbing.
shopt -s expand_aliases # enable alias expansion in non-interactive mode (claude)
shopt -s extglob # use extra globing features. See man bash, search extglob
shopt -s globstar # Enable `**` pattern in filename expansion to match all files,
shopt -s histappend # append to history, don't overwrite it
shopt -s lithist # Save multi-line commands to the history with embedded newlines
shopt -s nocaseglob # case insensitive ls

show_newline() {
  if [ -z "$NEW_LINE_BEFORE_PROMPT" ]; then
    NEW_LINE_BEFORE_PROMPT=1
  elif [ "$NEW_LINE_BEFORE_PROMPT" -eq 1 ]; then
    echo ""
  fi
}
PROMPT_COMMAND="show_newline"
eval "$(starship init bash)"

#eval `ssh-agent -s` > /dev/null

# TODO: time of previous command
# RED="31"
# GREEN="\e[32m"
# BLUE="\e[34m"
# CYAN="\e[36m"
# BROWN="\e[33m"
# BOLDGREEN="\e[1;${GREEN}m"
# ITALICRED="\e[3;${RED}m"
# ENDCOLOR="\e[0m"

# parse_git_branch() {
#     echo -e "$BROWN$(parse_git_branch2)$ENDCOLOR"
# }

# parse_git_branch2() {
#     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
# }

# function is_toolbox() {
#     if [ -f "/run/.toolboxenv" ]
#     then
#         if [[ $name = "fedora-toolbox-38" ]]; then
#            echo -e "$BLUE⬢ $ENDCOLOR"
#         else
#            echo -e "$CYAN⬢ $ENDCOLOR"
#         fi
#     fi
# }

#PS1='\n\e[34m\]\w \[\e[0;$(($?==0?0:91))m\]❯ \[\e[0m\]$(is_toolbox)$(parse_git_branch)'
