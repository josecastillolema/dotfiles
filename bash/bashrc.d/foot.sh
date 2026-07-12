# shellcheck shell=bash
# Emit OSC 7 (current working directory) for the foot terminal.
# Enables foot's spawn-terminal to open new terminals in the same directory.

if [[ $- != *i* ]]; then
  return 0
fi

if [[ "$(</proc/$PPID/comm)" != "foot" ]] 2>/dev/null; then
  return 0
fi

__foot_osc7() {
  printf '\e]7;file://%s%s\e\\' "${HOSTNAME}" "${PWD}"
}

PROMPT_COMMAND="${PROMPT_COMMAND:+${PROMPT_COMMAND};} __foot_osc7"
