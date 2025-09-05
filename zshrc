# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="babun"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git systemd ssh-agent)

# User configuration

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# ssh agent settings
# Load different identities
zstyle :omz:plugins:ssh-agent identities id_rsa id_ed25519 id_yubikey

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias apt='noglob apt'
alias apt-get='noglob apt-get'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Antigen
source $HOME/.dotfiles/antigen.zsh
antigen bundle https://github.com/jeffreytse/zsh-vi-mode
antigen apply

# Prioritise homebrew
export PATH="/opt/homebrew/bin:$PATH"

# Auto-attach or create tmux only on SSH, in interactive shells, with a terminal, and not already inside tmux
# Put in ~/.bash_profile, ~/.bashrc, or ~/.zshrc
if [ -n "$SSH_CONNECTION" ] && [ -z "$TMUX" ]; then
    sessions=$(tmux ls -F '#S' 2>/dev/null || true)

    if [ -z "$sessions" ]; then
        tmux new-session
        exit
    else
        echo "Tmux sessions detected:"
        i=1
        printf '%s\n' "$sessions" | while IFS= read -r s; do
            printf '  %d) %s\n' "$i" "$s"
            i=$((i+1))
        done
        printf '  n) Create a new session\n'
        printf "Choose a session number or 'n': "
        IFS= read -r choice

        case $choice in
            n|N)
                printf "Enter new session name: "
                IFS= read -r newname
                tmux new-session -s "$newname"
                exit
                ;;
            ''|*[!0-9]*)
                echo "Invalid choice. Not starting tmux."
                ;;
            *)
                selected=$(printf '%s\n' "$sessions" | sed -n "${choice}p")
                if [ -n "$selected" ]; then
                    tmux attach-session -t "$selected"
                else
                    echo "Invalid selection."
                fi
                exit
                ;;
        esac
    fi
fi

# Vi keybindings for tmux
export EDITOR='vim'

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/marcus/.lmstudio/bin"
# End of LM Studio CLI section

