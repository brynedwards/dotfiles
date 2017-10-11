# termcmd should already be set in x11.kak
def -allow-override -docstring %{x11-repl [<arguments>]: create a new window for repl interaction
All optional parameters are forwarded to the new window} \
    -params .. \
    -command-completion \
    my-x11-repl %{ %sh{
        if [ -z "${kak_opt_termcmd}" ]; then
           echo "echo -markup '{Error}termcmd option is not set'"
           exit
        fi
        if [ $# -eq 0 ]; then cmd="${SHELL:-sh}"; else cmd="$@"; fi
        setsid alacritty -t kak_repl_window < /dev/null > /dev/null 2>&1 &
}}

def -allow-override my-x11-send-text -docstring "send the selected text to the repl window" %{
    nop %sh{
        printf %s\\n "${kak_selection}" | xsel -i
        wid=$(xdotool getactivewindow)
        xdotool search --name kak_repl_window windowactivate
        xdotool type --clearmodifiers "${kak_selection}"
        xdotool windowactivate $wid
    }
}

def -allow-override x11-send-command -params 0..1 %{
    nop %sh{
        wid=$(xdotool getactivewindow)
        xdotool search --name kak_repl_window windowactivate
        xdotool type --clearmodifiers "$1"
        sleep 0.075
        xdotool key --clearmodifiers "Return"
        xdotool windowactivate $wid
    }
}


