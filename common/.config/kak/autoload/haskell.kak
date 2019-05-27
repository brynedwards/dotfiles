hook global WinSetOption filetype=haskell %{
    set-option buffer indentwidth 2
    set-option buffer formatcmd format-haskell
}
