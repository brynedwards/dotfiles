# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt HIST_IGNORE_DUPS
setopt NO_HUP
setopt NO_CHECK_JOBS
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/bryn/.zshrc'

autoload -Uz bashcompinit colors compinit
bashcompinit
colors
compinit
# End of lines added by compinstall
bindkey "^R" history-incremental-search-backward
bindkey "^F" history-incremental-search-backward

export EDITOR="kak"

alias aud='mpv --no-video "$(xsel -b)"'
alias dl='youtube-dl "$(xsel -b)"'
alias mpvboth='mpv --no-audio-display --audio-pitch-correction=no --af=scaletempo=speed=both'
alias mpvpitch='mpv --no-audio-display --audio-pitch-correction=no --af=scaletempo=speed=pitch'
alias rmed='find . -type d -empty -delete'
alias tc='transmission-cli "$(xsel -b)"'
alias vid='mpv "$(xsel -b)"'
alias mm='sudo mount nucky:/media $HOME/media'
alias umm='sudo umount $HOME/media'
alias -g L='| less'
alias -g LL='2>&1 | less'
alias -g C='"$(xsel -b)"'

# Always register with keychain
eval $(keychain --eval --agents ssh -Q -q id_rsa)

LADSPA_PATH=/usr/lib/ladspa:/usr/local/lib/ladspa:~/.ladspa
DSSI_PATH=/usr/lib/dssi:/usr/local/lib/dssi:~/.dssi

PS1="%{%F{010}%}\
%n\
%{%F{014}%}\
@\
%{%F{012}%}\
%m\
%{%F{011}%}\
 %~/\
%{$reset_color%}> "

[[ -s ~/.zshrc.local ]] && source ~/.zshrc.local

source /usr/share/zsh/scripts/zplug/init.zsh

# zplug "Valiev/almostontop"
zplug "Tarrasch/zsh-autoenv"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"

if ! zplug check; then
    zplug install
fi

zplug load
PATH=$(ruby -rubygems -e "puts Gem.user_dir")/bin:$HOME/.psvm/current/bin:$HOME/.local/bin:$PATH
typeset -U path

# TMUX
if which tmux >/dev/null 2>&1; then
    #if not inside a tmux session, and if no session is started, start a new session
    test -z "$TMUX" && (tmux attach || tmux new-session ranger)
fi
