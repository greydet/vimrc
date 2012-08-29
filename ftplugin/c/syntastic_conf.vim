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

" Construct the include dir by searching for h file from the project root
" List of file name candidates used to find the project root
let g:prjRootElts = ['.project', '.git']
for candidate in g:prjRootElts
    let foundCandidates = FindUp('.', candidate)
    if len(foundCandidates) > 0
        let rootCandidate = StripFileName(foundCandidates[-1])
        let hDirs = system(g:installPath . 'binsh/findParentDir.sh ' . rootCandidate . ' -name "*.h"')
        let g:syntastic_c_include_dirs = split(hDirs)
        break
    endif
endfor

