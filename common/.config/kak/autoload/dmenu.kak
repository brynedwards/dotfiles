decl -docstring %{formatted shell command whose output is passed to `dmenu` to generate a list of tokens
Each occurence of the `%s` string will be replaced with the directory to list} \
    str dmenu_filesearch_cmd 'rg --files "%s"'

def -params .. -file-completion \
    -docstring %{dmenu [<dirs>]: open a file in the given directories
If no directories are given then the directory in which the current buffer was saved is used} \
    dmenu %{ %sh{
    if [ $# -ge 1 ]; then
        cwd=$(printf %s "$@" | sed 's/\//\\\//g')
    else
        cwd=$(dirname "${kak_buffile}" | sed 's/\//\\\//g')
    fi
    filesearch_cmd=$(printf %s "${kak_opt_dmenu_filesearch_cmd}" | sed "s/%s/${cwd}/g")
    eval "${filesearch_cmd}" | eval "dmenu" | while read path; do
        printf "eval -try-client '%s' edit '%s'" "${kak_client}" "${path}" \
            | kak -p "${kak_session}"
    done
} }
