###############################################################################
# FSVDR ZSH THEME                                                            #
###############################################################################
# Custom Oh My Zsh theme — ported from the bash prompt

# Git prompt configuration
ZSH_THEME_GIT_PROMPT_PREFIX=" %B%F{red}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f%b"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Primary prompt
PROMPT='%B%F{white}[%U%F{white}%1~%u%f%F{white}]%f%b'
PROMPT+='$(git_prompt_info)'
PROMPT+='  '

# Secondary prompt
PROMPT2=' 💬  '
