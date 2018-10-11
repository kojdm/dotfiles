" Install vim-plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug plugins go in here
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'sharkdp/fd'
Plug 'tpope/vim-fugitive'
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'andymass/vim-matchup'

call plug#end()

" vim config
set cursorline " Need to use vim 8.1+ because https://github.com/vim/vim/issues/2584
set expandtab
set hidden
set hlsearch
set list
set listchars=tab:»·
set listchars+=trail:·
set listchars+=extends:»
set listchars+=precedes:«
set noswapfile
set nowrap
set number
set shiftwidth=2
set tabstop=2

" vim status line
set laststatus=2

function! FilePath()
  return expand('%') !=# '' ? expand('%') : '[No Name]'
endfunction

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'paste', 'gitbranch' ],
      \             [ 'readonly', 'filepath', 'modified' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'paste', 'gitbranch' ],
      \             [ 'readonly', 'filepath', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'filepath': 'FilePath'
      \ }
      \ }

" vim window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Hide highlighting of current search results
nnoremap <silent> <CR> :nohlsearch<CR>

" nerdtree config
map <C-n> :NERDTreeToggle<CR>

" fzf config
nnoremap <C-p> :Files<CR>
let $FZF_DEFAULT_COMMAND = "fd --type file --hidden --no-ignore --exclude '{.git,node_modules,vendor,build,tmp}'"

" silversearcher-ag config
nnoremap <C-f> :Ag<Space>

" onedark.vim config

" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
" If you're using tmux version 2.2 or later, you can remove the outermost
" $TMUX check and use tmux's 24-bit color support
" (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more
" information.)
if (empty($TMUX))
  if (has("nvim"))
    " For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  " For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  " Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

syntax on
colorscheme onedark

" vim-matchup config
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_hi_surround_always = 1

hi MatchParen ctermfg=green
