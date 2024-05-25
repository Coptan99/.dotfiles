# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

PS1="%B%{$fg[cyan]%}%c %{$fg[blue]%}%{$fg[green]%}>%{$reset_color%}%b "

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

plugdir="$HOME/.config/zsh"
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
