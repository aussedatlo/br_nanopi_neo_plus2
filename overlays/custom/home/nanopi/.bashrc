###### PROMPT ######
if [ "$UID" -ge 500 ] ; then 
        PS1="\# \[\e[0;36m\][\t]\[\e[0;m\] \[\e[0;32m\]\u@\h\[\e[0;m\]: \[\e[1;35m\]\w\[\e[0;m\] \[\e[1;32m\] \\$\[\e[0;m\] " 
fi
if [ "$UID" -eq 0 ] ; then
        PS1="\# \[\e[0;36m\][\t]\[\e[0;m\] \[\e[0;31m\]\u@\h\[\e[0;m\]: \[\e[1;35m\]\w\[\e[0;m\] \[\e[1;31m\] \\$\[\e[0;m\] "
fi
###### ALIASES ######
alias ls="ls --color"
alias grep="grep --color"
alias ll="ls -la"