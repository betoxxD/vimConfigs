let mapleader=" "

" testing
nnoremap <Leader>t :TestNearest<CR>
nnoremap <Leader>T :TestFile<CR>
nnoremap <Leader>TT :TestSuite<CR>

" split resize
 nnoremap <Leader>> 10<C-w>>
 nnoremap <Leader>< 10<C-w><

" quick semi
nnoremap <Leader>; $a;<Esc>

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
" shorter commands
cnoreabbrev tree NERDTreeToggle
cnoreabbrev blame Gblame
cnoreabbrev find NERDTreeFind
cnoreabbrev diff Gdiff

" plugs
map <Leader>nt :NERDTreeFind<CR>
map <Leader>f :Files<CR>
map <Leader>ag :Ag<CR>

" tmux navigator
" nnoremap <silent> <Leader><C-h> :TmuxNavigateLeft<cr>
" nnoremap <silent> <Leader><C-k> :TmuxNavigateUp<cr>
" nnoremap <silent> <Leader><C-j> :TmuxNavigateDown<cr>
" nnoremap <silent> <Leader><C-l> :TmuxNavigateRight<cr>

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap surround to lowercase s so it does not add an empty space
xmap s <Plug>VSurround
" diagnostics
nnoremap <leader>P :let @*=expand("%")<CR>

" tabs navigation
map <Leader>h :tabprevious<cr>
map <Leader>l :tabnext<cr>

" buffers
map <Leader>ob :Buffers<cr>

" keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Moving text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <Leader>k :m .-2<CR>==
nnoremap <Leader>j :m .+1<CR>==

" faster scrolling
nnoremap <C-j> 10<C-e>
nnoremap <C-k> 10<C-y>
nmap <Leader>s <Plug>(easymotion-s2)

" git
nnoremap <Leader>G :G<cr>
nnoremap <Leader>gp :Gpush<cr>
nnoremap <Leader>gl :Gpull<cr>

" run current file
nnoremap <Leader>x :!node %<cr>

inoremap <silent><expr> <c-space> coc#refresh()


set splitright
function! OpenTerminal()
  " move to right most buffer
  execute "normal \<C-l>"
  execute "normal \<C-l>"
  execute "normal \<C-l>"
  execute "normal \<C-l>"

  let bufNum = bufnr("%")
  let bufType = getbufvar(bufNum, "&buftype", "not found")

  if bufType == "terminal"
    " close existing terminal
    execute "q"
  else
    " open terminal
    execute "vsp term://zsh"

    " turn off numbers
    execute "set nonu"
    execute "set nornu"

    " toggle insert on enter/exit
    silent au BufLeave <buffer> stopinsert!
    silent au BufWinEnter,WinEnter <buffer> startinsert!

    " set maps inside terminal buffer
    execute "tnoremap <buffer> <C-h> <C-\\><C-n><C-w><C-h>"
    execute "tnoremap <buffer> <C-t> <C-\\><C-n>:q<CR>"
    execute "tnoremap <buffer> <C-\\><C-\\> <C-\\><C-n>"

    startinsert!
  endif
endfunction
nnoremap <C-t> :call OpenTerminal()<CR>

inoremap <expr> <CR> ParensIndent()

function! ParensIndent()
  let prev = col('.') - 1
  let after = col('.')
  let prevChar = matchstr(getline('.'), '\%' . prev . 'c.')
  let afterChar = matchstr(getline('.'), '\%' . after . 'c.')
  if (prevChar == '"' && afterChar == '"') ||
\    (prevChar == "'" && afterChar == "'") ||
\    (prevChar == "(" && afterChar == ")") ||
\    (prevChar == "{" && afterChar == "}") ||
\    (prevChar == "[" && afterChar == "]")
    return "\<CR>\<ESC>O"
  endif
  
  return "\<CR>"
endfunction

inoremap <expr> <space> ParensSpacing()

function! ParensSpacing()
  let prev = col('.') - 1
  let after = col('.')
  let prevChar = matchstr(getline('.'), '\%' . prev . 'c.')
  let afterChar = matchstr(getline('.'), '\%' . after . 'c.')
  if (prevChar == '"' && afterChar == '"') ||
\    (prevChar == "'" && afterChar == "'") ||
\    (prevChar == "(" && afterChar == ")") ||
\    (prevChar == "{" && afterChar == "}") ||
\    (prevChar == "[" && afterChar == "]")
    return "\<space>\<space>\<left>"
  endif
  
  return "\<space>"
endfunction

inoremap <expr> <BS> ParensRemoveSpacing()

function! ParensRemoveSpacing()
  let prev = col('.') - 1
  let after = col('.')
  let prevChar = matchstr(getline('.'), '\%' . prev . 'c.')
  let afterChar = matchstr(getline('.'), '\%' . after . 'c.')

  if (prevChar == '"' && afterChar == '"') ||
