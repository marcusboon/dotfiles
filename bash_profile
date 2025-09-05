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

