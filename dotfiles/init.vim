"""""""" Set runtime path
set rtp+=~/.vim

"""""""" Vim Plug configuration
call plug#begin('~/.local/share/nvim/site/plugged')

" Declare the list of plugins.

"Gutter plugins
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'

" Fugitive
Plug 'tpope/vim-fugitive'

" Polyglot
Plug 'sheerun/vim-polyglot'

"ALE syntax checker
Plug 'dense-analysis/ale'

" Vim rust
Plug 'rust-lang/rust.vim'

" Commentary
Plug 'tpope/vim-commentary'

" Neoterm
Plug 'kassio/neoterm'

" Terraform support
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'

" CSharp
Plug 'OmniSharp/omnisharp-vim'

" COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"End Plugin list

""""""" Plugin Configurations

"Vim Terraform
" (Optional) Default: 1, enable(1)/disable(0) terraform module registry completion
let g:terraform_registry_module_completion = 0

" (Optional)Remove Info(Preview) window
set completeopt-=preview

" Omnisharp configuration

" Don't autoselect first omnicomplete option, show options even if there is only
" one (so the preview documentation is accessible). Remove 'preview', 'popup'
" and 'popuphidden' if you don't want to see any documentation whatsoever.
" Note that neovim does not support `popuphidden` or `popup` yet:
" https://github.com/neovim/neovim/issues/10996
if has('patch-8.1.1880')
  set completeopt=longest,menuone,popuphidden
  " Highlight the completion documentation popup background/foreground the same as
  " the completion menu itself, for better readability with highlighted
  " documentation.
  set completepopup=highlight:Pmenu,border:off
else
  set completeopt=longest,menuone,preview
  " Set desired preview window height for viewing documentation.
  set previewheight=5
endif

" Tell ALE to use OmniSharp for linting C# files, and no other linters.
let g:ale_linters = { 'cs': ['OmniSharp'] }

augroup omnisharp_commands
  autocmd!

  " Show type information automatically when the cursor stops moving.
  " Note that the type is echoed to the Vim command line, and will overwrite
  " any other messages in this space including e.g. ALE linting messages.
  autocmd CursorHold *.cs OmniSharpTypeLookup

  " The following commands are contextual, based on the cursor position.
  autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfu <Plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfi <Plug>(omnisharp_find_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
  autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
  autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

  " Find all code errors/warnings for the current solution and populate the quickfix window
  autocmd FileType cs nmap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)
  " Contextual code actions (uses fzf, vim-clap, CtrlP or unite.vim selector when available)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  autocmd FileType cs xmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  " Repeat the last code action performed (does not use a selector)
  autocmd FileType cs nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
  autocmd FileType cs xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)

  autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osnm <Plug>(omnisharp_rename)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
augroup END

" Enable snippet completion, using the ultisnips plugin
" let g:OmniSharp_want_snippet=1

" Set coc default LSP
let g:coc_global_extensions=[ 'coc-omnisharp', 'coc-python', 'coc-go', 'coc-rls', 'coc-sh' ]

" (Optional)Hide Info(Preview) window after completions
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"""""" End Plugin configs


"""""" User preferences

syntax on
filetype plugin indent on
set nocp
set autoindent
set fileformat=unix

"highlight clear ALESignColumn
"highlight clear SignColumn

"formatting for yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

"Setting gutter numbers
set relativenumber
set number

"Make Explore open without a banner
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_browse_split = 4

"Add quality of life
set expandtab
set autoread
set mouse=a
set signcolumn=yes
set clipboard=unnamedplus
set tags=tags;

"Wrap paragraphs in vim with soft line breaks
set fo+=w


"Keybindings
"open terminal at bottom:
nnoremap <unique> ,t :bot term ++rows=10<CR>

"Paste on
nnoremap <unique> ,p :set paste<CR>
nnoremap <unique> ,P :set nopaste<CR>

"Highlight search
nnoremap <unique> ,ho :set hls<CR>
nnoremap <unique> ,hO :set nohls<CR>

