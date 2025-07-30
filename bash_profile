# Auto-attach or create tmux only on SSH, in interactive shells, with a terminal, and not already inside tmux
# ~/.bash_profile or ~/.bashrc
# Only run if this is an SSH session and not already inside tmux
if [ -n "$SSH_CONNECTION" ] && [ -z "$TMUX" ]; then
    session_count=$(tmux ls 2>/dev/null | wc -l)
    if [ "$session_count" -eq 0 ]; then
        # No sessions exist, start a new one
        tmux new-session
        exit
    else
        echo "Tmux sessions detected:"
        tmux ls
        echo
        echo "Options:"
        echo "  1) Attach to an existing session"
        echo "  2) Create a new session"
        read -p "Choose an option [1/2]: " choice
        if [ "$choice" = "1" ]; then
            tmux attach-session
            exit
        elif [ "$choice" = "2" ]; then
            read -p "Enter new session name: " newname
            tmux new-session -s "$newname"
            exit
        else
            echo "Invalid choice. Not starting tmux."
        fi
    fi
fi

# Vim mode for bash
set -o vi

# Vi keybindings for tmux
export EDITOR='vim'

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

