" Dependencies:
"   ctrlp                         https://github.com/ctrlpvim/ctrlp.vim
"   github-colorscheme (bundled)  https://github.com/endel/vim-github-colorscheme.git
"   syntastic                     https://github.com/scrooloose/syntastic
"   tomorrow-theme (bundled)      https://github.com/hrubi/tomorrow-theme.git
"   vim-fugitive (bundled)        https://github.com/tpope/vim-fugitive
"   vim-pathogen                  https://github.com/tpope/vim-pathogen

let g:pathogen_disabled = []
execute pathogen#infect()

set nocompatible

" indenting
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

" eye candy
syntax on
filetype plugin indent on
set hlsearch
colorscheme Tomorrow-Night
"show tabs and trailing spaces
set list
set listchars=tab:>-,trail:-
hi SpecialKey ctermfg=239 guifg=#4e4e4e "rgb=78,78,78
" hilights
highlight ExtraWhitespace ctermbg=blue
match ExtraWhitespace /\s\+$/
"highlight SpellBad ctermbg=1
"highlight TabLine cterm=underline ctermfg=4 ctermbg=7

set mouse=a

" secure modelines
set nomodeline
let g:secure_modelines_allowed_items = [
    \ "textwidth",     "tw",
    \ "softtabstop",   "sts",
    \ "tabstop",       "ts",
    \ "shiftwidth",    "sw",
    \ "expandtab",     "et",   "noexpandtab", "noet",
    \ "filetype",      "ft",
    \ "foldmethod",    "fdm",
    \ "readonly",      "ro",   "noreadonly", "noro",
    \ "rightleft",     "rl",   "norightleft", "norl",
    \ "spell",
    \ "spelllang",
    \ "commentstring", "cms"
    \ ]
let g:secure_modelines_verbose = 1

" do not abandon closed buffers (abandon them with :bdelete)
set hidden

" visual menu for tab completion
set wildmenu

" show number of selected chars, lines, ..
set showcmd

" keep cursor in same column
set nostartofline

" always display the status line
set laststatus=2

" confirm on unsaved changes and otherwise dangerous attempts
set confirm

set notimeout ttimeout ttimeoutlen=200

" wrap the search
set wrapscan

" key bindings
nnoremap <F2>p :set invpaste<CR>
nnoremap <F2>e :setlocal spell spelllang=en<CR>
nnoremap <F2>d :append<CR>8<----------------------------------------------------------------------<CR>.<CR>
" remove trailing space: http://vim.wikia.com/wiki/Remove_unwanted_spaces
nnoremap <F2>r <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
nnoremap <C-L> :nohl<CR><C-L>

" %% expands to directory containing the current file
cabbr <expr> %% expand('%:p:h')
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>
nnoremap <Leader>t :tabnew <C-R>=expand('%:p:h') . '/'<CR>

" Extension association
au BufNewFile,BufRead *.pwt setlocal ft=perl
au BufNewFile,BufRead *.t setlocal ft=cram

"GD puppet style conventions
au BufNewFile,BufRead /home/hrubi/projects/gooddata/puppet/*.pp setlocal noexpandtab

" always put the cursor at the start in commit messages
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" move file
function! MoveFile(newspec)
    let old = expand('%')
    if (old == a:newspec)
        return 0
    endif
    exe 'sav' fnameescape(a:newspec)
    call delete(old)
endfunction
command! -nargs=1 -complete=file -bar MoveFile call MoveFile('<args>')



" plugins

" puppet-vim
let g:puppet_align_hashes = 0

" syntastic
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_exec = 'flake8'
let g:syntastic_python_pylint_exec = 'pylint'
let g:syntastic_perl_checkers = ['perlcritic']
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_puppet_checkers = ['puppet']
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": [],
    \ "passive_filetypes": ['java'] }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" ctrl-p
let g:ctrlp_by_filename = 1
let g:ctrlp_show_hidden = 0
let g:ctrlp_open_new_file = 't'

" status line, including all the plugins
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
