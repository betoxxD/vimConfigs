set number
set mouse=a
set numberwidth=1
set clipboard=unnamed
syntax enable
set showcmd
set ruler
set encoding=utf-8
set showmatch
set sw=2
set relativenumber
so ~/.config/.vim/plugins.vim
so ~/.config/.vim/plugin-config.vim
so ~/.config/.vim/maps.vim
set laststatus=2
set noshowmode

colorscheme dracula
set termguicolors
"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
