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

 # Aliases
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

#aliases
alias close='konsole -e zsh'
alias programming='cd ~/Documents/programming && nvim'
alias cls='clear'
alias minecraft-java='prismlauncher'
alias minecraft-bedrock='flatpak run io.mrarm.mcpelauncher'
alias figma='figma-linux --enable-features=UseOzonePlatform --ozone-platform=wayland'
alias lock='swaylock --screenshots --effect-blur 7x5 --effect-vignette 0.5:0.5 --fade-in 1.5'
. "/home/mocha/.deno/env"
alias focus='/home/mocha/focus/focus.sh'

export EDITOR=nvim
export VISUAL=nvim

export PATH=$HOME/.npm-global/bin:$PATH
