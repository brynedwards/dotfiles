def -docstring %{x11-term [<arguments>]: create a new window for repl interaction
All optional parameters are forwarded to the new window} \
    -params .. \
    -command-completion \
    x11-term %{ evaluate-commands %sh{
        if [ $# -eq 0 ]; then cmd="${SHELL:-sh}"; else cmd="$@"; fi
        setsid st -e ${cmd} < /dev/null > /dev/null 2>&1 &
}}

