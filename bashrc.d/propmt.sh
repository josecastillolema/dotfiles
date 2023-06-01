shopt -s cdspell    # corrects cd mispells
shopt -s nocaseglob # case insensitive ls
# corrects mispell with tab-completion
shopt -s dirspell
#shopt -s direxpand # will improve tab-autocompletion in bash 4.3, retest then
# completion for alias
# it does not work https://github.com/scop/bash-completion/issues/383
#shopt -s progcomp_alias

eval "$(starship init bash)"

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
