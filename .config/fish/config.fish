if status --is-interactive
    if not set -q DISPLAY; and [ (tty) = "/dev/tty1" ]
        startx
    end
end

### ADDING TO THE PATH
# First line removes the path; second line sets it.  Without the first line,
# your path gets massive and fish becomes very slow.
set -e fish_user_paths
set -U fish_user_paths $HOME/.bin  $HOME/.local/bin $HOME/Applications /var/lib/flatpak/exports/bin/ $fish_user_paths $HOME/.cargo/bin

### EXPORT ###
set fish_greeting
set TERM "xterm-256color"

### Setting manpager to nvim ###
set -x MANPAGER "nvim +Man!"

set -gx EDITOR (which nvim)
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR
set BROWSER "firefox"
set TERMINAL "st"

### SET EITHER DEFAULT EMACS MODE OR VI MODE ###
function fish_user_key_bindings
  # fish_default_key_bindings
  fish_vi_key_bindings
end
### END OF VI MODE ###

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

# Functions needed for !! and !$
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

# The bindings for !! and !$
if [ "$fish_key_bindings" = "fish_vi_key_bindings" ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# function to use fzf to start a tmux session
function __tmux-sessionizer
    tmux-session
end

bind -Minsert \cf __tmux-sessionizer

### TODO: Add fuctions to start these keybindings ###
# bind \cs '$EDITOR (fzf-tmux)\n'
# bind \ct 'if test -f TODO.md; $EDITOR TODO.md; else; notes todo; end\n'

# # Function for creating a backup file
# # ex: backup file.txt
# # result: copies file as file.txt.bak
function backup --argument filename
    cp $filename $filename.bak
end

# # Function for copying files and directories, even recursively.
# # ex: copy DIRNAME LOCATIONS
# # result: copies the directory and all of its contents.
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
	set from (echo $argv[1] | trim-right /)
	set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

# # Function for printing a column (splits input on whitespace)
# # ex: echo 1 2 3 | coln 3
# # output: 3
function coln
    while read -l input
        echo $input | awk '{print $'$argv[1]'}'
    end
end

# # Function for printing a row
# # ex: seq 3 | rown 3
# # output: 3
function rown --argument index
    sed -n "$index p"
end

# # Function for ignoring the first 'n' lines
# # ex: seq 10 | skip 5
# # results: prints everything but the first 5 lines
function skip --argument n
    tail +(math 1 + $n)
end

# Function for taking the first 'n' lines
# ex: seq 10 | take 5
# results: prints only the first 5 lines
function take --argument number
    head -$number
end

### END OF FUNCTIONS ###


alias vim='nvim'

# Changing "ls" to "eza"
alias ls='eza -al --color=always --group-directories-first' # my preferred listing
alias la='eza -a --color=always --group-directories-first'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first'  # long format
alias lt='eza -aT --color=always --group-directories-first' # tree listing
alias l.='eza -a | egrep "^\."'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

# alias i='doas xbps-install -S'
# alias u='i; doas xbps-install -u xbps; doas xbps-install -u'
# alias q='doas xbps-query -Rs'
# alias r='doas xbps-remove -R'

# git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias tag='git tag'
alias newtag='git tag -a'

# Merge Xresources
alias merge='xrdb -merge ~/.Xresources'

alias battery="upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk '/percentage/ {print $2}'"
alias batteryinfo='upower -i /org/freedesktop/UPower/devices/battery_BAT0'

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias big='find / -type f -size +50M -exec du -h {} \; | sort -n'

### SETTING THE STARSHIP PROMPT ###
starship init fish | source
