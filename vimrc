nnoremap <silent><nowait><space> <nop>
let g:mapleader = ' '

" Enable built-in plugin to filter quickfix list. See :h :Cfilter
packadd cfilter

" Enable :Man built-in vim plugin
runtime ftplugin/man.vim

call plug#begin('~/.vim/plugged')

Plug 'https://github.com/airblade/vim-rooter'
Plug 'https://github.com/dense-analysis/ale'
Plug 'https://github.com/editorconfig/editorconfig-vim'
Plug 'https://github.com/junegunn/fzf', {'dir': '~/.fzf', 'do': { -> fzf#install() }}
Plug 'https://github.com/junegunn/fzf.vim' | let g:fzf_colors = {'border': ['fg','DiffDelete']}
Plug 'https://github.com/lifepillar/vim-mucomplete' | let g:mucomplete#chains = {'default': ['path','omni','c-n','user','tags'],'vim': ['path','cmd','c-n','tags']}
Plug 'https://github.com/machakann/vim-highlightedyank'
Plug 'https://github.com/pbnj/vim-ddgr'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/tpope/vim-dispatch'
Plug 'https://github.com/tpope/vim-eunuch'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/tpope/vim-rhubarb'
Plug 'https://github.com/tpope/vim-rsi'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-unimpaired'
Plug 'https://github.com/tpope/vim-vinegar'

let g:polyglot_disabled = ['csv']
Plug 'https://github.com/sheerun/vim-polyglot'

if executable('ctags')
  Plug 'https://github.com/ludovicchabant/vim-gutentags'
endif

call plug#end()

filetype plugin indent on

" vim options
let &autoindent = 1
let &autoread = 1
let &backspace = 'indent,eol,start'
let &breakindent = 1
let &clipboard = 'unnamed,unnamedplus'
let &completeopt = 'menu,longest'
let &cursorline = 0
let &encoding = 'utf-8'
let &errorformat = '%f:%l:%m,%f:%l:%c:%m'
let &expandtab = 0
let &grepformat = '%f:%l:%m'
let &grepprg = 'grep -HIn --line-buffered --exclude={tags,.terraform\*,\*.tfstate.\*,\*.so} --exclude-dir={.git,node_modules,.terraform\*,__pycache__,debug,target} $*'
let &guifont = 'SF Mono'
let &guioptions = ''
let &hidden = 1
let &hlsearch = 0
let &ignorecase = 1
let &incsearch = 1
let &infercase = 1
let &laststatus = 2
let &lazyredraw = 1
let &list = 1
let &listchars = 'tab:┊ ,trail:·'
let &modeline = 1
let &mouse = ''
let &pumheight = 50
let &secure = 1
let &shortmess = 'filnxtToOcC'
let &showbreak = '… '
let &showmode = 1
let &smartcase = 1
let &smarttab = 1
let &swapfile = 0
let &t_Co = 16
let &ttimeout = 1
let &ttimeoutlen = 50
let &ttyfast = 1
let &wildignorecase = 1
let &wildmenu = 1
let &wildmode = 'longest:full,full'
let &wildoptions = 'pum'
let &wrap = 0

if &term =~ "xterm"
  let &t_SI = "\e[6 q"
  let &t_SR = "\e[4 q"
  let &t_EI = "\e[2 q"
endif

" netrw options
let g:netrw_fastbrowse = 0
let g:netrw_localrmdir = 'rm -rf'

" ale
autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#ale#get_source_options({}))
let &omnifunc = 'ale#completion#OmniFunc'
let g:ale_fix_on_save = 1
let g:ale_fixers = { '*' : [ 'remove_trailing_lines', 'trim_whitespace' ] }
let g:ale_hover_cursor = 0
let g:ale_open_list = 1
let g:ale_virtualtext_cursor = 0
let g:ale_set_signs = 0
nnoremap <leader>gd <cmd>ALEGoToDefinition<cr>
nnoremap <leader>k <cmd>ALEHover<cr>
nnoremap [d <cmd>ALEPrevious<cr>
nnoremap ]d <cmd>ALENext<cr>

" fzf
let project_finder = executable('fd') ? 'fd . ~/Projects --type d' : 'find ~/Projects -type d -not \( -path *.git -prune \) -not \( -path *.terraform -prune \)'
command! -bang Projects call fzf#run(fzf#wrap({'source': project_finder,'options': '--prompt=Projects\>\ '},<bang>0))
command! URLs call fzf#run(fzf#wrap({'source': map(filter(uniq(split(join(getline(1,'$'),' '),' ')), 'v:val =~ "http"'), {k,v->substitute(v,'\(''\|)\|"\|,\)','','g')}), 'sink': executable('open') ? '!open' : '!xdg-open', 'options': '--multi --prompt=URLs\>\ '}))
command! F Files
command! FF Files %:p:h
nnoremap <leader>bb <cmd>Buffers<cr>
nnoremap <leader>ff <cmd>GFiles<cr>
nnoremap <leader>FF <cmd>Files %:p:h<cr>
nnoremap <leader>uu <cmd>URLs<cr>

" dispatch
command! -nargs=* -complete=shellcmd Terminal Start -wait=always -dir=%:p:h <args>

" [B]uffer [D]elete all buffers. To re-open most recent buffer: `:e#`
command! BD %bd

" Re-open nested vim-in-vim in outer vim
command! Unwrap let g:file = expand('%') | bdelete | exec 'silent !echo -e "\033]51;[\"drop\", \"'..g:file..'\"]\007"' | q

cnoremap <c-n> <c-Down>
cnoremap <c-p> <c-Up>
nnoremap <leader>cd <cmd>lcd %:p:h<cr>
nnoremap <leader>ee :ed **/*
nnoremap <leader>gg :G<cr>
nnoremap <leader>gP :G! pull<cr>
nnoremap <leader>gp :G! push<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>sp :sp **/*
nnoremap <leader>TT :topleft terminal <c-r><c-l>
nnoremap <leader>tt <cmd>topleft terminal<cr>
nnoremap <leader>vs :vs **/*
nnoremap Y y$
noremap <expr> N (v:searchforward ? 'N' : 'n')
noremap <expr> n (v:searchforward ? 'n' : 'N')
tnoremap <esc> <c-\><c-n>
tnoremap <s-space> <space>

colorscheme pbnj
