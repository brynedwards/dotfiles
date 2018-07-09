# termcmd should already be set in x11.kak
def -docstring %{x11-repl [<arguments>]: create a new window for repl interaction
All optional parameters are forwarded to the new window} \
    -params .. \
    -command-completion \
    my-x11-repl %{ %sh{
        setsid st -t kak_repl_${kak_client_pid} < /dev/null > /dev/null 2>&1 &
}}

def my-x11-send-text -docstring "send the selected text to the repl window" %{
    nop %sh{
        printf %s\\n "${kak_selection}" | xsel -i
        wid=$(xdotool getactivewindow)
        xdotool search --name kak_repl_${kak_client_pid} windowactivate
        xdotool type --clearmodifiers "${kak_selection}"
        xdotool windowactivate $wid
    }
}

def x11-send-command -params 0..1 %{
    nop %sh{
        wid=$(xdotool getactivewindow)
        if xdotool search --name kak_repl_${kak_client_pid} windowactivate; then
            xdotool type --clearmodifiers "$1"
            sleep 0.2
            xdotool key --clearmodifiers "Return"
            xdotool windowactivate $wid
        fi
    }
}


