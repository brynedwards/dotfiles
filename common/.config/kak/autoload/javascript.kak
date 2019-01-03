hook global WinSetOption filetype=javascript %{
    map -docstring "Indent selection" buffer user i %{|prettier --parser babylon<ret>}
    map -docstring "Indent file" buffer user I %{%,i<ret>}
}

hook global WinSetOption filetype=typescript %{
    map -docstring "Indent selection" buffer user i %{|prettier --parser typescript<ret>}
    map -docstring "Indent file" buffer user I %{%,i<ret>}
}
