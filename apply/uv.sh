tools=(
    #ansible
    gcalcli
    ipython
    nextmeeting
    ty
)

for tool in "${tools[@]}"; do
    uv tool install "$tool"
done
