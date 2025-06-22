#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/Bashrc/Main.sh

alias clear='pwd=$(pwd); printf "\033[2J\033[3J\033[1;1H";. ~/Bashrc/Main.sh;cd $pwd'
alias ls='ls -l --color=auto'
alias grep='grep --color=auto'

ResetFG="$(printf "\e[39m")"
CyanFG="$(printf "\e[38;5;37m")"
PurpleFG="$(printf "\e[38;5;62m")"
BlueFG="$(printf "\e[38;5;32m")"

ResetBG="$(printf "\e[49m")"
CyanBG="$(printf "\e[48;5;37m")"
PurpleBG="$(printf "\e[48;5;62m")"
BlueBG="$(printf "\e[48;5;32m")"

PS1='\n\[$BlueFG\]🭢🭕\[$ResetFG$BlueBG\][$(date +%I:%M%p)]\[$CyanBG$BlueFG\]🭏🬼\[$ResetFG\]' # Time
PS1+='\u@\h\[$CyanFG$PurpleBG\]🭏🬼\[$ResetFG\]' # User
PS1+='\w\[$ResetBG$PurpleFG\]🭏🬼\[$ResetFG\] ' # working dir
PS0='\n' # insert new line before command output

# if we're using kitty turn the logo to transparent while a command is running
if [ "$(cat /proc/$PPID/comm)" == "kitty" ]; then
	PS0+='$(kitty @ set-window-logo --alpha .1 ~/.config/kitty/logo_busy.png &> /dev/null)' # before
	PROMPT_COMMAND='kitty @ set-window-logo --alpha .8 ~/.config/kitty/logo.png' # after
fi

# April first reminder
if [ "$(date | grep "Apr  1")" != "" ]; then
	PS0="$(printf "\n\e[38;5;172m[WARNING]:\e[0m Your \e[38;5;44mArch\e[38;5;37m™\e[0m activation key is no longer valid. Please activate your \e[38;5;44mArch\e[38;5;37m™\e[0m.")\n\n"
fi
