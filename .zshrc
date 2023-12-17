setopt autocd
setopt interactive_comments
setopt prompt_subst
stty stop undef

__git_branch() {
	br="$(git symbolic-ref HEAD --short 2>/dev/null)"
	[ "$br" ] && echo "($br) "
}

autoload -U colors && colors
PS1="%B%{$fg[cyan]%}%c %{$fg[blue]%}\$(__git_branch)%{$fg[green]%}>%{$reset_color%}%b "
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magneta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000

autoload -U compinit
zstyle ":completion:*" menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

set -o vi

bindkey -M menuselect "h" vi-backward-char
bindkey -M menuselect "k" vi-up-line-or-history
bindkey -M menuselect "l" vi-forward-char
bindkey -M menuselect "j" vi-down-line-or-history
bindkey -M menuselect "^[[Z" reverse-menu-complete

bindkey -v "^?" backward-delete-char
bindkey "^[[P" delete-char
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# autoload edit-command-line
zle -N edit-command-line
bindkey "^e" edit-command-line

plugdir="/usr/share/zsh/plugins"
if [ -d "$plugdir" ]; then
	[ -f "$plugdir/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh" ] &&
		. "$plugdir/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
	[ -f "$plugdir/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh" ] &&
		. "$plugdir/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
	if [ -f "$plugdir/zsh-history-substring-search/zsh-history-substring-search.zsh" ]; then
		. "$plugdir/zsh-history-substring-search/zsh-history-substring-search.zsh"
		bindkey -a "k" history-substring-search-up
		bindkey -a "j" history-substring-search-down
		bindkey "^[[A" history-substring-search-up
		bindkey "^[[B" history-substring-search-down
	fi
fi
unset plugdir

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "/var/lib/flatpak/exports/bin/" ] ;
  then PATH="/var/lib/flatpak/exports/bin/:$PATH"
fi

if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

bindkey -s "^f" 'cd "$(dirname "$(fzf-tmux)")"\n'
bindkey -s "^s" '$EDITOR "$(fzf-tmux)"\n'
bindkey -s "^t" '[ -f TODO.md ] && $EDITOR TODO.md || notes todo\n'
bindkey -s "^f" 'tmux\n'

alias vi='nvim'
alias ls='ls --color=always --group-directories-first' # my preferred listing
alias la='ls -a --color=always --group-directories-first'  # all files and dirs
alias ll='ls -l --color=always --group-directories-first'  # long format
alias lt='tree -C' # tree listing

alias i='doas xbps-install -S'
alias u='i; doas xbps-install -u xbps; doas xbps-install -u'
alias q='doas xbps-query -Rs'
alias r='doas xbps-remove -R'

alias battery="upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk '/percentage/ {print $2}'"
alias batteryinfo='upower -i /org/freedesktop/UPower/devices/battery_BAT0'

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias big='find / -type f -size +50M -exec du -h {} \; | sort -n'

# eval "$(starship init zsh)"
