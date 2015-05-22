set nocompatible               " be iMproved
filetype off                   " required!
syntax on

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'vim-perl/vim-perl'
Bundle 'altercation/vim-colors-solarized'
Bundle 'vim-scripts/bufexplorer.zip'
Bundle 'scrooloose/nerdtree'
Bundle 'derekwyatt/vim-scala'
Bundle 'tpope/vim-surround'
Bundle 'dart-lang/dart-vim-plugin'
Bundle 'wting/rust.vim'
Bundle 'tpope/vim-fireplace'
Bundle 'guns/vim-clojure-static'
Bundle 'guns/vim-clojure-highlight'
" vim-scripts repos
Bundle 'L9'

filetype plugin indent on     " required!

autocmd ColorScheme * highlight TrailingWhitespace ctermbg=red guibg=red
au InsertEnter * match TrailingWhitespace /\s\+\%#\@<!$/
au InsertLeave * match TrailingWhitespace /\s\+$/
au BufWinEnter * match TrailingWhitespace /\s\+$/

au BufNewFile,BufRead *.rs set filetype=rust
au BufNewFile,BufRead *.dart set filetype=dart
au BufNewFile,BufRead *.psgi set filetype=perl
au BufNewFile,BufRead *.pm6 set filetype=perl6
au BufNewFile,BufRead *.pl6 set filetype=perl6
au BufNewFile,BufRead *.scala set filetype=scala

let loaded_matchparen=1

set autoindent showmatch
set noincsearch nobackup nocindent hlsearch visualbell
set indentexpr=""
set formatoptions=""
set scrolloff=3
set tabstop=4 shiftwidth=4 expandtab shiftround smarttab
set tabpagemax=666
set confirm
set errorfile=.vimerrors.err

" \tt : switch to tt2 syntax
nnoremap <Leader>tt :set syntax=tt2<CR>

" \dp : insert Data::Printer line
nnoremap <Leader>dp ouse Data::Printer; p<SPACE>

" \pp Toggle :set paste
nnoremap <Leader>pp :set paste!<CR>

" \S : delete all trailing whitespace
nnoremap <Leader>S :%s/\s\+$//<CR>

" \ds: convert double to single quotes
nmap <Leader>ds cs"'

" \sd : convert single to double quotes
nmap <Leader>sd cs'"

" \sq : surround with single quotes
nmap <Leader>sq yss'

" \dq : surround with double quotes
nmap <Leader>dq yss"

" NerdTREE next tab
nnoremap <Leader>- :tabn<CR>

let g:solarized_termtrans=1
colorscheme solarized
filetype on
