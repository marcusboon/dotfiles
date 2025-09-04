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
        echo -n "Choose an option [1/2]: "
        read choice
        if [ "$choice" = "1" ]; then
            tmux attach-session
            exit
        elif [ "$choice" = "2" ]; then
            echo -n "Enter new session name: "
            read newname
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


# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/marcus/.lmstudio/bin"
# End of LM Studio CLI section

