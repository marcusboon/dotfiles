# Auto-attach or create tmux only on SSH, in interactive shells, with a terminal, and not already inside tmux
# Put in ~/.bash_profile, ~/.bashrc, or ~/.zshrc
if [ -n "$SSH_CONNECTION" ] && [ -z "$TMUX" ]; then
    sessions=$(tmux ls -F '#S' 2>/dev/null || true)

    # Helper: generate the next free auto session name
    next_session_name() {
        n=1
        while printf '%s\n' "$sessions" | grep -qx "session$n"; do
            n=$((n+1))
        done
        echo "session$n"
    }

    if [ -z "$sessions" ]; then
        echo "No tmux sessions exist."
        printf "Enter a new session name (or 'x' to skip, Enter for auto): "
        IFS= read -r choice
        if [ "$choice" = "x" ] || [ "$choice" = "X" ]; then
            echo "Not starting tmux."
            exit
        elif [ -z "$choice" ]; then
            newname=$(next_session_name)
            echo "Creating new session: $newname"
            tmux new-session -s "$newname"
            exit
        else
            tmux new-session -s "$choice"
            exit
        fi
    else
        echo "Tmux sessions detected:"
        i=1
        printf '%s\n' "$sessions" | while IFS= read -r s; do
            printf '  %d) %s\n' "$i" "$s"
            i=$((i+1))
        done
        printf '  x) Do not start tmux\n'
        printf "Choose a session number, an unused name (creates new), or 'x': "
        IFS= read -r choice

        case $choice in
            x|X)
                echo "Not starting tmux."
                ;;
            '' )
                newname=$(next_session_name)
                echo "Creating new session: $newname"
                tmux new-session -s "$newname"
                exit
                ;;
            *[!0-9]*)
                # Non-numeric string -> treat as session name
                if printf '%s\n' "$sessions" | grep -qx "$choice"; then
                    tmux attach-session -t "$choice"
                else
                    tmux new-session -s "$choice"
                fi
                exit
                ;;
            *)
                # Numeric -> attach to existing session by index
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

