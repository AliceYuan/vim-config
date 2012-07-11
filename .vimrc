" Alice Yuan's awesome vimrc :3
" Last Updated: May 20 2012



" Credits to  http://amix.dk/vim/vimrc.html for original vimrc configurations
" (Some configs have been altered)



" Plug-ins used:
" 1. Pathogen  -for making organizing & installing plug ins easier
" 2. NERDTree - awesome file management system
" 3. SuperTab - Auto complete made easy
" 4. Syntastic - syntax checker for many languages


" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Pathogen Initialization
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This loads all the plugins in ~/.vim/bundle
" Use tpope's pathogen plugin to manage all other plugins

runtime bundle/autoload/pathogen.vim
call pathogen#infect()
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=2000

" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>
" Save by ctrl-s (I know I cheat ): )
map <C-s> :w!<CR>
" if in insert mode go back to insert mode
imap <C-s> <Esc>:w!<CR>


" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc

" Automatically cd into the directory that the file is in  (don't like this)
" autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set showcmd    "Show incomplete cmds down the bottom
set gcr=a:blinkon0              "Disable cursor blink


" Set 7 lines to the curors - when moving vertical..
set so=7

set wildmenu "Turn on WiLd menu

set ruler "Always show current position

set cmdheight=2 "The commandbar height

set hid "Change buffer - without saving

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching
set smartcase

set hlsearch "Highlight search things

set incsearch "Make search act like search in modern browsers
set nolazyredraw "Don't redraw while executing macros

set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set lines=100 columns=150        "set height and width of vim


set scrolloff=10         "Start scrolling when we're 10 lines away from margins
set sidescrolloff=15
set sidescroll=1

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"Opens URL in brower
function! Browser ()
   let line = getline (".")
   let line = matchstr (line, "http[^   ]*")
   exec "!konqueror ".line
endfunction



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

set cul " highlight current line
set number  "show line numbers


if has("gui_running")  "if gvim is running then:
  set guioptions-=T
  set t_Co=256
  set background=dark
  colorscheme zenburn
else
  set t_Co=256
  set background=dark
  colorscheme zenburn
endif


set encoding=utf8
try
    lang en_US
catch
endtry

set ffs=unix,dos,mac "Default file types


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab "tabs into spaces
set shiftwidth=2 "size of tabs
set tabstop=2
set smarttab

set lbr
set tw=500

set ai "Auto indent
set cindent "complex indent
set wrap "Wrap lines





""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

"Git branch
function! GitBranch()
    try
        let branch = system("git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* //'")
    catch
        return ''
    endtry

    if branch != ''
        return '   Git Branch: ' . substitute(branch, '\n', '', 'g')
    en

    return ''
endfunction


function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction


"Current Directory Path
function CurDir()
    return substitute(getcwd(), '/Users/amir/', "~/", "g")
endfunction

" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L%{GitBranch()}



""""""""""""""""""""""""""""""
" => Backup
"""""""""""""""""""""""""""""""
set nobackup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Smart way to move btw. windows maps switch windows to ctrl-h/j/k/l
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Use the arrows to something useful
map <right> :bn<cr>
"next buffer/ prv buffer
map <left> :bp<cr>

" Tab configuration
map <leader>tn :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>


command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Specify the behavior when switching between buffers
try
  set switchbuf=usetab
  set stal=2
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"Shortcuts using <leader>
map <leader>sn ]s
"next wrongly spelt word
map <leader>sp [s
"prv word
map <leader>sa zg
"ignore spelling
map <leader>s? z=
"give suggestions



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1

"Surround
autocmd FileType php let b:surround_45 = "<?php \r ?>"
autocmd FileType html let b:surround_45 = "<?php \r ?>"
"php tag mapped to '-'

"Tagbar
nmap <leader>t :TagbarToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
