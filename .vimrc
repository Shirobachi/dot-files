syntax on
set tabstop=4 softtabstop=4
set shiftwidth=4 expandtab
set smartindent
set number "relativenumber
" call RltvNmbr#RltvNmbrCtrl(1)
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undoLogs
set undofile
set incsearch
set cursorline
set scrolloff=5
set so=999
set colorcolumn=100
let g:auto_save = 1  " enable AutoSave on Vim startup
set clipboard=unnamedplus

map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" toggle changes
nnoremap <C-E> :UndotreeToggle<CR>:wincmd h<CR>

" alias for closing vim
command WQ wq
command Wq wq
command W w
command Q q

" split aliases
noremap <bar> :vsplit<CR>
noremap _ :split<CR>

" changing windows aliases
noremap <C-left> :wincmd h<CR> 
noremap <C-right> :wincmd l<CR> 
noremap <C-down> :wincmd j<CR> 
noremap <C-up> :wincmd k<CR> 

" move faster aliases
noremap H :-10<CR>
noremap L :+10<CR>
noremap J :+5<CR>
noremap K :-5<CR>
noremap <PageUp> :-5<CR>
noremap <PageDown> :+5<CR>

" Ctrl-P
noremap <C-p> :CtrlPBuffer<CR>

" Remember file position on exit
"source $VIMRUNTIME/vimrc_example.vim


":Vexplore
" Remove working arrows
"cnoremap <Down> <Nop>
"cnoremap <Left> <Nop>
"cnoremap <Right> <Nop>
"cnoremap <Up> <Nop>
"inoremap <Down> <Nop>
"inoremap <Left> <Nop>
"inoremap <Right> <Nop>
"inoremap <Up> <Nop>
"nnoremap <Down> <Nop>
"nnoremap <Left> <Nop>
"nnoremap <Right> <Nop>
"nnoremap <Up> <Nop>
"vnoremap <Down> <Nop>
"vnoremap <Left> <Nop>
"vnoremap <Right> <Nop>
"vnoremap <Up> <Nop>

