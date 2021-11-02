" Author: Michael Ciociola
" License: GPLv3

" GPLv3 License

" Set leader
let mapleader="\<SPACE>"

" Vim setting
set background=dark "Set dark background
set cmdheight=2 "Better display for messages
set confirm "Sane prompting for file saving
set expandtab "Replace tabs with spaces
set hidden "Allow hidden buffers
set ignorecase "Ignore case during searching
set lazyredraw "Do we still need this for nvim?
set mouse=a "Enable all mouse functionality
set nojoinspaces "Avoid double spaces when joining
set nostartofline "Do not jump to first character with page commands.
set shell=/usr/bin/zsh
set signcolumn=yes "Always show signcolumns
set splitbelow splitright "Natural splitting
set switchbuf=useopen
set updatetime=300 "Smaller updatetime for CursorHold & CursorHoldI
set visualbell "Visual

set number
set relativenumber "Line numbering

set undodir=~/.local/share/nvim/undodir
set undofile

if !&scrolloff
    set scrolloff=3 " Show next 3 lines while scrolling.
endif
if !&sidescrolloff
    set sidescrolloff=5 " Show next 5 columns while side-scrolling.
endif

if has('termguicolors')
    set termguicolors
    let g:terminal_color_background="#1e1f28"
endif

" Plugin Collection
filetype indent on
call plug#begin('~/.local/share/nvim/plugged')
" Interface
" Plug 'christoomey/vim-tmux-navigator' " Makes vim splits work nicely with tmux

" Programming
let g:gutentags_enabled=0
Plug 'ludovicchabant/vim-gutentags' " vim tag auto creation
Plug 'ap/vim-css-color'             " show color in css

" Editing and Formatting
Plug 'machakann/vim-sandwich'
Plug 'masukomi/vim-markdown-folding'

" Nerdtree
Plug 'scrooloose/nerdtree'      " Nerd TRee

" Themeing
Plug 'itchyny/lightline.vim' " status bar
Plug 'junegunn/goyo.vim'
Plug 'cseelus/vim-colors-lucid'

" Language and Linting
" Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'
" Plug 'jeetsukumaran/vim-pythonsense'

" Git
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter' " show git status in gutter

" tpope
Plug 'tpope/vim-commentary' " easy commenting
Plug 'tpope/vim-fugitive'   " the pope collection
Plug 'tpope/vim-repeat'     " allow plugins to repeat
Plug 'tpope/vim-sensible'   " sensible defaults
Plug 'tpope/vim-unimpaired' " handy bracket mappings

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Completions
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
call plug#end()

" native plugins
packadd cfilter
packadd termdebug

colorscheme lucid

" navigation mappings
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
imap uh <Esc>
imap hu <Esc>

" Function Mappings
" nnoremap <F1> :set invpaste paste?<CR>
" nnoremap <F2> :Gstatus<CR>
" nnoremap <F3> :Gdiff <CR>
" nnoremap <F4> :Nuake<CR>
" inoremap <F4> <C-\><C-n>:Nuake<CR>
" tnoremap <F4> <C-\><C-n>:Nuake<CR>
" nnoremap <F5> :TagbarToggle<CR>
nnoremap <F6> :make<CR>

" Use ctrl-[hjkl] to select the active split!
nnoremap <silent> <c-k> :wincmd k<CR>
nnoremap <silent> <c-j> :wincmd j<CR>
nnoremap <silent> <c-h> :wincmd h<CR>
nnoremap <silent> <c-l> :wincmd l<CR>

" Terminal
nnoremap <leader>t :vs \| term<cr>
tnoremap <leader>uh <C-\><C-n>
tnoremap <leader>hu <C-\><C-n>
tnoremap <leader><esc> <C-\><C-n>
let g:neoterm_autoscroll=1

" Terminal mode split navigation
tnoremap <silent> <c-k> <C-\><C-N> :wincmd k<CR>
tnoremap <silent> <c-j> <C-\><C-N> :wincmd j<CR>
tnoremap <silent> <c-h> <C-\><C-N> :wincmd h<CR>
tnoremap <silent> <c-l> <C-\><C-N> :wincmd l<CR>

