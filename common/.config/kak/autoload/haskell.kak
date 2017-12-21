hook global WinSetOption filetype=haskell %{
    set buffer indentwidth 2
    map -docstring "Reload GHCi buffer" buffer user l %{: x11-send-command :r<ret>}
    map -docstring "Indent file" buffer user I %{%,i<ret>}
    map -docstring "Indent selection" buffer user i %{|format-haskell<ret>}
    map -docstring "Run main" buffer user r %{: x11-send-command main<ret>}
}

hook global BufWritePost .*\.hs %{
  x11-send-command ':r'
}
