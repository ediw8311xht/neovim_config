
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
        'RainbowDelimiter_1',
        'RainbowDelimiter_2',
        'RainbowDelimiter_3',
        'RainbowDelimiter_4',
        'RainbowDelimiter_5',
        'RainbowDelimiter_6',
        'RainbowDelimiter_7',
    },
}


