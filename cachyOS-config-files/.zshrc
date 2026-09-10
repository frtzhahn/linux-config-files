# Powerlevel10k & Instant Prompt
# kept off to avoid warnings from fastfetch/figlet terminal output
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source "$ZSH/oh-my-zsh.sh"

# Environment & Consolidated PATH
export EDITOR=nvim
export VISUAL=nvim
export BROWSER="zen-browser"

# Dedup and append paths cleanly via Zsh array tying
typeset -U path PATH
path=(
  "$HOME/.local/bin"
  "$HOME/.npm-global/bin"
  "$HOME/go/bin"
  "$HOME/.opencode/bin"
  $path
)
export PATH

# Environment setups
[ -f "$HOME/.deno/env" ] && . "$HOME/.deno/env"

# API keys (Keep private source from an uncommitted file if using Git)
if [[ -f "$HOME/.env.secrets" ]]; then
  source "$HOME/.env.secrets"
else
  export WAKATIME_API_KEY="wakatime-api-key-123"
fi

# Standard Aliases & Shortcuts
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias cls='clear'
alias v='nvim'
alias vim='nvim'
alias programming='cd ~/Documents/programming && nvim'
alias focus='$HOME/focus/focus.sh'
alias figma='figma-linux --enable-features=UseOzonePlatform --ozone-platform=wayland'
alias lock='swaylock --screenshots --effect-blur 7x5 --effect-vignette 0.5:0.5 --fade-in 1.5'
alias minecraft-java='prismlauncher'
alias minecraft-bedrock='flatpak run io.mrarm.mcpelauncher'
alias update='sudo pacman -Syu'

# Directory navigators with CWD sync
y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

r() {
  local tmp="$(mktemp -t "ranger-cwd.XXXXXX")"
  ranger "$@" --choosedir="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# CLI Agent Discord Rich Presence Dispatcher
_run_agent_with_drpc() {
  setopt local_options local_traps
  
  local agent_name="$1"
  shift
  
  local enable_drpc=false
  local -a filtered_args=()
  local drpc_pid=""
  local exit_code=0
  local conv_id=""

  # Fallback resolution: matches agy to antigravity-cli.sh if agy.sh doesn't exist
  local config_target="${agent_name}.sh"
  if [[ "$agent_name" == "agy" ]] && [[ ! -f "$HOME/.config/linux-discord-rich-presence/agy.sh" ]]; then
    config_target="antigravity-cli.sh"
  fi
  local drpc_cfg="$HOME/.config/linux-discord-rich-presence/${config_target}"

  # Parse arguments: strip --drpc and capture conversation metadata if present
  for arg in "$@"; do
    if [[ "$arg" == "--drpc" ]]; then
      enable_drpc=true
    else
      filtered_args+=("$arg")
      if [[ "$arg" =~ ^-?-conversation=([^ ]+) ]]; then
        conv_id="${match[1]}"
      fi
    fi
  done

  # Launch Rich Presence if requested
  if [[ "$enable_drpc" == true ]] && command -v linux-discord-rich-presence &>/dev/null; then
    if [[ -f "$drpc_cfg" ]]; then
      DRPC_CONVERSATION="${conv_id:-Default Session}" \
      DRPC_WORKSPACE="$(basename "$PWD")" \
      linux-discord-rich-presence -c "$drpc_cfg" &>/dev/null &
      drpc_pid=$!
      
      trap '[[ -n "$drpc_pid" ]] && kill "$drpc_pid" 2>/dev/null' EXIT INT TERM
    else
      echo "[drpc] Warning: Config not found at $drpc_cfg" >&2
    fi
  fi

  # Execute the CLI binary
  command "$agent_name" "${filtered_args[@]}"
  exit_code=$?

  # Terminate Rich Presence
  if [[ -n "$drpc_pid" ]]; then
    kill "$drpc_pid" 2>/dev/null
    drpc_pid=""
  fi

  return $exit_code
}

# Aliased CLI wrappers
agy() { _run_agent_with_drpc "agy" "$@"; }
opencode() { _run_agent_with_drpc "opencode" "$@"; }
codex() { _run_agent_with_drpc "codex" "$@"; }

# Terminal Startup State Machine
STATE_FILE="$HOME/.term_state"
[[ -f "$STATE_FILE" ]] || echo "1" > "$STATE_FILE"
STATE=$(cat "$STATE_FILE")
[[ "$STATE" =~ ^[1-6]$ ]] || STATE=1

case $STATE in
  1) fastfetch -c "$HOME/.config/fastfetch/config.jsonc" ;;
  2) figlet -w 200 -f "ANSI Shadow" "Welcome Back Mocha" && todo.sh list ;;
  3) fastfetch -c "$HOME/.config/fastfetch/config2.jsonc" ;;
  4) fastfetch -c "$HOME/.config/fastfetch/config4.jsonc" ;;
  5) figlet -w 200 -f "ANSI Shadow" "I LOVE YOU MY BEBU :3" ;;
  6) fastfetch -c "$HOME/.config/fastfetch/config5.jsonc" ;;
esac

echo "$(( (STATE % 6) + 1 ))" > "$STATE_FILE"

# Prompt Finalization
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
