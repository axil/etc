export VDC='/var/sites/cityguides'
export VDCL='/var/sites/cityguides-lev'
export VDCE='/var/sites/cityguides-estrella'
export VDCP='/var/sites/cityguides-ppn'
export HPC='/home/piotr/cityguides'


HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
TERM=xterm
#export PIP_USER=1
export LC_ALL=en_GB.utf8
 
setopt interactivecomments
setopt globdots
unsetopt flowcontrol
 
# If interactive
if [ -n "$SSH_TTY" ]; then
  # Prompt
#   PS1='\[\u@\h:\W\]% '
    PS1='%n@%m:%~%# '
  # Quote of the day
#  /usr/games/fortune |tee -a "/home/afti/1998/lev/fortune.txt"
#  /usr/games/fortune >> /home/afti/1998/lev/fortune.txt
    export VDPT='/var/django/phones-trunk'
    export VDPL='/var/django/phones-lev'
    export VDCT='/var/django/cheese-trunk'
    export VSD='/var/sites/domains'
fi

autoload -U compinit zmv
compinit

# Aliases
alias ls='ls -F --color=auto'
alias rm='rm -r'
alias vi='/usr/bin/vim'
alias vis='sudo -E /usr/bin/vim'
alias bc='bc -l -q'
alias phgrep='grep --include="*.html" --include="*.py" --exclude-dir=.git'
alias pgrep='grep --include="*.py"'
alias hgrep='grep --include="*.html"'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias mmv='noglob zmv -W'
alias zcp='zmv -C'
alias zln='zmv -L'
alias pfm='git ls-files -m |xargs pyflakes'
#alias mysudo='sudo PYTHONPATH=$PYTHONPATH'
alias ack='ack --pager="less -r"'
alias ll='ls -l'
alias se='sudoedit'
alias msq='./manage.py sqlevolve catalogue |grep ADD |grep -v _tmp'
alias a='source env/bin/activate'
alias d='deactivate'
alias pack='ack --type="python"'

bindkey -e #because EDITOR contains vi
bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line
bindkey  backward-delete-char
bindkey 'OA' history-beginning-search-backward
bindkey 'OB' history-beginning-search-forward
bindkey '[D' backward-word  #[D
bindkey '[C' forward-word   #[C
 
umask 002

export EDITOR=vim
#export PAGER=less
#if [[ -z "$STY" ]]; then
#    export PYTHONPATH=/usr/local/egg/lib/python2.5/site-packages/:$PYTHONPATH
#    export PATH=~/bin:/usr/local/egg/bin:$PATH
export WORKON_HOME=~/.virtualenvs
[[ -f /usr/local/bin/virtualenvwrapper.sh ]] && source /usr/local/bin/virtualenvwrapper.sh 
export PATH=~/bin:~/.local/bin/:$PATH
#fi
export DJANGO_SETTINGS_MODULE='settings'
export LESS=FRSXi
stty stop undef

cdp () {
  cd "$(python -c "import os.path as _, ${1}; \
    print _.dirname(_.realpath(${1}.__file__[:-1]))"
  )"
}
