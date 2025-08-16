if [[ $- == *i* ]]; then
  # Alt + up
  bind '"\e[1;3A":"cd ..\n"'
  # Alt + up
  bind '"\e[1;3B":"cd -\n"'
  # Alt + left
  bind '"\e[1;3D":"cd -\n"'
  # Alt + right
  bind '"\e[1;3C":"cd -\n"'
fi
