	"Default settings"

"Turn on auto indent in C-style"
set cindent

"Turn on line numbers"
set number

"Break lines only on whitespaces (handy for text editing)"
set linebreak

"Enable search highlighting"
set hlsearch
"Hide highlighting on CTRL-8"
map <S-F8> <ESC>:noh<CR>
imap <S-F8> <ESC>:noh<CR>
"set incsearch
"set smartcase

"Do not create swap files"

set noswapfile

"Turn on syntax highlighting"
syntax on

"History size for commands and search patterns"
set history=64

"Maximum number of changes that can be undone"
set undolevels=1000

"Set an ability to undo after file is writen and set a dir for undo file"
if version >= 703
    set undofile
    set undodir=~/.vim/undodir/
endif

	"Auto indents settings"

"Replace TAB with spaces"
set expandtab
"4 columns indent for auto indents"
set shiftwidth=4
"Replace tab with 4 spaces"
set softtabstop=4

"Set tab width=8
"set tabstop=8

set colorcolumn=90

	"Useful mappings"

"Save the file"
map <F5> <ESC>:w<CR>
imap <F5> <ESC>:w<CR>

"Save all opened files (in tabs)"
map <S-F5> <ESC>:wa<CR>
imap <S-F5> <ESC>:wa<CR>

"Save and exit"
map <F10> <ESC>:x<CR>
imap <F10> <ESC>:x<CR>

"Exit without saving"
map <F12> <ESC>:q<CR>
imap <F12> <ESC>:q<CR>

"Exit from edited file without saving"
map <F8> <ESC>:q!<CR>
imap <F8> <ESC>:q!<CR>

"Jump by lines as it seen on screen (not \n representation)"
map <UP> g<UP>
map <DOWN> g<DOWN>


	"Different modes"

"Turn on/off paste mode (do not process auto indents)"
map <F3> <ESC>:set paste!<CR>
imap <F3> <ESC>:set paste!<CR>

"Turn on/off number lines"
map <F2> <ESC>:set number!<CR>
imap <F2> <ESC>:set number!<CR>

"Turn on/off wrapping"
map <F4> <ESC>:set wrap!<CR>
imap <F4> <ESC>:set wrap!<CR>

	"Spell checker options"

"Turn on/off spell checking"
map <F7> <ESC>:setlocal spell! spelllang=en_us<CR>
imap <F7> <ESC>:setlocal spell! spelllang=en_us<CR>
"Find next bad spelled word"
map <C-F7> ]s
imap <C-F7> <ESC>]si
"Suggest a correct spell"
map <S-F7> z=
imap <S-F7> <ESC>z=

	"Useful functions"

"Show a full path to the open file"
cabbrev ffile echo expand('%:p')

"Delete odd spaces befor EOL"
cabbrev delete_spaces %s/\s\+$//

        "For pathogen usage"
call pathogen#infect()
call pathogen#helptags()

        "Autogen ctags on file write"

function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction

function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let cmd = 'ctags -a -f ' . tagfilename . ' --c++-kinds=+p --fields=+iaS --extra=+q ' . '"' . f . '"'
  call DelTagOfFile(f)
  let resp = system(cmd)
endfunction
autocmd BufWritePost *.cpp,*.h,*.c,*.cc call UpdateTags()