" quit and save shortcuts
nnoremap <leader>q :q<cr>
nnoremap <leader>w :wa<cr>

" Fugitive mappings
nnoremap <Leader>g :Gstatus<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gp :Gpush<CR>
nnoremap <Leader>gd :Gdiff<CR>

" Insert Date
nnoremap <Leader>rd :r !date<CR> kJ
nnoremap <Leader>rdt :r !date<CR> kJd4w
nnoremap <Leader>rds :r !date "+\%Y-\%m-\%d"<CR> kJ

" Spelling
nnoremap <leader>sp :set spell<CR>
nnoremap <leader>s ]s
nnoremap <leader>f 1z=

" Line numbers
" nnoremap <leader>n :set nonumber!<CR>
" nnoremap <leader>rn :set norelativenumber!<CR>

" Clear highlighting
nnoremap <leader>c :nohl<CR>

" vimrc
nnoremap <Leader>vs :source $MYVIMRC<CR>
nnoremap <Leader>ve :e $MYVIMRC<CR>
nnoremap <Leader>vd :e ~/Development/Suckless/dwm/config.h<CR>
nnoremap <Leader>vx :e ~/.xinitrc<CR>

" buffer local binds
nnoremap <Leader>cd :lcd %:p:h:pwd

" Clipboard functionality (paste from system)
vnoremap <leader>y "+y
nnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p

" Nerd Tree
nnoremap <leader>n :NERDTreeToggle<cr>

" FZF
nnoremap <leader>f :Files<cr>
nnoremap <leader>ft :Tags<cr>
nnoremap <leader>b :Buffers<cr>
let g:fzf_buffers_jump = 1

" Windows and Buffers
nnoremap <leader>d :bd<cr>
nnoremap <silent>vv <C-w>v

" Deoplete
let g:deoplete#enable_at_startup = 1

" Lightline
let g:lightline = {
            \ 'colorscheme': 'default',
            \ 'active': {
            \       'left': [ [ 'mode', 'paste' ],
            \                           [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component_function': {
            \       'gitbranch': 'fugitive#head'
            \ },
            \ }
let g:lightline.colorscheme = 'darcula'

"Ale
let g:ale_fixers = {
            \       'python': [
            \               'black',
            \               'isort',
            \       ],
            \}
let g:ale_linters = {
            \ 'python': ['pylint', 'mypy'],
            \}
let g:ale_fix_on_save = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" Searching
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
endif

" Prefer ripgrep to Ag
if executable('rg')
    set grepprg=rg\ --vimgrep
    command! -nargs=+ -complete=file -bar Rg silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Rg<SPACE>
endif
nnoremap <leader>k :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Plugged
command! PlugUpgrade PlugClean | PlugUpdate

" Terminal
function s:TerminalConf()
    if &buftype !=# 'terminal'
        return
    endif
    setlocal nolist
    setlocal nonumber
    setlocal norelativenumber
    setlocal colorcolumn=
    setlocal nospell
    setlocal keywordprg=:below\ Man
endfunction

augroup TerminalMode
    autocmd!
    autocmd TermOpen * call s:TerminalConf()
augroup end

augroup AutoFileTypeSettings
    autocmd!
    autocmd FileType c,cpp,java,php,python,sh,make,markdown autocmd BufWritePre * %s/\s\+$//e
    autocmd FileType make setlocal noexpandtab
    autocmd FileType markdown set foldexpr=NestedMarkdownFolds()
augroup end

augroup AutoSaveFolds
    autocmd!
    autocmd BufWinLeave,BufLeave,BufWritePost ?* nested silent! mkview!
    autocmd BufWinEnter ?* silent! loadview
augroup end

augroup AutoResize
    autocmd!
    autocmd VimResized * :wincmd =
augroup end

function! s:DiffWithSaved()
    let filetype=&filetype
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe 'setlocal bt=nofile bh=wipe nobl noswf ro ft=' . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()
