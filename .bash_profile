export HISTCONTROL=ignoreboth
export HISTSIZE=40000
#-------------------
# Personnal Aliases
#-------------------

[ $(uname -s | grep -c CYGWIN) -eq 1 ] && OS_NAME="CYGWIN" || OS_NAME=`uname -s`
#git
# Git alias
alias gg="git status --short -b"
alias ga="git add"
alias gau="git add -u"
alias gc="git commit -m"
alias gca="git commit -am"
alias gja="git --no-pager commit --amend --reuse-message=HEAD" # git just amend
alias gb="git branch"
alias gnb="git checkout -b"
alias gtt="git stash"
alias gta="git stash apply"
alias gmt="git mergetool"
alias gl="git log --oneline --decorate --graph"
alias glp="git log --date=short --decorate --graph --pretty=format:'%C(yellow)%h%Creset%C(green)%d%Creset %ad %s %Cred(%an)%Creset' -p"
alias gs="git show"
alias gss="git show --stat"
alias gd="git diff"
alias gds="git diff --stat"
alias gdc="git diff --cached"
alias gdcs="git diff --cached --stat"
alias gps="git push"
alias gpf="git push --force"
alias gpr="git pull -r"
alias cg='cd $(git rev-parse --show-toplevel)' #goto root dir
alias grh='git reset --hard HEAD'
alias gr1='git reset --hard HEAD^'
alias gr2='git reset --hard HEAD^^'

# sort and count lines,
#@see http://felipec.wordpress.com/2011/06/02/command-history-meme/
#alias cntl=awk '{a[$1]++} END{for(i in a){printf "%5d\t%s\n",a[i],i}}'|sort -rn
alias rbt='reboot'
alias bye='shutdown -h now'
#Example: rsync -avz --delete /home/username/ /media/disk/backup
alias bkrsync="rsync -avz --delete"
#grep and its alternatives
#@see http://stackoverflow.com/questions/221921/grep-exclude-include- \
#syntax-do-not-grep-through-certain-files
alias rd='rdesktop -fP'
alias w3m='w3m -cookie '
alias rm='rm '
alias cp='cp '
alias mv='mv '
# -> Prevents accidentally clobbering files.
alias mkdir='mkdir -p'
#I need clip between firefox
alias j='jobs -l'
alias r='rlogin'
alias which='type -all'
alias path='echo -e ${PATH//:/\\n}'
alias print='/usr/bin/lp -o nobanner -d $LPDEST'
alias background='xv -root -quit -max -rmode 5'
# Put a picture in the background
alias du='du -kh'
alias wget='wget -c'

function grepcmd () {
    grep -rsnI --exclude='archive-contents' --exclude='*.log' --exclude='*.properties' --exclude='TAGS' --exclude=tags --exclude=GTAGS --exclude-dir=.svn --exclude-dir=bower_components --exclude-dir=node_modules --exclude-dir=dist --exclude-dir=.sass-cache --exclude-dir=.cache  --exclude-dir=.cvs --exclude-dir=.git --exclude-dir=test --exclude-dir=tests --exclude-dir=.hg --exclude-dir=.metadata --exclude-dir=logs --exclude='#*#' --exclude='*.swp' --exclude='*.min.js' --exclude='*.min.css' --exclude='*~' --color=auto "$@"
}
alias a=grepcmd

function e()
{
    if [ "$TERM" = "linux" ]; then
        emacs -nw "$@"
    else
        TERM=xterm-256color emacs -nw "$@"
    fi
}

alias df='df -kTh'
# The 'ls' family (this assumes you use the GNU ls)
alias la='ls -Al'               # show hidden files
alias ls='ls --show-control-chars --color=auto -hF'
alias lx='ls -lXB'              # sort by extension
alias lk='ls -lSr'              # sort by size
alias lc='ls -lcr'		# sort by change time
alias lu='ls -lur'		# sort by access time
alias lr='ls -lR'               # recursive ls
alias lt='ls -ltr'              # sort by date
alias lm='ls -al |more'         # pipe through 'more'
function ll()
{ ls -l "$@"| egrep "^d" ; ls -lXB "$@" 2>&-| egrep -v "^d|total "; }
alias tree='tree -Csu'		# nice alternative to 'ls'

function m () {
  $* --help | less
}

function mk() {
    if [ "$OS_NAME" = "Darwin" ]; then
        make -j$(sysctl -n hw.ncpu)
    else
        make -j$(nproc)
    fi
}

#@see http://stackoverflow.com/questions/3746/whats-in-your-bashrc
alias cd..="cd .."
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

#gcc
alias objdump='objdump -d -S -hrt'

# tailoring 'less'
#alias more='less'
#export PAGER=less
#export LESSCHARSET='latin1'
#export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-'
# Use this if lesspipe.sh exists.
#export LESS='-i -N -w  -z-4 -g -e -M -X -F -R -P%t?f%f \
#:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'

shopt -s extglob        # necessary
set +o nounset          # otherwise some completions will fail

