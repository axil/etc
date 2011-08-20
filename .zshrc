HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
TERM=xterm
 
setopt interactivecomments
setopt globdots
unsetopt flowcontrol
 
# If interactive
if [ -n "$SSH_TTY" ]; then
  # Prompt
# PS1='\[\u@\h:\W\]% '
  PS1='%n@%m:%~%# '
  # Quote of the day
#  /usr/games/fortune |tee -a "/home/afti/1998/lev/fortune.txt"
#  /usr/games/fortune >> /home/afti/1998/lev/fortune.txt
    export PPT='/projects/phones/trunk'
    export PPS='/projects/phones/stable'
    export PFT='/projects/pybb/trunk'
    export PFS='/projects/pybb/stable'
    
    export VD='/var/django'
    export VDDS='/var/django/django-stable/'
    export VDDT='/var/django/django-trunk/'
    
    export VDPT='/var/django/phones-trunk'
    export VDPTT='/var/django/phones-tests'
    export VDPS='/var/django/phones-stable'
    export VDPQ='/var/django/phones-quotes'
    export VDPP='/var/django/phones-preview'
    export VDPK='/var/django/phones-piotr'
    export VDPM='/var/django/phones-merge'
    export VDPE='/var/django/phones-evandro'
    
    export HLPT='/home/lev/phones-trunk'
    export HLPS='/home/lev/phones-stable'
    export HLPTP='/home/lev/phones-trunk/phones'
    export HLFT='/home/lev/pybb-trunk'
    export SP='/usr/local/lib/python2.5/site-packages'

    export VDPR='/var/django/phones-redesign'
    export HLPR='/home/lev/phones-redesign'

    export HLPE='/home/lev/phones-editorspick'

    export VDPH='/var/django/phones-helen'
    export VDFH='/var/django/pybb-helen'

    export VDPA='/var/django/phones-artiom'
    export VDFA='/var/django/pybb-artiom'

    export VDPD='/var/django/phones-devel'
    export VDPI='/var/django/phones-istvan'

    export VDPF='/var/django/phones-future'
    export VDPL='/var/django/phones-lev'
    
    export VDFT='/var/django/pybb-trunk'
    export VDFS='/var/django/pybb-stable'
    export VDFL='/var/django/pybb-lev'
    export VDFE='/var/django/pybb-live'
    
    export HLFS='/home/lev/pybb-stable'

    export PP='/projects/phones.git'
fi

autoload -U compinit zmv
compinit

# Aliases
alias ls='ls -F --color=auto'
alias rm='rm -r'
alias vi='/usr/bin/vim'
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
alias log='less +F /var/log/django/phones-lev.log'

bindkey -e #because EDITOR contains vi
bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line
bindkey  delete-char
bindkey 'OA' history-beginning-search-backward
bindkey 'OB' history-beginning-search-forward
 
umask 002

export EDITOR=vim
#export PAGER=less
#if [[ -z "$STY" ]]; then
#    export PYTHONPATH=/usr/local/egg/lib/python2.5/site-packages/:$PYTHONPATH
#    export PATH=~/bin:/usr/local/egg/bin:$PATH
export WORKON_HOME=/var/envs
[[ -f /usr/local/bin/virtualenvwrapper.sh ]] && source /usr/local/bin/virtualenvwrapper.sh 
export PATH=~/bin:$PATH
#fi
export DJANGO_SETTINGS_MODULE='settings'
export LESS=FRSXi
stty stop undef

cdp () {
  cd "$(python -c "import os.path as _, ${1}; \
    print _.dirname(_.realpath(${1}.__file__[:-1]))"
  )"
}
