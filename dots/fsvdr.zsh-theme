###############################################################################
# FSVDR ZSH THEME                                                            #
###############################################################################
# Custom Oh My Zsh theme — ported from the bash prompt

# Map of git author emails to user prompt labels
typeset -A USERROLES
USERROLES=(
  '<email>' '<prompt>'
)

# Get user role prompt for the current directory
user-prompt() {
  local userrole=" $(whoami)"
  local email
  email=$(gae)

  if [[ -n "$email" ]]; then
    for key in ${(k)USERROLES}; do
      if [[ "$key" == "$email" ]]; then
        userrole="${USERROLES[$key]}"
      fi
    done
  fi

  echo "$userrole"
}

# Git prompt configuration
ZSH_THEME_GIT_PROMPT_PREFIX=" %B%F{red}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f%b"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Primary prompt
PROMPT='%B%F{black} $(user-prompt)%f%b'
PROMPT+=' %B%F{white}[%U%F{white}%1~%u%f%F{white}]%f%b'
PROMPT+='$(git_prompt_info)'
PROMPT+='  👉  '

# Secondary prompt
PROMPT2=' 💬  '
