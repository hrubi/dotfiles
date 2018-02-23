# vim: sts=2 sw=2 et

# differentiate based on hostname or nodetype
typeset -A nodetype_map
nodetype_map=(
  dundee   desktop
  kvm-fbsd vps
)
export hostname_s=$(hostname -s)
export nodetype=${nodetype_map[$hostname_s]}

export MANWIDTH=80

if [[ $nodetype == desktop ]]; then

  # set the PATH
  typeset -U path
  path=(
    $HOME/projects/hrubitools
    $HOME/bin
    $HOME/apps/bin
    $HOME/.gem/ruby/2.2.0/bin
    $path
    /usr/local/sbin
    /usr/sbin
    /sbin
  )
  export PATH


  # locales
  export LANG="en_US.utf8"
  export LC_CTYPE="cs_CZ.utf8"
  export LC_TIME="cs_CZ.utf8"
  export LC_COLLATE="cs_CZ.utf8"
  export LC_MONETARY="cs_CZ.utf8"


  # environment
  export EDITOR="vim"
  export PROJECTS="$HOME/projects"
  export PROJECTS_GD="$PROJECTS/gooddata"
  export KRB5_CONFIG="$HOME/.krb5.conf"
  export MANPATH="$HOME/apps/share/man:$MANPATH"
  export LESS='-iRX'
  export SOLARIZED="true" # for 'eix'
  export GPGKEY="0x640E836E"


  # keychain
  eval `keychain --nogui --agents gpg,ssh --eval priv/id_rsa gooddata/id_rsa 2>/dev/null`


  # start X
  if [[ ! "$DISPLAY" && "$XDG_VTNR" == 1 || x`tty` == x/dev/tty1  ]]; then
    exec startx > "$HOME/.xsession-errors" 2>&1
  fi

fi
