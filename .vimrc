set encoding=utf-8              " character encoding used in vim
scriptencoding utf-8            " character encoding used in this script (must be placed after the encoding option)

" code folding
" zo: open fold under cursor
" zc: close folder under cursor
" zR: open all folds
" zM: close all folds

" GENERAL SETTINGS ---------------------------------------------------------------- {{{

" base options
set nocompatible                " disable vi compatibility (influences other options)
filetype plugin on              " load plugin files for specific file types (enables filetype detection)
filetype indent on              " load indent file for specific file types (enables filetype detection)
syntax on                       " enable syntax highlighting

" line numbers and white space
set number                      " display line numbers on the left
set relativenumber              " show relative line numbers on the left
set shiftwidth=2                " number of spaces that <Shift> counts for
set tabstop=2                   " number of spaces that <Tab> counts for
set softtabstop=2                   " number of spaces that <Tab> counts for
set expandtab                   " use spaces instead of tabs
set smartindent                 " use smart autoindenting when starting new lines
set scrolloff=8                 " do not let the cursor scroll below or above N lines when scrolling

" Search options
set hlsearch                    " hight search results
set incsearch                   " highlight matching chracters incrementally during typing a search term
set ignorecase                  " dont distinguish between small and capital letters during search
set smartcase                   " overwrite ignorecase option if searching for capital letters

" misc
set hidden                      " allow changing buffers with unsaved changes
set history=1000                " amount of commands to keep (default: 50)
" set mouse=a                     " enable mouse support in all modes
set mouse=                      " disable the bloody mouse
set splitbelow                  " open new split panes on bottom (instead of top)
set splitright                  " open new split panes to the right (instead of left)
set clipboard=unnamedplus
" }}}

" INSTALL PLUGINS ---------------------------------------------------------------- {{{

" Install plugin manager 'vim-plug' and install all plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
" Plug 'username/plugin-name' on GitHub

" GIT
Plug 'airblade/vim-gitgutter'               " Git status next to numbers

" SEARCHING
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Fuzzy finder
Plug 'junegunn/fzf.vim'                     " Fuzzy finder vim -> searching files
Plug 'mileszs/ack.vim'                      " Ack Searching (needed for Ag)

" AUTOCOMPLETION
if has('nvim')
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  " sudo pip3 install pynvim
  " Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
" Plug 'deoplete-plugins/deoplete-tag'        " Load c-tag files

" MISC
" Plug 'jiangmiao/auto-pairs'                 " Insert or delete brackets, parens, quotes in pair
Plug 'joker1007/vim-ruby-heredoc-syntax'    " Syntax highlighting in Ruby here document code blocks
Plug 'joshdick/onedark.vim'                 " Color schema
Plug 'preservim/nerdtree'                   " Tree view file explorer
Plug 'tpope/vim-commentary'                 " Allows easy commenting
Plug 'tpope/vim-dadbod'                     " Execute DB queries
Plug 'tpope/vim-endwise'                    " Automatically add end if needed
Plug 'tpope/vim-fugitive'                   " Git support for vim
Plug 'tpope/vim-rails'                      " Rails support for vim
Plug 'tpope/vim-surround'                   " Surround text with certain characters

" TODO: Cleanup
Plug 'junegunn/vim-easy-align'
Plug 'vim-airline/vim-airline'              " Statusbar at the top
Plug 'vim-airline/vim-airline-themes'
" Plug 'aserebryakov/vim-todo-lists'          " Todo list handling for .todo.md files
Plug 'isruslan/vim-es6'                     " ES6 highlighting
" Plug 'dense-analysis/ale'

Plug 'kristijanhusak/vim-packager', { 'type': 'opt' }
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'

" show indentation line
Plug 'Yggdroot/indentLine'

" open most recent files
Plug 'yegappan/mru'

" :source ~/.vimrc
" " :PlugInstall

call plug#end()

" }}}

" CUSTOM MAPPINGS --------------------------------------------------------------- {{{

" set prefix key (backslash is the default)
let mapleader = " "

" GENERAL MAPPINGS

" German spell check with aspell-de
map <F7> :w!<CR>:!aspell check %<CR>:e! %<CR>

map <F8>  :setlocal spell spelllang=de <return>
map <F9>  :setlocal spell spelllang= <return>

" search and replace selected text
" overwrites the h register
" use n (next) or y (yes replace)
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" open file and bufferlist
nnoremap <leader>o :Files<CR>
nnoremap <leader>b :Buffer<CR>

