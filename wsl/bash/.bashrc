# 対話シェルのみ
case $- in
  *i*) ;;
  *) return ;;
esac

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend checkwinsize

# プロンプトとカラー表示
case "$TERM" in
  xterm-color|*-256color)
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
  *) PS1='\u@\h:\w\$ ' ;;
esac
case "$TERM" in
  xterm*|rxvt*) PS1="\[\e]0;\u@\h: \w\a\]$PS1" ;;
esac

if command -v dircolors >/dev/null 2>&1; then
  if [ -r "$HOME/.dircolors" ]; then
    eval "$(dircolors -b "$HOME/.dircolors")"
  else
    eval "$(dircolors -b)"
  fi
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
fi
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
[ ! -f "$HOME/.bash_aliases" ] || source "$HOME/.bash_aliases"

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi

# WezTerm に作業ディレクトリを通知する。
__wezterm_osc7() {
  printf "\e]7;file://%s%s\e\\" "${HOSTNAME}" "${PWD}"
}
if [[ ! " ${PROMPT_COMMAND[*]-} " =~ __wezterm_osc7 ]]; then
  PROMPT_COMMAND+=(__wezterm_osc7)
fi

export PATH="$HOME/.local/bin:$HOME/.local/share/fnm:$HOME/.pyenv/bin:$PATH"
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd)"
fi
if command -v pyenv >/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  eval "$(pyenv init -)"
fi
if [ -d "$HOME/.local/go/bin" ]; then
  export PATH="$HOME/.local/go/bin:$PATH"
fi
if command -v go >/dev/null 2>&1; then
  export PATH="$PATH:$(go env GOPATH)/bin"
fi
