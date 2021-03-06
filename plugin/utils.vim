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

" Wrapper function to help calling the findUp bash script
" This script searches for files from the given path up to the filesystem root
"
" Param:
"   - path: The path from which to start the search
"   - pattern: The pattern of the searched files
" Return:
"   An array containing the found file paths
function! FindUp(path, pattern)
    return split(system(g:installPath . 'binsh/findUp.sh ' . a:path . ' -name ' . a:pattern))
endfunction

" Remove the last segment (the file name) from the given path
function! StripFileName(path)
    let l:lastPathSep = strridx(a:path, "/")
    return strpart(a:path, 0, l:lastPathSep + 1)
endfunction

if !exists('g:prjRootCandidates')
    " Default list of file name candidates used to find the project root
    let g:prjRootCandidates = ['.project', '.git']
endif

" Try to find the project root from the current working directory by searching
" in the parent directories for a file contained in the list of candidates
" (defined by the 'g:prjRootCandidates' variable)
function! FindProjectRoot()
    for candidate in g:prjRootCandidates
        let foundCandidates = FindUp('.', candidate)
        if len(foundCandidates) > 0
            let rootCandidate = StripFileName(foundCandidates[-1])
            return system('readlink -f ' . rootCandidate . ' | tr -d "\r\n"')
            break
        endif
    endfor
endfunction