complete -A hostname   rsh rcp telnet rlogin r ftp ping disk
complete -A export     printenv
complete -A variable   export local readonly unset
complete -A enabled    builtin
complete -A alias      alias unalias
complete -A function   function
complete -A user       su mail finger
complete -A helptopic  help     # currently same as builtins
complete -A shopt      shopt
complete -A stopped -P '%' bg
complete -A job -P '%'     fg jobs disown
complete -A directory  mkdir rmdir
complete -A directory   -o default cd

# Compression
complete -f -o default -X '*.+(zip|ZIP)'  zip
complete -f -o default -X '!*.+(zip|ZIP)' unzip
complete -f -o default -X '*.+(z|Z)'      compress
complete -f -o default -X '!*.+(z|Z)'     uncompress
complete -f -o default -X '*.+(gz|GZ)'    gzip
complete -f -o default -X '!*.+(gz|GZ)'   gunzip
complete -f -o default -X '*.+(bz2|BZ2)'  bzip2
complete -f -o default -X '!*.+(bz2|BZ2)' bunzip2
# Postscript,pdf,dvi.....
complete -f -o default -X '!*.ps'  gs ghostview ps2pdf ps2ascii
complete -f -o default -X '!*.dvi' dvips dvipdf xdvi dviselect dvitype
complete -f -o default -X '!*.pdf' acroread pdf2ps zathura
complete -f -o default -X '!*.+(pdf|ps)' gv
complete -f -o default -X '!*.texi*' makeinfo texi2dvi texi2html texi2pdf
complete -f -o default -X '!*.tex' tex latex slitex
complete -f -o default -X '!*.lyx' lyx
complete -f -o default -X '!*.+(htm*|HTM*)' lynx html2ps w3m
# Multimedia
complete -f -o default -X '!*.+(jp*g|gif|xpm|png|bmp)' xv gimp
complete -f -o default -X '!*.+(mp3|MP3)' mpg123 mpg321
complete -f -o default -X '!*.+(ogg|OGG)' ogg123
complete -f -o default -X '!*.pl'  perl perl5

# This is a 'universal' completion function - it works when commands have
# a so-called 'long options' mode , ie: 'ls --all' instead of 'ls -a'

_get_longopts ()
{
	$1 --help | sed  -e '/--/!d' -e 's/.*--\([^[:space:].,]*\).*/--\1/'| \
	grep ^"$2" |sort -u ;
}

_longopts_func ()
{
	case "${2:-*}" in
		-*)	;;
		*)	return ;;
	esac

	case "$1" in
		\~*)	 eval cmd="$1" ;;
		*)	 cmd="$1" ;;
	esac
	COMPREPLY=( $(_get_longopts ${1} ${2} ) )
}
complete  -o default -F _longopts_func configure bash
complete  -o default -F _longopts_func wget id info a2ps ls recode

# A meta-command completion function for commands like sudo(8), which
# need to first complete on a command,
# then complete according to that command's own
# completion definition - currently not quite foolproof
# (e.g. mount and umount don't work properly),
# but still quite useful --
# By Ian McDonald, modified by me.
_my_command()
{
	local cur func cline cspec

	COMPREPLY=()
	cur=${COMP_WORDS[COMP_CWORD]}

	if [ $COMP_CWORD = 1 ]; then
		COMPREPLY=( $( compgen -c $cur ) )
	elif complete -p ${COMP_WORDS[1]} &>/dev/null; then
		cspec=$( complete -p ${COMP_WORDS[1]} )
		if [ "${cspec%%-F *}" != "${cspec}" ]; then
			# complete -F <function>
			#
			# COMP_CWORD and COMP_WORDS() are not read-only,
			# so we can set them before handing off to regular
			# completion routine

			# set current token number to 1 less than now
			COMP_CWORD=$(( $COMP_CWORD - 1 ))
			# get function name
			func=${cspec#*-F }
			func=${func%% *}
			# get current command line minus initial command
			cline="${COMP_LINE#$1 }"
			# split current command line tokens into array
			COMP_WORDS=( $cline )
			$func $cline
		elif [ "${cspec#*-[abcdefgjkvu]}" != "" ]; then
			# complete -[abcdefgjkvu]
			#func=$( echo $cspec | sed -e 's/^.*\(-[abcdefgjkvu]\).*$/\1/' )
			func=$( echo $cspec | sed -e 's/^complete//' -e 's/[^ ]*$//' )
			COMPREPLY=( $( eval compgen $func $cur ) )
		elif [ "${cspec#*-A}" != "$cspec" ]; then
			# complete -A <type>
			func=${cspec#*-A }
			func=${func%% *}
			COMPREPLY=( $( compgen -A $func $cur ) )
		fi
	else
		COMPREPLY=( $( compgen -f $cur ) )
	fi
}

#mkdir, cd into it
mkcd () {
  mkdir -p "$*"
  cd "$*"
}

complete -o default -F _my_command nohup exec eval \
  trace truss strace sotruss gdb
complete -o default -F _my_command command type which man nice

# xclip has some problem with my emacs, so I use xsel for everything
alias gclip="xclip -o"
alias pclip="xclip -selection c"
