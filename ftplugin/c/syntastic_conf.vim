"
" Copyright (C) 2011-2012 Gonzague Reydet.
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

if !exists('g:syntastic_autofind_inc') || g:syntastic_autofind_inc == 0
    finish
endif

" Construct the include dir by searching for h file from the project root
let prjRoot = FindProjectRoot()
if !exists('g:syntastic_inc_dir_rootPath') || prjRoot != g:syntastic_inc_dir_rootPath
    let g:syntastic_inc_dir_rootPath = prjRoot
    let hDirs = system(g:installPath . 'binsh/findParentDir.sh -L ' . prjRoot . ' -name "*.h"')
    let g:syntastic_c_include_dirs = split(hDirs)
    let g:syntastic_cpp_include_dirs = g:syntastic_c_include_dirs
endif

