execute pathogen#infect()
syntax on
filetype plugin indent on


"Remove the Gray bar from ALESignColumn
highlight clear ALESignColumn
highlight clear SignColumn

"formatting for yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

"Setting gutter numbers
set relativenumber
set number

"Handle word wrapping in VIM better
set wrap
set linebreak

"Make Explore open without a banner
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_browse_split = 4
