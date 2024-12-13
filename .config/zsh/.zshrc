setopt autocd
setopt interactive_comments
setopt prompt_subst
setopt histignorespace
setopt hist_reduce_blanks
setopt hist_verify
setopt hist_ignore_all_dups
stty stop undef

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
autoload -U vcs_info
zstyle ":vcs_info:*" enable git svn
zstyle ":vcs_info:*" formats "(%b) "
precmd() {
	vcs_info
	echo -ne "\e[1 q"
}
PROMPT='%B%F{cyan}%c %F{blue}${vcs_info_msg_0_}%F{%(?.green.red)}>%f%b '
[ -n "$SSH_TTY" ] && PROMPT="%F{magenta}[%M] $PROMPT"
# PS1="%{$fg[blue]%}%B[%b%{$fg[cyan]%}%n%{$fg[grey]%}%B@%b%{$fg[cyan]%}%m%{$fg[blue]%}%B]-%b%{$fg[blue]%}%B[%b%{$fg[white]%}%~%{$fg[blue]%}%B]%b
# %{$fg[cyan]%}%B>>>%b%{$reset_color%} "

# History in cache directory:
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
HISTFILE="${HISTFILE:-${XDG_STATE_HOME:-$HOME/.local/state}/history}"

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

bindkey -v
KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

bindkey -s "^o" '^uxdg-open "$(fzf)" >/dev/null\n'
bindkey -s "^f" '^ue "$(find ~/ -type f 2>/dev/null | fzf)"\n'
bindkey -s "^g" '^ucd "$(find ~/ -type d 2>/dev/null | fzf)"\n'
bindkey -s "^t" '^u[ -f TODO.md ] && $EDITOR TODO.md || notes todo\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

ZSHPLUGINSDIR="${ZSHPLUGINSDIR:-/usr/share/zsh/plugins}"
if [ -f "$ZSHPLUGINSDIR/zsh-history-substring-search/zsh-history-substring-search.zsh" ]; then
	. "$ZSHPLUGINSDIR/zsh-history-substring-search/zsh-history-substring-search.zsh"
	bindkey -a "k" history-substring-search-up
	bindkey -a "j" history-substring-search-down
	bindkey "^[[A" history-substring-search-up
	bindkey "^[[B" history-substring-search-down
fi
if [ -f "$ZSHPLUGINSDIR/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh" ]; then
	ZSH_AUTOSUGGEST_STRATEGY=(history completion)
	. "$ZSHPLUGINSDIR/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
fi
[ -f "$ZSHPLUGINSDIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" ] &&
	. "$ZSHPLUGINSDIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
[ -r /usr/share/z/z.sh ] && . /usr/share/z/z.sh
