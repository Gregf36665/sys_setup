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

function! Set_Verilog()
	set ft=verilog
	set fdm=expr
	set foldexpr=Verilog()
	set fdc=1
endfunction

" Fold on begin/end groups this doesn't allow for nested commands
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
