   "_____  ______    ___   ______   __  __   _____    __     ____    _   __    ______
  "/ ___/ /_  __/   /   | /_  __/  / / / /  / ___/   / /    /  _/   / | / /   / ____/
  "\__ \   / /     / /| |  / /    / / / /   \__ \   / /     / /    /  |/ /   / __/
 "___/ /  / /     / ___ | / /    / /_/ /   ___/ /  / /___ _/ /    / /|  /   / /___
"/____/  /_/     /_/  |_|/_/     \____/   /____/  /_____//___/   /_/ |_/   /_____/

augroup Inits
    autocmd!
    " TODO: Fix so that lsp shows, it is updated correctly at right time
    autocmd BufEnter * lua require'statusline'.statusline_init()
    autocmd WinEnter,BufEnter * lua require'statusline'.activeLine()
    autocmd WinLeave,BufLeave * lua require'statusline'.inActiveLine()
    autocmd WinEnter,BufEnter,WinLeave,BufLeave NvimTree lua require'statusline'.simpleLine()
    autocmd WinEnter,BufEnter * lua require'statusline'.tabline_init()
augroup END

function! Scrollbar() abort
    let width = 9
    let perc = (line('.') - 1.0) / (max([line('$'), 2]) - 1.0)
    let before = float2nr(round(perc * (width - 3)))
    let after = width - 3 - before
    return '[' . repeat(' ',  before) . '=' . repeat(' ', after) . ']'
endfunction

function! LinterStatus() abort "REQUIRES ALE
    try
        let l:counts = ale#statusline#Count(bufnr(''))
        let l:all_errors = l:counts.error + l:counts.style_error
        let l:all_non_errors = l:counts.total - l:all_errors
        if (l:all_errors == 0 )
            if !(l:all_non_errors == 0)
                return printf(
                            \ ' %d ',
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
                    \ ' %d  %d ',
                    \ l:all_non_errors,
                    \ l:all_errors
                    \)
    catch
        return ''
    endtry
endfunction
