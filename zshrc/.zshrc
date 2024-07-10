# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# From: https://gist.github.com/3239248
source ~/powerlevel10k/powerlevel10k.zsh-theme

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
    alias t='ss.sh'
    alias la='ls -A'
    alias l='ls -CF'
    alias songs='ytfzf -t -m --detach --thumbnail-quality=medium'
    alias movies='lobster'
    alias animes='ani-cli'
    alias tt='z -ls | fzf'
    alias l='ls -CF'
    alias mpv='mpv --force-window'
    alias mouse='xinput set-prop 12 "Device Enabled" 0'
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
# function run_fzf() {
# 	fzf
# }
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

# vim mode
# vim mode config
# ---------------

# Activate vim mode.
bindkey -v

# Remove mode switching delay.
KEYTIMEOUT=5

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

# Use beam shape cursor on startup.
echo -ne '\e[5 q'

# Use beam shape cursor for each new prompt.
preexec() {
   echo -ne '\e[5 q'
}

setopt inc_append_history
setopt share_history
export HISTFILE=~/.zsh_history
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"
export BROWSER=firefox
export EDITOR=nvim
export HISTSIZE=10000000000
export HISTFILESIZE=100000000
export PATH=/home/soufiane/.config/bin:$PATH
export PATH


