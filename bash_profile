# Auto-attach or create tmux only on SSH, in interactive shells, with a terminal, and not already inside tmux
# ~/.bash_profile or ~/.bashrc
if [ -n "$SSH_CONNECTION" ] && [ -z "$TMUX" ]; then
    session_count=$(tmux ls 2>/dev/null | wc -l)
    if [ "$session_count" -eq 0 ]; then
        # No sessions exist, start a new one
        tmux new-session
        exit
    else
        echo "Tmux sessions detected:"
        sessions=$(tmux ls 2>/dev/null | awk -F: '{print $1}')
        i=1
        for s in $sessions; do
            echo "  $i) $s"
            i=$((i+1))
        done
        echo "  n) Create a new session"

        echo -n "Choose a session number or 'n': "
        read choice

        if [ "$choice" = "n" ]; then
            echo -n "Enter new session name: "
            read newname
            tmux new-session -s "$newname"
            exit
        elif [[ "$choice" =~ ^[0-9]+$ ]]; then
            selected=$(echo "$sessions" | sed -n "${choice}p")
            if [ -n "$selected" ]; then
                tmux attach-session -t "$selected"
            else
                echo "Invalid selection."
            fi
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

