"
" Copyright (C) 2011 Gonzague Reydet.
"
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"      http://www.apache.org/licenses/LICENSE-2.0
"
" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS,
" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" See the License for the specific language governing permissions and
" limitations under the License.
"

"
" Global variables
"

" Path to an optional vimrc file to add custom or system dependant properties
let customVimrcFilePath= expand("$HOME/.vimrc.custom")

"
" Misc configuration
"

" Add internal vim script folder in vim runtimepath
" For this to work the repository must have been cloned in a vimrc folder in the user home directory
if filereadable(expand("$HOME/vimrc/vimrc"))
    let &runtimepath=&runtimepath.','.expand("$HOME/vimrc/vim")
endif
set noswapfile          " Do not create any swap file for openned files

"
" Buffer configuration
"

set hidden              " Put buffers to background instead of closing it
set switchbuf=useopen   " If a buffer is already opened in another window, switch to this window
" Press F5 to switch on another buffer
nnoremap <F5> :buffers<CR>:buffer<Space>
" Press Shift+F5 to open a new window on another buffer
nnoremap <S-F5> :buffers<CR>:sbuffer<Space>
" Press Ctrl+Shift+F5 to hide the current window
nnoremap <C-S-F5> :hide<CR>
" Press F12 to switch on the next buffer
nnoremap <F12> :bnext<CR>
" Press <S-F12> to switch on the previous buffer
nnoremap <S-F12> :bprevious<CR>
" Press <C-F12> to open a new window on the next buffer
nnoremap <C-F12> :sbnext<CR>
" Press <C-S-F12> to open a new window on the previous buffer
nnoremap <C-S-F12> :sbprevious<CR>

"
" Indentation configuration
"

set tabstop=4           " Tabs are 4 spaces long
set softtabstop=4       " Delete up to 4 spaces on backspace
set shiftwidth=4        " Auto-indent is 4 spaces
set shiftround          " Round the indenting to the closest shitfwidth multiple of spaces
set expandtab           " Insert the previous number of spaces instead of a Tab character
set autoindent          " Indentation is kept on new lines
" Keep selection after indenting in visual mode
vnoremap > >gv
vnoremap < <gv
" Unindent using shift-tab in insert mode
imap <S-Tab> <C-d>

"
" Display configuration
"

set number              " Show line number
"set nowrap              " Disable line wrapping
"set list                " Show invisible characters
set laststatus=2        " Always show file status bar
set showcmd             " Display some information about selections in visual mode
if has('mouse')
    set mouse=a         " Enable mouse actions
endif
" Remap scroll down and page down so they does not fill the screen with non-existant file lines
"map <ScrollWheelDown> n}
"map <PageDown> }
"imap <ScrollWheelDown> <C-o>}
"imap <PageDown> <C-o>}
" Remap scroll up and page up so cursor can be moved to the top of file
"map <ScrollWheelUp> {
"map <PageUp> {

"
" Search configuration
"

set ignorecase          " Make search case-insensitive
set smartcase           " With ignorecase set, search is case-insensitive unless an upper case is present in the search pattern
set hlsearch            " Highlight search
set incsearch           " Display search matches while typing
set scrolloff=4         " Keep lines at top and bottom of the screen when navigating search matches
" Make search use more common regex special characters and escape sequences
nnoremap / /\v
vnoremap / /\v
" Disable current search by typing the Carriage Return key
nnoremap <cr> :noh<return><cr>
" Press <F7> to turn on/off spell checking 
nnoremap <F7> :setlocal spell! spelllang=en_us<cr>
inoremap <F7> <c-o>:setlocal spell! spelllang=en_us<cr>

"
" Autocompletion
"

" Autocompletion on Ctrl+Space with omnifunc or keyword if omnifunc not available
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
\ "\<lt>C-n>" :
\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" 
" Special behaviours
"

" Call user specific vimrc file if it exists
if filereadable(customVimrcFilePath)
    exe "source ".customVimrcFilePath
endif

" Reload vimrc files when modified
if !exists("autoReloadRC")
    let autoReloadRC=1
    autocmd BufWritePost *vimrc* tabdo windo source $HOME/.vimrc
endif
