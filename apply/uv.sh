tools=(
    aicli
    #ansible
    gcalcli
    gsutil
    ipython
    nextmeeting
    ty
)

for tool in "${tools[@]}"; do
    uv tool install "$tool"
done
