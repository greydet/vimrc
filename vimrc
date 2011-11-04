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
set noswapfile          " Do not create any swap file for openned files

"
" Buffer configuration
"
set hidden              " Put buffers to background instead of closing it
set switchbuf=useopen

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
set mouse=a             " Enable mouse actions

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
" Call user specific vimrc file if it exists
"
if filereadable(customVimrcFilePath)
    exe "source ".customVimrcFilePath
endif
