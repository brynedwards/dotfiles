hook global WinSetOption filetype=python %{
    set buffer indentwidth 4
    map -docstring "Indent selection" buffer user i %{|yapf<ret>}
    map -docstring "Indent file" buffer user I %{%,i<ret>}
}
