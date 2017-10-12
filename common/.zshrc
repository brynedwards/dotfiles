# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
#REPORTTIME=10
setopt HIST_IGNORE_DUPS
setopt NO_CHECK_JOBS

setopt noflowcontrol
setopt prompt_subst
setopt append_history
setopt extended_history
setopt share_history
setopt longlistjobs
setopt nonomatch
setopt notify
setopt hash_list_all
setopt completeinword
setopt noshwordsplit
setopt interactivecomments
setopt extended_glob
setopt unset
setopt histignorealldups
setopt histignorespace
setopt auto_cd
setopt nohup
setopt noglobdots

bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/bryn/.zshrc'

autoload -U bashcompinit colors compinit
bashcompinit
colors
compinit

PROMPT='%F{blue}%~%f ❯ '

# End of lines added by compinstall
bindkey "^R" history-incremental-search-backward
bindkey "^F" history-incremental-search-forward

export EDITOR="kak"

alias mpvboth='mpv --no-audio-display --audio-pitch-correction=no --af=scaletempo=speed=both'
alias mpvpitch='mpv --no-audio-display --audio-pitch-correction=no --af=scaletempo=speed=pitch'
alias ra='ranger'
alias rmed='find . -type d -empty -delete'
alias tc='transmission-cli'
alias ytdl='youtube-dl'
alias -g L='| less'
alias -g LL='2>&1 | less'
alias -g C='"$(xsel -b)"'

# Always register with keychain
eval $(keychain --eval --agents ssh -Q -q id_rsa)

LADSPA_PATH=/usr/lib/ladspa:/usr/local/lib/ladspa:~/.ladspa
DSSI_PATH=/usr/lib/dssi:/usr/local/lib/dssi:~/.dssi

[[ -s ~/.zshrc.local ]] && source ~/.zshrc.local

source <(antibody init)
antibody bundle < $HOME/.local/share/antibody/plugins
source /usr/share/autojump/autojump.zsh

PATH=$HOME/.local/bin:$PATH
typeset -U path

# Stack completion
if command -v stack >/dev/null 2>&1; then
    eval "$(stack --bash-completion-script stack)"
fi