\    (prevChar == "'" && afterChar == "'") ||
\    (prevChar == "(" && afterChar == ")") ||
\    (prevChar == "{" && afterChar == "}") ||
\    (prevChar == "[" && afterChar == "]")
    return "\<bs>\<right>\<bs>"
  endif
  
  if (prevChar == ' ' && afterChar == ' ')
    let prev = col('.') - 2
    let after = col('.') + 1
    let prevChar = matchstr(getline('.'), '\%' . prev . 'c.')
    let afterChar = matchstr(getline('.'), '\%' . after . 'c.')
    if (prevChar == '"' && afterChar == '"') ||
  \    (prevChar == "'" && afterChar == "'") ||
  \    (prevChar == "(" && afterChar == ")") ||
  \    (prevChar == "{" && afterChar == "}") ||
  \    (prevChar == "[" && afterChar == "]")
      return "\<bs>\<right>\<bs>"
    endif
  endif
  
  return "\<bs>"
endfunction

inoremap { {}<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap ' ''<left>
inoremap " ""<left>

let curly = "}"
inoremap <expr> } CheckNextParens(curly)

let bracket = "]"
inoremap <expr> ] CheckNextParens(bracket)

let parens = ")"
inoremap <expr> ) CheckNextParens(parens)

let quote = "'"
inoremap <expr> ' CheckNextQuote(quote)

let dquote = '"'
inoremap <expr> " CheckNextQuote(dquote)

let bticks = '`'
inoremap <expr> ` CheckNextQuote(bticks)

function CheckNextQuote(c)
  let after = col('.')
  let afterChar = matchstr(getline('.'), '\%' . after . 'c.')
  
  if (afterChar == a:c)
    return "\<right>"
  endif
  if (afterChar == ' ' || afterChar == '' || afterChar == ')' || afterChar== '}' || afterChar == ']')
    return a:c . a:c . "\<left>"
  endif
  if (afterChar != a:c)
    let bticks = '`'
    let dquote = '"'
    let quote = "'"
    if(afterChar == dquote || afterChar == quote || afterChar == bticks)
      return a:c . a:c . "\<left>"
    endif
  endif
  return a:c
endfunction

function CheckNextParens(c)
  let after = col('.')
  let afterChar = matchstr(getline('.'), '\%' . after . 'c.')
  if (afterChar == a:c)

    return "\<right>"
  endif
  return a:c
endfunction

" Compile cpp projects
" for detecting OS
if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

" important option that should already be set!
set hidden

" available options:
" * g:split_term_style
" * g:split_term_resize_cmd
function! TermWrapper(command) abort
	if !exists('g:split_term_style') | let g:split_term_style = 'vertical' | endif
	if g:split_term_style ==# 'vertical'
		let buffercmd = 'vnew'
	elseif g:split_term_style ==# 'horizontal'
		let buffercmd = 'new'
	else
		echoerr 'ERROR! g:split_term_style is not a valid value (must be ''horizontal'' or ''vertical'' but is currently set to ''' . g:split_term_style . ''')'
		throw 'ERROR! g:split_term_style is not a valid value (must be ''horizontal'' or ''vertical'')'
	endif
	exec buffercmd
	if exists('g:split_term_resize_cmd')
		exec g:split_term_resize_cmd
	endif
	exec 'term ' . a:command
	exec 'setlocal nornu nonu'
	exec 'startinsert'
	autocmd BufEnter <buffer> startinsert
endfunction

command! -nargs=0 CompileAndRun call TermWrapper(printf('g++ -std=c++11 %s && ./a.out', expand('%')))
command! -nargs=1 -complete=file CompileAndRunWithFile call TermWrapper(printf('g++ -std=c++11 %s && ./a.out < %s', expand('%'), <q-args>))
autocmd FileType cpp nnoremap <leader>fw :CompileAndRun<CR>

" For those of you that like to use the default ./a.out
" This C++ toolkit gives you commands to compile and/or run in different types
" of terminals for your own preference.
" NOTE: this version is more stable than the other version with specified
" output executable!
augroup CppToolkit
	autocmd!
	if g:os == 'Darwin'
		autocmd FileType cpp nnoremap <leader>fn :!g++ -std=c++11 -o %:r % && open -a Terminal './a.out'<CR>
	endif
	autocmd FileType cpp nnoremap <leader>fb :!g++ -std=c++11 % && ./a.out<CR>
	autocmd FileType cpp nnoremap <leader>fr :!./a.out<CR>
	autocmd FileType cpp nnoremap <leader>fw :CompileAndRun<CR>
augroup END

" For those of you that like to use -o and a specific outfile executable
" (i.e., xyz.cpp makes executable xyz, as opposed to a.out
" This C++ toolkit gives you commands to compile and/or run in different types
" of terminals for your own preference.
augroup CppToolkit
	autocmd!
	if g:os == 'Darwin'
		autocmd FileType cpp nnoremap <leader>fn :!g++ -std=c++11 -o %:r % && open -a Terminal './%:r'<CR>
	endif
	autocmd FileType cpp nnoremap <leader>fb :!g++ -std=c++11 -o %:r % && ./%:r<CR>
	autocmd FileType cpp nnoremap <leader>fr :!./%:r.out<CR>
augroup END

" options
" choose between 'vertical' and 'horizontal' for how the terminal window is split
" (default is vertical)
let g:split_term_style = 'horizontal'

" add a custom command to resize the terminal window to your preference
" (default is to split the screen equally)
let g:split_term_resize_cmd = 'resize 6'
" (or let g:split_term_resize_cmd = 'vertical resize 40')
"
" Autocomplete
" Use <Tab> and <S-Tab> for navigate completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>" 
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Disable tab on Ultisnips to get work on coc.nvim
let g:UltiSnipsExpandTrigger = "<nop>"

