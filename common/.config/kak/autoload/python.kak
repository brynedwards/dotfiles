hook global WinSetOption filetype=python %{
    set buffer indentwidth 4
    map -docstring "Indent selection" buffer user i %{|black -<ret>}
    map -docstring "Indent file" buffer user I %{%,i<ret>}
}
