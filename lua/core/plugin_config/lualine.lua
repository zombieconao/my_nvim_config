require('lualine').setup {
    options = {
        theme = 'catppuccin',
        icons_enabled = true,
    },
    sections = {
        lualine_a = {
            {
                'filename',
                path = 1, -- 0: Just the filename, 1: Relative path, 2: Absolute path
            }
        }
    }
}