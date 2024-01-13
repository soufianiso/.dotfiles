# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# From: https://gist.github.com/3239248
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/src/powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# enable color support of ls and also add handy aliases
  if [ -x /usr/bin/dircolors ]; then
      test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
      alias ls='ls --color=auto'
      alias dir='dir --color=auto'
      alias cat='bat'
      alias vdir='vdir --color=auto'
      alias grep='grep --color=auto'
      alias fgrep='fgrep --color=auto'
      alias egrep='egrep --color=auto'
	  alias f='cd $( ls -d */| fzf )'
  fi
  eval $(thefuck --alias)
# some more ls aliases
    alias ll='ls -alF'
    alias v='nvim'
    alias t='tmux-s'
    alias la='ls -A'
    alias l='ls -CF'
    alias tt='z -ls | fzf'
    alias l='ls -CF'
    alias mouse='xinput set-prop 12 "Device Enabled" 0'
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
# function run_fzf() {
# 	fzf
# }
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
setopt inc_append_history
setopt share_history
export HISTFILE=~/.zsh_history
export BROWSER=w3m
export HISTSIZE=10000000000
export HISTFILESIZE=100000000
export PATH=/home/soufiane/.config/bin:$PATH
export PATH

