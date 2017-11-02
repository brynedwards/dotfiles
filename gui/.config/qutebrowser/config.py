config.bind("w", "scroll up")
config.bind("s", "scroll down")
config.bind("e", "scroll-page 0 -0.9")
config.bind("d", "scroll-page 0 0.9")

config.bind("S", "back")
config.bind("D", "forward")
config.bind("E", "tab-prev")
config.bind("R", "tab-next")

config.bind("q", "tab-close")
config.bind("t", "set-cmd-text -s :open -t")

config.set("hints.chars", "qwerasdfzxcv")
config.set("tabs.show", "multiple")


c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    'g': 'https://google.ie/search?q={}',
    'aw': 'https://wiki.archlinux.org/?search={}',
    'w': 'https://en.wikipedia.org/?search={}',
}
