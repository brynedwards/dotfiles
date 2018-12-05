config.bind("w", "scroll up")
config.bind("s", "scroll down")
config.bind("e", "scroll-page 0 -0.5")
config.bind("d", "scroll-page 0 0.5")
config.bind("b", "scroll-page 0 -0.9")
config.bind("<Space>", "scroll-page 0 0.9")

config.bind("S", "back")
config.bind("D", "forward")
config.bind("E", "tab-prev")
config.bind("R", "tab-next")

config.bind("q", "tab-close")
config.bind("Q", "undo")
config.bind("t", "set-cmd-text -s :open -t")

config.bind("<Tab>", "set-cmd-text -s :buffer")

c.colors.hints.fg = "white"
c.colors.hints.match.fg = "cyan"
c.colors.hints.bg = "rgba(0, 0, 0, 0.8)"

c.hints.chars = "qwerasdfzxcv"
c.hints.uppercase = True
c.hints.border = "0"

c.tabs.show = "multiple"

c.fonts.completion.category = "bold 8pt monospace"
c.fonts.completion.entry = "8pt monospace"
c.fonts.debug_console = "8pt monospace"
c.fonts.downloads = "8pt monospace"
c.fonts.hints = "bold 8pt sans"
c.fonts.statusbar = "8pt monospace"
c.fonts.tabs = "8pt monospace"



c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    'g': 'https://google.ie/search?q={}',
    'aw': 'https://wiki.archlinux.org/?search={}',
    'w': 'https://en.wikipedia.org/?search={}',
}
