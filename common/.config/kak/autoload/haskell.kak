hook global WinSetOption filetype=haskell %{
    set buffer indentwidth 2
    map -docstring "Comment the current selection (Haskell)" buffer user c %{: haskell-comment-block<ret>}
    map -docstring "Reload GHCi buffer" buffer user l %{: x11-send-command :r<ret>}
    map -docstring "Indent file" buffer user i %{%,I<ret>}
    map -docstring "Indent selection" buffer user I %{|format-haskell<ret>}
}

hook global BufWritePost .*\.hs %{
  x11-send-command ':r'
}

# Workaround for #1600
def haskell-comment-block %{
    %sh{
        opening="{-"
        closing="-}"
        printf %s\\n "eval -draft %^ try %@
            # The selection is empty
            exec <a-K>\\A[\\h\\v\\n]*\\z<ret>

            try %&
                # The selection has already been commented
                exec %{<a-K>\\A\\Q${opening}\\E.*\\Q${closing}\\E\\n*\\z<ret>}

                # Comment the selection
                echo -debug %{${opening} ${closing}}
                exec -draft %_a${closing}<esc>i${opening}_
            & catch %{
                # Uncomment the commented selection
                exec -draft %{s(\\A\\Q${opening}\\E)|(\\Q${closing}\\E\\n*\\z)<ret>d}
            }
        @ ^"
    }
}
