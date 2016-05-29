# Note to self: `zgen reset` if you update this file

#https://outcoldman.com/en/archive/2015/09/13/keep-your-sh-together/

#https://github.com/jleclanche/dotfiles/blob/master/.zshrc

DOTFILES=$HOME/dotfiles
# Update PATH
path=(
    /usr/local/{bin,sbin}
    $DOTFILES/scripts
    $path
)
typeset -U path

# change the size of history files
export HISTSIZE=32768;
export HISTFILESIZE=$HISTSIZE;
# Shell
export CLICOLOR=1
export EDITOR='vim'
export PAGER='less'

# if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"


# Powerlevel9k is the best theme for prompt, I like to keep it in dark gray colors
#DEFAULT_USER=outcoldman
# POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status history time)
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
# POWERLEVEL9K_DIR_BACKGROUND='238'
# POWERLEVEL9K_DIR_FOREGROUND='252'
# POWERLEVEL9K_STATUS_BACKGROUND='238'
# POWERLEVEL9K_STATUS_FOREGROUND='252'
# POWERLEVEL9K_CONTEXT_BACKGROUND='240'
# POWERLEVEL9K_CONTEXT_FOREGROUND='252'
# POWERLEVEL9K_TIME_BACKGROUND='238'
# POWERLEVEL9K_TIME_FOREGROUND='252'
# POWERLEVEL9K_HISTORY_BACKGROUND='240'
# POWERLEVEL9K_HISTORY_FOREGROUND='252'


# dumb terminal can be a vim dump terminal in that case don't try to load plugins
if [ ! $TERM = dumb ]; then
    ZGEN_AUTOLOAD_COMPINIT=true
    # If user is root it can have some issues with access to competition files
    if [[ "${USER}" == "root" ]]; then
        ZGEN_AUTOLOAD_COMPINIT=false
    fi
    # load zgen
    source $DOTFILES/zgen/zgen.zsh
    # configure zgen
    if ! zgen saved; then
        # zgen will load oh-my-zsh and download it if required
        zgen oh-my-zsh
        zgen oh-my-zsh plugins/git
        zgen oh-my-zsh plugins/git-extras
        zgen oh-my-zsh plugins/gitignore
        zgen oh-my-zsh plugins/pip
        zgen oh-my-zsh plugins/python
        zgen oh-my-zsh plugins/sudo
        zgen oh-my-zsh plugins/tmuxinator
        # https://github.com/Tarrasch/zsh-autoenv
        zgen load Tarrasch/zsh-autoenv
        # https://github.com/zsh-users/zsh-completions
        zgen load zsh-users/zsh-completions src

        #https://github.com/unixorn/awesome-zsh-plugins
        # load https://github.com/bhilburn/powerlevel9k theme for zsh
        # zgen load bhilburn/powerlevel9k powerlevel9k.zsh-theme
        # zgen load InAnimaTe/darkblood-modular darkblood-modular.zsh-theme
        # zgen load martnu/glimmer glimmer.zsh-theme
        # zgen load caiogondim/bullet-train-oh-my-zsh-theme bullet-train.zsh-theme
        # zgen load tweekmonster/nanofish nanofish.zsh-theme
        zgen load fdv/platypus platypus.zsh-theme
        zgen save
    fi
    # Configure vundle
    # vundle-init
fi

# additional configuration for zsh
# Remove the history (fc -l) command from the history list when invoked.
setopt histnostore
# Remove superfluous blanks from each command line being added to the history list.
setopt histreduceblanks
# Do not exit on end-of-file. Require the use of exit or logout instead.
setopt ignoreeof
# Print the exit value of programs with non-zero exit status.
setopt printexitvalue
# Do not share history
setopt no_share_history

# virtualenv
VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3.4
export VIRTUALENVWRAPPER_PYTHON
export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

alias fuck='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'

# print a separator banner, as wide as the terminal
function hr {
	print ${(l:COLUMNS::=:)}
}

# get public ip
function myip {
	local api
	case "$1" in
		"-4")
			api="http://v4.ipv6-test.com/api/myip.php"
			;;
		"-6")
			api="http://v6.ipv6-test.com/api/myip.php"
			;;
		*)
			api="http://ipv6-test.com/api/myip.php"
			;;
	esac
	curl -s "$api"
	echo # Newline.
}


# The next line updates PATH for the Google Cloud SDK.
source '/home/aahu/google-cloud-sdk/path.zsh.inc'
# The next line enables shell command completion for gcloud.
source '/home/aahu/google-cloud-sdk/completion.zsh.inc'
