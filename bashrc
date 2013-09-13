if [ -e /etc/bash.bashrc ] ; then
	# Cygwin specific setting
	export CYGWIN=1

	# Msysgit's grep doesn't recognize --color
	alias grep='grep --color'
	alias gvim="/cygdrive/c/Program\ Files\ (x86)/Vim/vim74/gvim.exe"
else
	# Msysgit specific settings
	export CYGWIN=0

	alias gvim="/c/Program\ Files\ \(x86\)/Vim/vim74/gvim.exe"
fi
