Dotfiles, managed using GNU Stow

### Example

1. ```git clone git@github.com:brynedwards/dotfiles ~/.dotfiles``` (Use the
   SSH-style clone so you can use SSH keys for automatic sync, see below)
2. ```cd ~/.dotfiles```
3. ```stow --no-folding common```

Stow will tell you if there are any conflicts, it will not overwrite your
existing dotfiles.

### Automatic Sync

Schedule ```sync``` with cron. For ```sync```, you will need to set up an
SSH agent and SSH keys to use with GitHub. This repo uses keychain and Z
shell, instructions [here](http://serverfault.com/a/236437)

Example cron entry

```*/15 * * * * $HOME/.dotfiles/sync common server```

```sync``` can also be run on its own to sync at any time.
