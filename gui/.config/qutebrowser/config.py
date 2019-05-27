config.bind("w", "scroll up")
config.bind("s", "scroll down")
config.bind("e", "scroll-page 0 -0.5")
config.bind("d", "scroll-page 0 0.5")
config.bind("b", "scroll-page 0 -0.9")
config.bind("<Space>", "scroll-page 0 0.9")

config.bind("S", "back")
config.bind("D", "forward")
config.bind("H", "tab-prev")
config.bind("L", "tab-next")

config.bind("q", "tab-close")
config.bind("Q", "undo")
config.bind("t", "set-cmd-text -s :open -t")

# config.bind("<Tab>", "set-cmd-text -s :buffer")

# config.bind("gc", "spawn --userscript readability")

c.colors.hints.fg = "white"
c.colors.hints.match.fg = "cyan"
c.colors.hints.bg = "rgba(0, 0, 0, 0.8)"

c.content.headers.user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"


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
    'DEFAULT': 'https://google.ie/search?q={}',
    'ddg': 'https://duckduckgo.com/?q={}',
    'aw': 'https://wiki.archlinux.org/?search={}',
    'w': 'https://en.wikipedia.org/?search={}',
    'aur': 'https://aur.archlinux.org/packages/?O=0&K={}'
}