" edit and source my vimrc file
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

" edit and source my bahsrc file
:nnoremap <leader>eb :vsplit $HOME/.bashrc<cr>
" :nnoremap <leader>sb :source $MOME/.bashrc<cr>

" zoom in/out in split windows
noremap Zz <c-w>_ \| <c-w>\|
noremap Zo <c-w>=

" search selected text in file 
vnoremap <leader>f y/\V<C-R>=escape(@",'/\')<CR><CR>

" surround word under cursor with double quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

" go to previous/next buffer
map <F2> :bprevious<CR>
map <F3> :bnext<CR>

" toggle search match highlight
let hlstate=0
silent! nnoremap <F4> :if (hlstate == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=1-hlstate<cr>

" toggle between relative and sbsolute line numbers
silent! nmap <F5> :set relativenumber!<CR>

" allow closing buffer without closing split
command Bd bp | sp | bn | bd
nnoremap <leader>q :Bd<CR>

" open vim-powered terminal in split window
noremap <Leader>t :term ++close<cr>
tnoremap <Leader>t <c-w>:term ++close<cr>

" open vim-powered terminal in new tab
noremap <Leader>T :tab term ++close<cr>
tnoremap <Leader>T <c-w>:tab term ++close<cr>

inoremap jj <esc>

" resize windows
" https://vim.fandom.com/wiki/Resize_splits_more_quickly
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

" }}}

" CONFIGURE PLUGINS --------------------------------------------------------------- {{{

" GIT
"
" Plugin: airblade/vim-gitgutter
set updatetime=100 " Set update between git line status
noremap <leader>gh <Plug>(GitGutterNextHunk)
noremap <leader>gH <Plug>(GitGutterPrevHunk)
noremap <leader>gb :Git blame<CR>
" hs: stage hunk
" hu: undo hunk
" hp: preview hunk

" SEARCHING
" Plugin: junegunn/fzf.vim
" Plugin: mileszs/ack.vim
if executable('ag')
    " Set search provider to the silver searcher
    let g:ackprg = 'ag --vimgrep'
endif
" normal search
nnoremap <leader>f :Ack!<Space>
" search word under cursor 
nnoremap <leader>F :Ack!<Space>-Q<Space>'<c-r>=expand("<cword>")<cr>'<Space>-w
" search selected sequence in visual mode
vnoremap <leader>F y:Ack!<Space>-Q<Space>"<c-r>=escape(@",'/\')<cr>"

" AUTOCOMPLETION
" Plugin: Shougo/deoplete.nvim
" enable autocompletion
" let g:deoplete#enable_at_startup = 1
" select next entry with tab
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" Plugin: deoplete-plugins/deoplete-tag
" Load ctags to autocompletion sources
" let deoplete#tag#cache_limit_size = 5000000
" call deoplete#custom#source('_', 'matchers', ['buffer', 'tag'])
"

" MISC
" Plugin: jiangmiao/auto-pairs
" Plugin: joker1007/vim-ruby-heredoc-syntax
" edit HAML inside ruby classes with proper syntax highlight
let g:ruby_heredoc_syntax_filetypes = {
  \ "haml" : {
  \   "start" : "HAML",
  \},
\}
 let g:autoclose_on = 0
 let g:AutoPairs = {}


" Plugin: joshdick/onedark.vim
" Plugin: preservim/nerdtree
" toggle nerd tree
noremap <C-n> :NERDTreeToggle %<CR>
" noremap <C-m> :NERDTreeFind<CR>
"
" Plugin: tpope/vim-commentary
" toggle line comment
noremap § :Commentary<CR>
" Plugin: tpope/vim-dadbod
" Plugin: tpope/vim-endwise
" Plugin: tpope/vim-fugitive
" Plugin: tpope/vim-rails
" Plugin: tpope/vim-surround


" settings for mru
let MRU_Use_Current_Window = 1
nnoremap <C-l> :MRUToggle<CR>

" settings for indetLine
let g:indentLine_char = '|'

" }}}

" VIMSCRIPT -------------------------------------------------------------- {{{

" Enable code folding (using the marker method of folding)
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

" More Vimscripts code goes here.

" MRU tab switching
" let g:mru_tabs = []
" let g:current_mru_index = -1

" function! UpdateMRUTab()
"   let g:current_mru_index += 1
"   let l:current_tab = tabpagenr()
"   call remove(g:mru_tabs, index(g:mru_tabs, l:current_tab))
"   call insert(g:mru_tabs, l:current_tab, g:current_mru_index)
"   while len(g:mru_tabs) > tabpagenr("$")
"     call remove(g:mru_tabs, -1)
"   endwhile
" endfunction

" nnoremap <silent> <C-Tab> :call GoToMRUTab(1)<CR>
" nnoremap <silent> <C-S-Tab> :call GoToMRUTab(-1)<CR>

" function! GoToMRUTab(direction)
"   if g:current_mru_index + a:direction < 0 || g:current_mru_index + a:direction >= len(g:mru_tabs)
"     return
"   endif
"   let g:current_mru_index += a:direction
"   execute "tabnext" . g:mru_tabs[g:current_mru_index]
" endfunction

" augroup MRUTabSwitching
"   autocmd!
"   au TabLeave * call UpdateMRUTab()
" augroup END



" }}}

" MISC -------------------------------------------------------------- {{{

" Use % to bounce from 'do' to 'end', '(' to ')' etc.
" Load the version of matchit.vim that ships with Vim.
runtime! macros/matchit.vim

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:␣

" set color scheme
set termguicolors
colorscheme onedark
" unset background color in gui and terminal
highlight Normal guibg=NONE ctermbg=NONE
" color line numbers
highlight LineNrAbove guifg=#4B5263
highlight LineNr term=NONE ctermfg=238 guifg=Gray
highlight LineNrBelow guifg=#4B5263
" color comments
" highlight Comment term=bold ctermfg=59 guifg=#5C6370
highlight Comment guifg=#a3aab5

" Auto indent files 
augroup myfiletypes
  autocmd!
  autocmd FileType ruby,eruby,yaml set autoindent sw=2 sts=2 expandtab
  " autocmd BufNewFile,BufRead *.axlsx set autoindent syntax=ruby sw=2 sts=2 expandtab
augroup END

" Use markdown syntax highlighting in SDoc files
augroup filetype_sdoc
  autocmd!
  autocmd BufNewFile,BufFilePre,BufRead *.sdoc set syntax=markdown
augroup END





" TODO: Cleanup

" Set formatting options
" set textwidth=80
" autocmd FileType gitcommit setlocal tw=72
set formatoptions-= "qlfa"


" line numbers
highlight CursorLineNr ctermbg=7 ctermfg=9
highlight QuickFixLine ctermbg=NONE

" FZF (Searching and opening files)
" default is the systmes's `find` command
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
nnoremap <c-p> :FZF<cr>
augroup fzf
  autocmd!
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
        \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END
" use :Ag or :Ag!
" command! -bang -nargs=* Ag
" \ call fzf#vim#ag(<q-args>,
" \                 <bang>0 ? fzf#vim#with_preview('up:60%')
" \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
" \                 <bang>0)
command! -bang -nargs=* Ag
      \ call fzf#vim#grep(
      \   'ag --column --numbers --noheading --color --smart-case '.shellescape(<q-args>), 1,
      \   fzf#vim#with_preview(), <bang>0)
" map <C-g> :Ag
nnoremap <C-g> :Ag<Space><c-r>=expand("<cword>")<cr>


" function! RipgrepFzf(query, fullscreen)
"   let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
"   let initial_command = printf(command_fmt, shellescape(a:query))
"   let reload_command = printf(command_fmt, '{q}')
"   let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
"   call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
" endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Airline (Tab and buffer overview bar)
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_powerline_fonts = 1
let g:airline_theme = 'dark'


" Airline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linen = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'

let g:airline_left_sep = ''
let g:airline_left_sep_alt_sep = '|'
let g:airline_right_sep = ''
let g:airline_right_alt_sep = '|'

" autocmd FileType ruby setlocal commentstring=#\ %s

" Map Y to have the same behaviour as D and C
map Y y$

" Ctags
" generate ctags recursively in current directory 
" ctags -R .
" # navigation
" nnoremap <leader>t <C-]>
" Jump to definition with ,t
" Jump back with ctrl + t
" Commands
" :tag <tag-name>
" :tnext
" :tprev
" :tfirst
" :tlast
" :tselect
" :tags
"
"


" Don not move done todo items to the bottom of the list
" let g:VimTodoListsMoveItems = 0

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

let g:dbs = {
      \  'lexwork': 'mysql://root:@127.0.0.1:3307/lexwork'
      \ }

" }}}

:nmap <F1> :echo<CR>
:imap <F1> <C-o>:echo<CR>
