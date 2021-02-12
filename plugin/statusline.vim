   "_____  ______    ___   ______   __  __   _____    __     ____    _   __    ______
  "/ ___/ /_  __/   /   | /_  __/  / / / /  / ___/   / /    /  _/   / | / /   / ____/
  "\__ \   / /     / /| |  / /    / / / /   \__ \   / /     / /    /  |/ /   / __/
 "___/ /  / /     / ___ | / /    / /_/ /   ___/ /  / /___ _/ /    / /|  /   / /___
"/____/  /_/     /_/  |_|/_/     \____/   /____/  /_____//___/   /_/ |_/   /_____/



function! InactiveLine()
    return luaeval("require'statusline'.inActiveLine()")
endfunction

function! ActiveLine()
    return luaeval("require'statusline'.activeLine()")
endfunction

" Change statusline automatically
augroup Statusline
  autocmd!
  autocmd WinEnter,BufEnter * setlocal statusline=%!ActiveLine()
  autocmd WinLeave,BufLeave * setlocal statusline=
augroup END

function! TabLine()
    return luaeval("require'statusline'.tabline_init()")
endfunction

"SET TABLINE. ONLY NEED DO ONCE ONLY
set tabline=%!TabLine()



function! LinterStatus() abort "REQUIRES ALE
  try
   let l:counts = ale#statusline#Count(bufnr(''))
   let l:all_errors = l:counts.error + l:counts.style_error
   let l:all_non_errors = l:counts.total - l:all_errors
   if (l:all_errors == 0 )
     if !(l:all_non_errors == 0)
       return printf(
       \ ' %d ',
       \ l:all_non_errors,
       \)
    end
  end
    if (l:all_non_errors == 0 )
     if !(l:all_errors == 0)
       return printf(
       \ ' %d ',
       \ l:all_errors,
       \)
    end
  end
   return l:counts.total == 0 ? '' : printf(
   \ ' %d  %d ',
   \ l:all_non_errors,
   \ l:all_errors
   \)
    catch
            return ''
 endtry
endfunction












"BELOW IS ARCHIVED TODO: REMOVE LATER
"
"
" "FUNC: File Size
" function! FileSize() abort
"     let l:bytes = getfsize(expand('%p'))
"     if (l:bytes >= 1024)
"         let l:kbytes = l:bytes / 1025
"     endif
"     if (exists('kbytes') && l:kbytes >= 1000)
"         let l:mbytes = l:kbytes / 1000
"     endif

"     if l:bytes <= 0
"         return ''
"     endif

"     if (exists('mbytes'))
"         return l:mbytes . 'MB '
"     elseif (exists('kbytes'))
"         return l:kbytes . 'KB '
"     else
"         return l:bytes . 'B '
"     endif
" endfunction
"
"
" "FUNC: Send + if file modified else nothing
" function! FileIsModified() abort
"     if &modified
"       return '+ '
"     else
"       return ''
"   end
" endfunction
"
"
"" "FUNC: Read Only File
" function! ReadOnly() abort
"   if &readonly || !&modifiable
"     return ' '
"   else
"     return ''
"   endif
" endfunction

"
"ANOTHER METHOD TO SET STATUSLINE
"function! SetStatusline() abort
    "luafile ~/.config/nvim/lua/beauwilliams/statusline.lua
"endfunction

 "Change statusline automatically
"augroup Statusline
  "autocmd!
  "autocmd WinEnter,BufEnter * :call SetStatusline()
  "autocmd WinLeave,BufLeave * setlocal statusline=
"augroup END


"
"
"
" function! GitStats() abort "REQUIRES SIGNIFY
"   try
"     let [added, modified, removed] = sy#repo#get_stats()
"     let symbols = ['', '', 'ﰣ']
"     let stats = [added, removed, modified]  " reorder
"     let statline = ''

"     for i in range(3)
"       if stats[i] > 0
"         let statline .= printf(' %s %s ', symbols[i], stats[i])
"       endif
"     endfor

"     if !empty(statline)
"       let statline = printf(' %s', statline[:-2])
"     endif

"   return statline
"   catch
"     return ''
"   endtry
" endfunction


" "STOLEN FROM FUGITIVE SOURCE, SO I CAN CUSTOMISE THE OUTPUT
" " Section: Statusline
" " REQUIRES FUGITIVEStatuslineGitBranch
" function! GitBranchName(...) abort
"   try
"   let dir = s:Dir(bufnr(''))
"   if empty(dir)
"     return ''
"   endif
"   let status = ' ' "NOTE: This git branch icon adds NERDFONT dependency
"   let commit = s:DirCommitFile(@%)[1]
"   if len(commit)
"     let status .= ':' . commit[0:6]
"   endif
"   let status .= FugitiveHead(7, dir) "'('.FugitiveHead(7, dir).')'
"   return status
"   catch
"     return ''
"   endtry
" endfunction

" function! GetGitBranchName(...) abort
"   try
"     return GitBranchName()
"   catch
"     return ''
"   endtry
" endfunction

" function! Head(...) abort
"   if empty(s:Dir())
"     return ''
"   endif

"   return Head(a:0 ? a:1 : 0)
" endfunction

" function! s:Dir(...) abort
"     try
"   return a:0 ? FugitiveGitDir(a:1) : FugitiveGitDir()
"     catch
"         return ''
"     endtry
" endfunction

" function! s:DirCommitFile(path) abort
"   let vals = matchlist(s:Slash(a:path), '\c^fugitive:\%(//\)\=\(.\{-\}\)\%(//\|::\)\(\x\{40,\}\|[0-3]\)\(/.*\)\=$')
"   if empty(vals)
"     return ['', '', '']
"   endif
"   return vals[1:3]
" endfunction

" function! s:Slash(path) abort
"   if exists('+shellslash')
"     return tr(a:path, '\', '/')
"   else
"     return a:path
"   endif
" endfunction






" function! StatuslineGitBranch() "INSPO
" let b:gitbranch=""
"   if &modifiable
"     try
"       let l:dir=expand('%:p:h')
"       let l:gitrevparse = system("git -C ".l:dir." rev-parse --abbrev-ref HEAD")
"       if !v:shell_error
"         let b:gitbranch="(".substitute(l:gitrevparse, '\n', '', 'g').") "
"       endif
"     catch
"     endtry
"   endif
"   return b:gitbranch
" endfunction
"
"
" function! GetGitBranchTest() abort
"   return StatuslineGitBranch()
" endfunction

"augroup GetGitBranch
  "autocmd!
  "autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
"augroup END
"
"function! statusline#setGitBranchStatus(...) abort
  "let dir = s:Dir(bufnr(''))
  "if empty(dir)
    "return ''
  "endif
  "let status = ''
  "let commit = s:DirCommitFile(@%)[1]
  "if len(commit)
    "let status .= ':' . commit[0:6]
  "endif
  "let status .= '('.FugitiveHead(7, dir).')'
  "return ''
"endfunction

"function! statusline#getGitBranchStatus(...) abort
  "return statusline#GitBranchStatus()
"endfunction

"function! statusline#head(...) abort
  "if empty(s:Dir())
    "return ''
  "endif

  "return statusline#Head(a:0 ? a:1 : 0)
"endfunction
