#!/bin/bash
# <==============================================================>

#   ██████╗  ██████╗ ███████╗██╗██████╗  █████╗ ███████╗███████╗
#   ██╔══██╗██╔═══██╗██╔════╝██║██╔══██╗██╔══██╗██╔════╝██╔════╝
#   ██████╔╝██║   ██║█████╗  ██║██████╔╝███████║███████╗███████╗
#   ██╔══██╗██║   ██║██╔══╝  ██║██╔═══╝ ██╔══██║╚════██║╚════██║
#   ██║  ██║╚██████╔╝██║     ██║██║     ██║  ██║███████║███████║
#   ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝  ╚═╝╚══════╝╚══════╝

# <==============================================================>
#                      @Author: TheWisker
# <==============================================================>
#                Access pass passwords with rofi
# <==============================================================>
#  Ensure ** globs work recursively and don't fail if no matches
# <==============================================================>
shopt -s globstar nullglob
# <==============================================================>
#  Get password store prefix
# <==============================================================>
prefix=${PASSWORD_STORE_DIR-~/.password-store}
# <==============================================================>
#  Function for getting password entries
# <==============================================================>
get_entries() {
    # Get password files
    password_list=( "$prefix"/**/*.gpg )
    password_list=( "${password_list[@]#"$prefix"/}" )
    password_list=( "${password_list[@]%.gpg}" )
    # Set rofi's prompt and options
    echo -en "\0prompt\x1fpassword\n"
    echo -en "\0no-custom\x1ftrue\n"
    # Give rofi all entries
    for password in "${password_list[@]}"; do
        echo -en "${password}\0icon\x1fpass\n" # Set entry icons to pass's one
    done
}
# <==============================================================>
#  Function for getting the password in the clipboard
# <==============================================================>
get_pwd() {
    coproc ( toolbox run pass show -c "$1" > /dev/null 2>&1 )
}
# <==============================================================>
#  Match the state rofi is in when calling this script
# <==============================================================>
case "$ROFI_RETV" in
    0) get_entries;; # First call
    1) get_pwd "$1";; # Selection call
    *) exit 1;;
esac
# <==============================================================>
exit 0
# <==============================================================>
