typeset -g POWERLEVEL9K_INSTANT_PROMPT=off



# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Optional: quiet the warning
#typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# --- Oh My Zsh ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Powerlevel10k prompt (must be HERE before anything prints)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# --- Aliases ---
alias ls='eza'
alias ll='eza -lh'
alias la='eza -a'
alias tree='eza -T'


if [[ $TERM == "xterm-kitty" ]]; then
    fastfetch
    echo "Welcome back Mocha <3"
elif [[ $TERM == "alacritty" ]]; then
    neofetch
    echo "Welcome back Mocha <3"
else
  :
fi


alias close='konsole -e zsh'
alias code='cd ~/Documents/programming/coding'
alias cls='clear'
alias minecraft='flatpak run org.prismlauncher.PrismLauncher'

. "/home/mocha/.deno/env"

export EDITOR=nvim
export VISUAL=nvim

