" colour is awesome
syntax on
set number
set noexpandtab shiftwidth=4 tabstop=4 softtabstop=4
set ruler
set showcmd
set incsearch
set wrapscan

" gj and gk are better
nmap j gj
nmap k gk

set fdc=1 "set the fold colum to 1
set fmr={,} "Set the fold markers
set fdm=marker

highlight FoldColumn  gui=bold    guifg=grey65     guibg=Grey90
highlight Folded      gui=italic  guifg=Black      guibg=Grey90
highlight LineNr      gui=NONE    guifg=grey60     guibg=Grey90

" List of fold methods: manual, indent, syntax, expr, marker, diff
"Match any verilog files to the correct syntax
" au stands for auto command
au BufNewFile,BufRead *.sv,*.v,*.vh,*.args,*.f,*.verilog call Set_Verilog()
au BufNewFile,BufRead *.vhd call Set_VHDL()
au BufNewFile,BufRead *.py call Set_Python()

function! Set_Python()
	set fdm=indent
	set expandtab " Let python use spaces
endfunction

function! Set_Verilog()
	set ft=verilog
	set fdm=expr
	set foldexpr=Verilog()
	set fdc=1
endfunction

function! Set_VHDL()
	set ft=vhdl
	set fdm=expr
	set foldexpr=VHDL()
	set fdc=1
endfunction

function! VHDL()
	if getline(v:lnum) =~ '^\s*begin'
		return 'a1'
	elseif getline(v:lnum) =~ '^\s*end'
		return 's1'
	else
		return '='
	endif
endfunction


" Fold on begin/end groups this does allow for nested commands
" Note it looks for whitespace before the keyword.  This is my style
function! Verilog()
	if getline(v:lnum) =~ '^\s*begin'
		return 'a1' " add one to the fold level
	elseif getline(v:lnum) =~ '^\s*end'
		return 's1' " subtract one from the fold level
	elseif getline(v:lnum) =~ '^\s*task'
		return 'a1' " add one from the fold level
	elseif getline(v:lnum) =~ '^\s*endtask'
		return 's1' " subtract one from the fold level
	elseif getline(v:lnum) =~ '^\s*case'
		return 'a1' " add one from the fold level
	elseif getline(v:lnum) =~ '^\s*endcase'
		return 's1' " subtract one from the fold level
	elseif getline(v:lnum) =~ '^\s*function'
		return 'a1' " add one from the fold level
	elseif getline(v:lnum) =~ '^\s*endfunction'
		return 's1' " subtract one from the fold level
	else
		return '='
	endif
endfunction

" o creates a new line at the same indent
set autoindent 
" The ! allows the function to override other functions

" remap j k to scroll for autocomplete
inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))

" Set the color scheme
colo koehler 

" Automatically set the pwd to the file location
set autochdir

" Highlight the active vim buffer/window
augroup BgHighlight
	autocmd!
	autocmd WinEnter * set cul " Highlight the current line when entering the window
	autocmd WinLeave * set nocul " Stop highlighting the line
augroup END

" Configure the cursor to blink at the correct rate
highlight Cursor guifg=steelblue guibg=white
highlight iCursor guifg=white guibg=steelblue
set guicursor=n-v-c:block-Cursor "In Normal Visual and Command mode use the block cursor
set guicursor+=i:ver100-iCursor " In insert mode set the cursor to a vertical height of 100%
set guicursor+=n-v-c:blinkon0 " Disable blinking in N-V-C modes
set guicursor+=i:blinkwait10 " allow blinking to happen in insert mode 

" Mouse settings
set mouse=a " Don't get line numbers when highlighting

" make Y behave as it should
nmap Y y$

" Show tab and EoL chars on F5
noremap <F5> :set list!<CR

" Have a key to scroll while moving lines
map <C-j>  j<C-e>
map <C-k>  k<C-y>

" Toggle softtabs if required
noremap <F4> :set noexpandtab!<CR>

" Make markdown highlight correctly
au BufNewFile,BufFilepre,BufRead *.md set filetype=markdown
