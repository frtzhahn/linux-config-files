# to remove prompts while opening terminals
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# powerlevel10k instant prompt Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# path to my oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# zsh theme to load 
ZSH_THEME="powerlevel10k/powerlevel10k"

# standard plugins for command highlighting and command suggestions
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Load Oh My Zsh core (This is the crucial "built-in" trigger)
source $ZSH/oh-my-zsh.sh

# Ensures global npm packages (like live-server) are executable
export PATH="$HOME/.npm-global/bin:$PATH"

# Forces automated tools to use your preferred browser
export BROWSER="zen-browser"

# terminal shortcuts
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias minecraft-java='prismlauncher'
alias minecraft-bedrock='flatpak run io.mrarm.mcpelauncher'
alias programming='cd ~/Documents/programming && nvim'
alias cls='clear'
alias figma='figma-linux --enable-features=UseOzonePlatform --ozone-platform=wayland'
alias lock='swaylock --screenshots --effect-blur 7x5 --effect-vignette 0.5:0.5 --fade-in 1.5' . "/home/mocha/.deno/env"
alias focus='/home/mocha/focus/focus.sh'

run_agy_silent() {
    # 1. Start the DRP script in the background (&) and hide its text output
    linux-discord-rich-presence -c /home/mocha/.config/linux-discord-rich-presence/antigravity-cli.sh > /dev/null 2>&1 &
    
    # 2. Capture the Process ID (PID) of that background script
    local DRP_PID=$!

    # 3. Run your Gemini CLI
    command agy "$@"

    # 4. Once you exit Gemini, kill the DRP process so it doesn't run forever
    kill $DRP_PID 2>/dev/null
}

alias agy-drp='run_agy_silent'


run_codex_silent() {
    # 1. Start the DRP script in the background (&) and hide its text output
    linux-discord-rich-presence -c /home/mocha/.config/linux-discord-rich-presence/codex.sh > /dev/null 2>&1 &
    
    # 2. Capture the Process ID (PID) of that background script
    local DRP_PID=$!

    # 3. Run your Gemini CLI
    command codex "$@"

    # 4. Once you exit Gemini, kill the DRP process so it doesn't run forever
    kill $DRP_PID 2>/dev/null
}

alias codex-drp='run_codex_silent'

# editors
alias v='nvim'
alias vim='nvim'
export EDITOR=nvim
export VISUAL=nvim

# system updates on arch based distros
alias update='sudo pacman -Syu'
# alias update='yay pacman -Syu'
# alias update='paru pacman -Syu'



# changes terminal directory based on what directory yazi is focused in
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}


# changes terminal directory based on what directory ranger is focused in
function r() {
    local tmp="$(mktemp -t "ranger-cwd.XXXXXX")"
    ranger "$@" --choosedir="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# to make my terminal remember the increments
STATE_FILE="$HOME/.term_state"

# Initialize the state file if it doesn't exist
if [ ! -f "$STATE_FILE" ]; then
    echo "1" > "$STATE_FILE"
fi

STATE=$(cat "$STATE_FILE")

# Execute the payload based on the state (1 through 5)
# this will make launching terminals a bit slower like 0.4 seconds
case $STATE in
    1)
        fastfetch -c config.jsonc 
        ;;
    2)
        figlet -w 200 -f  "ANSI Shadow" "Welcome Back Mocha" 
				todo.sh list
        ;;
    3)
        fastfetch -c config2.jsonc
        ;;
    4)
        fastfetch -c config4.jsonc
        ;;
    5)
        figlet -w 200 -f "ANSI Shadow" "I LOVE YOU MY BEBU :3"
        ;;
    6)
        fastfetch -c config5.jsonc
        ;;
esac

# Increment the state, loop back to 1 if over 5
NEXT_STATE=$((STATE + 1))
if [ $NEXT_STATE -gt 6 ]; then
    NEXT_STATE=1
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="$HOME/go/bin:$PATH"

# to access go installed programs
export PATH="$HOME/go/bin:$PATH"

# opencode
export PATH=/home/mocha/.opencode/bin:$PATH

# wakatime api key
export WAKATIME_API_KEY="api_idk"

# Added by Antigravity CLI installer
export PATH="/home/mocha/.local/bin:$PATH"
