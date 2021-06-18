# Command history tweaks:
# - Append history instead of overwriting
#   when shell exits.
# - When using history substitution, do not
#   exec command immediately.
# - Do not save to history commands starting
#   with space.
# - Do not save duplicated commands.
shopt -s histappend
shopt -s histverify
export HISTCONTROL=ignoreboth

# Custom command line prompt.
PS1="\[\033[1;37m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[1;31m\]X\[\033[1;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;37m\]'; else echo '\[\033[1;32m\]\u\[\033[01;33m\]'; fi)\[\033[1;37m\]]\342\224\200\[\033[1;31m\][\[\033[1;36m\]\w\[\033[1;31m\]]\n\[\033[1;37m\]\342\224\224\342\224\200\342\224\200\[\033[0m\]\[\e[01;33m\]>\[\e[0m\]"

#fix prompt after "cat" command
shopt -s promptvars
PS1='$(printf "%$((COLUMNS-1))s\r")'$PS1

# Handles nonexistent commands.
# If user has entered command which invokes non-available
# utility, command-not-found will give a package suggestions.

if [ -x /data/data/com.termux/files/usr/libexec/termux/command-not-found ]; then
        command_not_found_handle() {
                /data/data/com.termux/files/usr/libexec/termux/command-not-found "$1"
        }
fi


# enable bash completion:
if ! shopt -oq posix; then
  if [ -f $PREFIX/share/bash-completion/bash_completion ]; then
    . $PREFIX/share/bash-completion/bash_completion
  elif [ -f $PREFIX/etc/bash_completion ]; then
    . $PREFIX/etc/bash_completion
  fi
fi

#dircolors:
if [ -f $PREFIX/etc/dircolors ]; then
    . $PREFIX/etc/dircolors
fi


touch $PREFIX/etc/motd
printf "\n  Welcome to Termux v$TERMUX_VERSION ! \n\n"> $PREFIX/etc/motd
