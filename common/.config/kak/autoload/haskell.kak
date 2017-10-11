hook global WinSetOption filetype=haskell %{
    set buffer indentwidth 2
    map -docstring "Create tmux repl, start GHCi and load current buffer" \
        buffer user <a-r> %{: tmux-repl-horizontal<ret>: tmux-focus<ret> }
    map -docstring "Reload GHCi buffer" buffer user l %{: x11-send-command :r<ret>}
    map -docstring "Indent file" buffer user i %{%,I<ret>}
    map -docstring "Indent selection" buffer user I %{|format-haskell<ret>}
    map -docstring "Reload GHCi buffer" buffer user w %{: w<ret>: x11-send-command :r<ret>}
}
