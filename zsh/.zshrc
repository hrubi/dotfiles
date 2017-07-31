# vim: sts=2 sw=2 et

# completion
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list ''
zstyle ':completion:*' menu select=5
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/hrubi/.zshrc'

autoload -Uz compinit
compinit


# history
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=1000


# shell options
# append to history list
setopt append_history
# append after shell exits
setopt no_inc_append_history
# exclusive history for each shell
setopt no_share_history
# brag on glob mismatch
setopt nomatch
# be explicit with 'cd' command
setopt no_autocd
# no beeps..
setopt no_beep
# wait for enter before reporting background jobs
setopt no_notify
# save directories to stack
setopt autopushd


# key bindings
# vim junkie
bindkey -v
# history browsing
bindkey -a "j" vi-down-line-or-history
bindkey -a "k" vi-up-line-or-history
bindkey -v "^[[B" down-line-or-history
bindkey -v "^[[A" up-line-or-history
# reverse and forward search
bindkey "^R" history-incremental-search-backward
bindkey "^T" history-incremental-search-forward
#home
bindkey "^[[7~" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[H"  beginning-of-line
bindkey "^[OH"  beginning-of-line
bindkey -a "^[[7~" beginning-of-line
bindkey -a "^[[1~" beginning-of-line
bindkey -a "^[[H"  beginning-of-line
bindkey -a "^[OH"  beginning-of-line
#end
bindkey "^[[8~" end-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[F"  end-of-line
bindkey "^[OF"  end-of-line
bindkey -a "^[[8~" end-of-line
bindkey -a "^[[4~" end-of-line
bindkey -a "^[[F"  end-of-line
bindkey -a "^[OF"  end-of-line
#delete
bindkey "^[[3~" vi-delete-char
bindkey -a "^[[3~" vi-delete-char
# foreground job
bindkey '^z' _hrubi_cli_fg

# put a job to foreground
function _hrubi_cli_fg () {
  if (( ${#jobstates} )); then
    zle .push-input
    [[ -o hist_ignore_space ]] && BUFFER=' ' || BUFFER=''
    BUFFER="${BUFFER}fg"
    zle .accept-line
  else
    zle -M 'No background jobs. Doing nothing.'
  fi
}
zle -N _hrubi_cli_fg


# prompt
# precmd - list jobs and get vcs info
function _hrubi_prompt_precmd () {
  setopt noxtrace noksharrays localoptions
  [[ -o interactive ]] && jobs -l
  vcs_info
}

function _hrubi_prompt_setup () {
  setopt prompt_subst

  # load and configure VCS
  autoload -Uz vcs_info
  zstyle ':vcs_info:*' actionformats \
    ' %F{magenta}(%f%s%F{magenta})%F{yellow}-%F{magenta}[%F{green}%b%F{yellow}|%F{red}%a%F{magenta}]%f '
  zstyle ':vcs_info:*' formats       \
    ' %F{magenta}(%f%s%F{magenta})%F{yellow}-%F{magenta}[%F{green}%b%F{magenta}]%f '
  zstyle ':vcs_info:*' enable git

  # set the prompt chunks
  local p_user='%n'
  local p_machine='%F{green}%m%f'
  local p_pwd='%~'
  local p_rc='%(?..%B%F{red}%?%f%b )'
  local p_vcs='${vcs_info_msg_0_}'
  local p_end='%# '

  # set the prompt itself
  prompt="
$p_rc$p_user@$p_machine $p_pwd$p_vcs
$p_end"

  autoload -Uz add-zsh-hook
  add-zsh-hook precmd _hrubi_prompt_precmd
}
_hrubi_prompt_setup


# aliases
[ -r ~/.alias ] && . ~/.alias


# Helpers
function sshrm () {
  if [ $# -ne 1 ];then
    echo "usage: sshrm line_number"
    return 1
  fi
  sed -i ${1}d ~/.ssh/known_hosts
}
