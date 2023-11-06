#!/usr/bin/env bash
#-------------------------------------------------------------------------------
# Term
#-------------------------------------------------------------------------------

	red=$(tput setaf 1)
	green=$(tput setaf 2)
	blue=$(tput setaf 12)
	orange=$(tput setaf 214)
	white=$(tput setaf 248)
	white2=$(tput setaf 15)
	x=$(tput sgr0)
	eol="$(tput el)"
	bld="$(tput bold)"
	line="##---------------$nl"
	tab=$'\t'
	nl=$'\n'
	delta="${orange}\xE2\x96\xB3"
	pass="${green}\xE2\x9C\x93"
	fail="${red}\xE2\x9C\x97"
	lambda="\xCE\xBB"

#-------------------------------------------------------------------------------
# Utils
#-------------------------------------------------------------------------------

	function __printf(){
		local text color prefix
		text=${1:-}; color=${2:-white2}; prefix=${!3:-};
		[ $opt_quiet -eq 1 ] && [ -n "$text" ] && printf "${prefix}${!color}%b${x}" "${text}" 1>&2 || :
	}

	function confirm(){
		local ret;ret=1
		__printf "${1}? > " "white2" #:-Are you sure ?
		[ $opt_yes -eq 0 ] && __printf "${bld}${green}auto yes${x}\n" && return 0;
		[[ -f ${BASH_SOURCE} ]] && src='/dev/stdin' || src='/dev/tty'

		while read -r -n 1 -s answer < $src; do
			[ $? -eq 1 ] && exit 1;
			if [[ $answer = [YyNn10tf+\-q] ]]; then
				[[ $answer = [Yyt1+] ]] && __printf "${bld}${green}yes${x}" && ret=0 || :
				[[ $answer = [Nnf0\-] ]] && __printf "${bld}${red}no${x}" && ret=1 || :
				[[ $answer = [q] ]] && __printf "\n" && exit 1 || :
				break
			fi
		done
		__printf "\n"
		return $ret
	}

	function __sleep(){
		[ $opt_yes -eq 1 ] && sleep 1 || :
	}

	function error(){ local text=${1:-}; __printf " $text\n" "fail"; }
	function warn(){ local text=${1:-}; __printf " $text$x\n" "delta";  }
	function info(){ local text=${1:-}; [ $opt_debug -eq 0 ] && __printf "$lambda $text\n" "blue"; }
	function does(){ local text=${1:-}; [ $opt_debug -eq 0 ] && __printf "$delta $text\n" "white2"; }

	function die(){ __printf "\n$fail $1 "; exit 1; }
