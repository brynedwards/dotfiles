# Commands for language servers
decl str lsp_servers %{
    python:pyls
    typescript:node javascript-typescript-langserver/lib/language-server-stdio.js
    javascript:node javascript-typescript-langserver/lib/language-server-stdio.js
    go:go-langserver
    haskell:hie-lsp
}

# Ignore E501 for python (Line length > 80 chars)
# decl str lsp-python-disabled-diagnostics '\^E501'

# Example keybindings
map -docstring %{Goto definition}     global user . ':lsp-goto-definition<ret>'
map -docstring %{Select references}   global user r ':lsp-references<ret>'
map -docstring %{Hover help}          global user h ':lsp-hover docsclient<ret>'
map -docstring %{Next diagnostic}     global user j ':lsp-diagnostics next cursor<ret>'
map -docstring %{Previous diagnostic} global user k ':lsp-diagnostics prev cursor<ret>'

# Manual completion and signature help when needed
map global insert <a-c> '<a-;>:eval -draft %(exec b; lsp-complete)<ret>'
map global insert <a-h> '<a-;>:lsp-signature-help<ret>'

decl -hidden str lsp_tmp_dir

def lsp-start %{
    %sh{
        dir=$(mktemp -d "${TMPDIR:-/tmp}"/kak-lsp.XXXXXXXX)
        mkfifo ${dir}/fifo
        printf %s\\n "set buffer lsp_tmp_dir ${dir}"
        printf %s\\n "eval -no-hooks write ${dir}/buf"
    }
    %sh{
        dir=${kak_opt_lsp_tmp_dir}
        printf %s\\n "eval -draft %{
                  edit! -fifo ${dir}/fifo -debug *lsp-output*
                  set buffer filetype make
                  set buffer make_current_error_line 0
                  hook -group fifo buffer BufCloseFifo .* %{
                      nop %sh{ rm -r ${dir} }
                      remove-hooks buffer fifo
                  }
              }"
        ( lspc $kak_session > ${dir}/fifo 2>&1
        ) > /dev/null 2>&1 < /dev/null &
    }

}

def lsp-add-hooks %{
    # Hover and diagnostics on idle
    hook -group lsp global NormalIdle .* %{
        lsp-diagnostics cursor
        lsp-hover cursor
    }

    # Aggressive diagnostics
    hook -group lsp global InsertEnd .* %{
        lsp-sync
    }
}
