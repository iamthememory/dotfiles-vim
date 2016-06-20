" Don't use compatibility mode
set nocompatible

" Turn off filetyping until Vundle is ready.
filetype off


" Add Vundle to the runtime path and initialize it.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


" Vundle plugins

" Let Vundle manage itself.
Plugin 'VundleVim/Vundle.vim'

" EditorConfig (automatic per-project editor settings).
Plugin 'editorconfig/editorconfig-vim'

" vim-rst-tables (reformat reStructuredText tables).
Plugin 'nvie/vim-rst-tables'

" Dispatch (asynchronous command running).
Plugin 'tpope/vim-dispatch'

" Fugitive (git functionality).
Plugin 'tpope/vim-fugitive'

" Obsession (auto-saving sessions).
Plugin 'tpope/vim-obsession'

" VST (reStructuredText).
Plugin 'VST'


" All Vundle plugins must be before this line.
call vundle#end()

" Use filetype-based indentation.
filetype plugin indent on


" Look and feel.

" If I'm in a terminal, assume the background is dark.
if !has('gui_running')
  set background=dark
endif

" Mark at 80 characters
set colorcolumn=80

" Show folds on the left.
set foldcolumn=2
set foldlevel=2

" Show line numbers by default.
set number

" Enable syntax highlighting.
syntax on

" Statusline.
if has('statusline')
	set laststatus=2
	set statusline=%< " Left align
	set statusline+=%f\  " Filename
	set statusline+=%w " Preview window flag (if applicable)
	set statusline+=%h " Help buffer flag (if applicable)
	set statusline+=%m " Modified flag
	set statusline+=%r " Readonly flag (if applicable)
	set statusline+=%{fugitive#statusline()}\  " Fugitive (current git branch)
	set statusline+=%y\  " File type
	set statusline+=%= "Right align
	set statusline+=%-14.(%l,%c%V%)\ %p%% " Current file position
endif


" Behavior.

" Case insensitive search if all lowercase.
set ignorecase
set smartcase

" Better file tab completion.
set wildmode=longest,list,full
set wildmenu

" Formatting options.
set formatoptions+=tcqjn


" Try to template from a skeleton.
autocmd BufNewFile *.* silent! execute '0r $HOME/.vim/templates/skeleton.'.expand("<afile>:e")

" Default printer options
set printoptions=paper:letter,duplex:long,top:7pc,bottom:5pc,left:5pc,right:5pc,header:2,number:y,syntax:y

" Add :Man to open manpages
runtime! ftplugin/man.vim

" Save current buffer and make in the background.
noremap <Leader>m :w<CR>:Make!<CR>

" Use Doxygen in C/C++ files.
au BufRead,BufNewFile *.c set filetype=c.doxygen
au BufRead,BufNewFile *.cpp set filetype=cpp.doxygen
au BufRead,BufNewFile *.h set filetype=cpp.doxygen
au BufRead,BufNewFile *.h.in set filetype=cpp.doxygen

" Assume LaTeX format for TeX files
let g:tex_flavor='latex'
