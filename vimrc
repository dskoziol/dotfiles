" this executes any plugins you've put in ~/.vim/bundle using pathogen
execute pathogen#infect()

" Plugins I use:
"  Ag - project-wide search
"    :Ag "search this string"
"    :Ag \\\#id-name   <-- # need a triple escape for some crazy reason
"    :Ag \\%header     <-- % need a double escape for some crazy reason
"    :Ag \\.class-name <-- . need a double escape for some crazy reason
"  ctrlp.vim - fuzzy file search
"    <Ctrl-p> Then start doing your fuzzy search
"  tabular - vertically line up around the pattern used
"    :/:\zs this command lines up everything after ':', useful in css files
"  vim-commentary - adds language-specific comments
"    gcc comments out current line
"  vim-fugitive
"    :Gdiff nice diff inside Vim
"    :Gstatus
"    :Gblame
"  vim-gitgutter - shows changed lines in left column, compared to git repo
"  vim-indent-guides
"    \ig  Use this when you want to see how columns line up
"  vim-rails
"  vim-repeat
"  vim-sensible
"  vim-surround
"    cs'" changes surrounding 's to "s
"    cs([ changes surrounding (s to [s

"Use `:h 'autoindent'` to search vim's help for 'autoindent'

" keep this in to use all vim's features
set nocompatible

" gives a 'sensible' starting point for vim config
runtime! plugin/sensible.vim

" turn filetype detection, indent scripts and filetype plugins on
" and syntax highlighting too
filetype plugin indent on
syntax on

" line numbers. You probably don't want 'relativenumber'
set number
" set relativenumber

" Cursor turns to vertical line in insert mode
if &term =~ '^xterm'
  let &t_SI .= "\<Esc>[5 q"
  let &t_EI .= "\<Esc>[1 q"
  " 1 or 0 -> blinking block
  " 3 -> blinking underscore
  " Recent versions of xterm (282 or above) also support
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar
endif

let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" tabs are made up of spaces with 'tabstop' width
set expandtab
set tabstop=2

" correct indenting for file type, 'shiftwidth' width
set autoindent
set smartindent
set shiftwidth=2
set shiftround

" highlight current line, previous searches
set cursorline
set hls
set incsearch

" ignore case by default unless search contains uppercase letters
set smartcase

" undo history length
set history=500

" keeps buffers open when you switch to a different file
set hidden

" sensible titling of current window
set title

" keep track of files that have changed outside of vim
set autoread

" allows you to press '%' to move to matching (,[,<,{, or html tag
runtime macros/matchit.vim

" more colors
set t_Co=256
set background=dark

" keeps vim swap files outside of the current project
set backupdir=~/.vim/backup/
set directory=~/.vim/swap/
set undodir=~/.vim/undo/

" great file search plugin
set runtimepath^=~/.vim/bundle/ctrlp.vim

" '-' and '_' both separate vim words
set iskeyword-=_

" indents lines that wrap
set wrap breakindent
set showbreak=\ \ \ \ " Sets four blank spaces as wrap indent

" color tweak for gitgutter plugin
highlight clear SignColumn

" Trim whitespace at the end of every line on save
autocmd BufWritePre * :%s/\s\+$//e

" Trim empty lines at the end of the file on save
function TrimEndLines()
    let save_cursor = getpos(".")
    :silent! %s#\($\n\s*\)\+\%$##
    call setpos('.', save_cursor)
endfunction
au BufWritePre * call TrimEndLines()

" Make :grep use The Silver Searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --column
  set grepformat=%f:%l:%c%m
endif
