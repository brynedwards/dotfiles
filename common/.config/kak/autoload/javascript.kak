hook global WinSetOption filetype=javascript %{
    set-option buffer formatcmd 'prettier --stdin --parser=babel'
}

hook global WinSetOption filetype=typescript %{
    set-option buffer formatcmd 'prettier --stdin --parser=typescript'
    set-option buffer lintcmd 'eslint --format=/usr/lib/node_modules/eslint-formatter-kakoune'
}
