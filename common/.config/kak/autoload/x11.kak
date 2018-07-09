define-command -docstring %{my-x11-new [<command>]: create a new kak client for the current session
The optional arguments will be passed as arguments to the new client} \
    -params .. \
    -command-completion \
    my-x11-new %{ %sh{
        if [ -z "${kak_opt_termcmd}" ]; then
           echo "echo -markup '{Error}termcmd option is not set-option'"
           exit
        fi
        if [ $# -ne 0 ]; then kakoune_params="-e '$@'"; fi
        setsid st -e kak < /dev/null > /dev/null 2>&1 &
}}

def -docstring %{x11-term [<arguments>]: create a new window for repl interaction
All optional parameters are forwarded to the new window} \
    -params .. \
    -command-completion \
    x11-term %{ %sh{
        if [ $# -eq 0 ]; then cmd="${SHELL:-sh}"; else cmd="$@"; fi
        setsid st -e ${cmd} < /dev/null > /dev/null 2>&1 &
}}

