hook global WinSetOption filetype=javascript %{
    set-option buffer formatcmd 'eslint --config .eslintrc.js --fix -'
}

hook global WinSetOption filetype=typescript %{
    set-option buffer formatcmd 'eslint --fix-dry-run --stdin'
    set-option buffer lintcmd 'eslint --config .eslintrc.js --format=/usr/lib/node_modules/eslint-formatter-kakoune'
}
