if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  set runtimepath+=~/.vim/neocomplete
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" color scheme
NeoBundle 'tomasr/molokai'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'NLKNguyen/papercolor-theme'

" 暗黒美夢王枠
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vinarise.git'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'linux' : 'make',
      \     'unix' : 'gmake',
      \    },
      \ }

" unite plugin
NeoBundle 'lambdalisue/unite-grep-vcs'

" regular expresion
NeoBundle 'othree/eregex.vim'
NeoBundle "osyo-manga/vim-over"

" airline
NeoBundle 'bling/vim-airline.git'

" indent guide
NeoBundle 'nathanaelkane/vim-indent-guides'

" for Ruby
NeoBundle 'vim-ruby/vim-ruby'

" for rails
NeoBundle "slim-template/vim-slim"

" for frontend
NeoBundle "pangloss/vim-javascript"
NeoBundle "mxw/vim-jsx"

" for html coding
NeoBundle 'mattn/emmet-vim'
NeoBundleLazy 'alpaca-tc/beautify.vim', {
      \ 'autoload' : {
      \   'commands' : [
      \     {
      \       'name' : 'Beautify',
      \       'complete' : 'customlist,beautify#complete_options'
      \     }
      \ ]
      \ }}

" for ansible
NeoBundle 'chase/vim-ansible-yaml'

NeoBundle 'mattn/webapi-vim'

NeoBundle 'thinca/vim-quickrun'
let g:quickrun_config = {
\   "_" : {
\       "outputter/buffer/split" : ":botright 8sp",
\       "outputter/buffer/close_on_empty" : 1
\   }
\}

call neobundle#end()

" colorscheme papercolor
colorscheme molokai

" global setting
set clipboard=unnamed " copy buffer to clipboard
set hlsearch
set number
set nocompatible      " We're running Vim, not Vi!
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
filetype plugin indent on     " required!

set tabstop=2
set shiftwidth=2
set expandtab
set noswapfile
set nobackup
set tw=0
set laststatus=2

" インサートモード時にバックスペースを使う
set backspace=indent,eol,start

if has("gui_macvim")
  let macvim_hig_shift_movement = 1
  set guifont=Monaco:h16
endif

" settings for vim indent
" vim立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup=1
" ガイドをスタートするインデントの量
let g:indent_guides_start_level=2
" 自動カラーを無効にする
let g:indent_guides_auto_colors=0
" 奇数インデントのカラー
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#E8D968
" ctermbg=gray
" 偶数インデントのカラー
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#CFC265
" ctermbg=darkgray
" " ハイライト色の変化の幅
let g:indent_guides_color_change_percent = 30
" ガイドの幅
let g:indent_guides_guide_size = 1

" vim-ruby autocompletion
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1 
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

" neocomplete用設定
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'

" completions and selected color
hi Pmenu ctermbg=6
hi PmenuSel ctermbg=2
hi PMenuSbar ctermbg=6

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><CR>  pumvisible() ? neocomplete#close_popup() : "<CR>"

" snipet
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" map for unite
nnoremap <silent> Uf :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
nnoremap <silent> UF :<C-u>Unite file_rec/git<CR>
nnoremap <silent> Ub :<C-u>Unite buffer<CR>
nnoremap <silent> Um :<C-u>Unite file_mru<CR>
nnoremap <silent> Ug :<C-u>Unite grep/git:. -buffer-name=search-buffer<CR>
nnoremap <silent> Ur :<C-u>UniteResume search-buffer<CR>
nnoremap <silent> Ut :<C-u>Unite tab<CR>

" Start insert.
" let g:unite_enable_start_insert = 1
let g:unite_enable_short_source_names = 1

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  " Overwrite settings.

  imap <buffer> jj      <Plug>(unite_insert_leave)
  " imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

  imap <buffer><expr> j unite#smart_map('j', '')
  " imap <buffer> <TAB>   <Plug>(unite_select_next_line)
  imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
  imap <buffer> '     <Plug>(unite_quick_match_default_action)
  nmap <buffer> '     <Plug>(unite_quick_match_default_action)
  imap <buffer><expr> x
        \ unite#smart_map('x', "\<Plug>(unite_quick_match_choose_action)")
  nmap <buffer> x     <Plug>(unite_quick_match_choose_action)
  nmap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
  imap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
  imap <buffer> <C-y>     <Plug>(unite_narrowing_path)
endfunction"}}}

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

" yank保存
let g:unite_source_history_yank_enable = 1

" open cwindow automatically after grep
autocmd QuickFixCmdPost *grep* copen

