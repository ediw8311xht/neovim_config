
require('rainbow-delimiters.setup').setup {
    strategy = {
        [''] = 'rainbow-delimiters.strategy.global',
        vim = 'rainbow-delimiters.strategy.local',
    },
    query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
    },
    priority = {
        [''] = 110,
        lua = 210,
    },
    highlight = {
        'RainbowDelimiter1',
        'RainbowDelimiter2',
        'RainbowDelimiter3',
        'RainbowDelimiter4',
        'RainbowDelimiter5',
        'RainbowDelimiter6',
        'RainbowDelimiter7',
    },
}


