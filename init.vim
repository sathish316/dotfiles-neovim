set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set mouse=v                 " middle-click paste with mouse
set hlsearch                " highlight search results
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=80                   " set an 80 column border for good coding style
filetype plugin indent on   " allows auto-indenting depending on file type
set encoding=utf-8          " set the encoding to utf-8
set tabstop=4               " number of columns occupied by a tab character
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing

" specify directory for plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'arcticicestudio/nord-vim'

" collections - ruby
Plug 'vim-ruby/vim-ruby'

" collections - copilot
Plug 'github/copilot.vim'

" collections - rust
Plug 'rust-lang/rust.vim'
Plug 'neoclide/coc.nvim'
Plug 'dense-analysis/ale'

"  collections - haskell
"  source - https://mendo.zone/fun/neovim-setup-haskell/
Plug 'neovimhaskell/haskell-vim'
Plug 'alx741/vim-hindent'

" misc programming plugins
Plug 'Pocco81/auto-save.nvim'
" nerd commenter
Plug 'preservim/nerdcommenter'
" better syntax highlighting
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
" Tree finder
Plug 'kyazdani42/nvim-web-devicons' " optional, for file icons
Plug 'kyazdani42/nvim-tree.lua'
" status line plugin
Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'kyazdani42/nvim-web-devicons'
" tabs plugin
Plug 'romgrk/barbar.nvim'
" ctrlp search - like sublimetext
Plug 'ctrlpvim/ctrlp.vim'
" Ack - text search throughout the project
Plug 'mileszs/ack.vim'


" my custom config

" copy paste from clipboard
" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" initialize plugin system
call plug#end()

" my plugin config - copilot
"let g:copilot_assume_mapped = v:true 
"let g:copilot_no_tab_map = 1
"vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
nnoremap <leader>aid <cmd>Copilot disable<cr>
nnoremap <leader>aie <cmd>Copilot enable<cr>
autocmd BufRead,BufNewFile,BufEnter *Spec.hs :Copilot enable

" my plugin config - rust
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0

" my plugin config - Telescope fuzzy finder
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

lua << EOF
require('telescope').setup{ defaults = { file_ignore_patterns = {"target"} } }
EOF

" my plugin config - nvim-tree
lua << EOF
require("nvim-tree").setup()
EOF

" my plugin config - lualine
lua << EOF
require('lualine').setup()
EOF

" my plugin config - barbar
" Move to previous/next
nnoremap <silent><leader>h <Cmd>BufferPrevious<CR>
nnoremap <silent><leader>l <Cmd>BufferNext<CR>
" Goto buffer in position...
nnoremap <silent><leader>1 <Cmd>BufferGoto 1<CR>
nnoremap <silent><leader>2 <Cmd>BufferGoto 2<CR>
nnoremap <silent><leader>3 <Cmd>BufferGoto 3<CR>
nnoremap <silent><leader>4 <Cmd>BufferGoto 4<CR>
nnoremap <silent><leader>5 <Cmd>BufferGoto 5<CR>
nnoremap <silent><leader>6 <Cmd>BufferGoto 6<CR>
nnoremap <silent><leader>7 <Cmd>BufferGoto 7<CR>
nnoremap <silent><leader>8 <Cmd>BufferGoto 8<CR>
nnoremap <silent><leader>9 <Cmd>BufferGoto 9<CR>
nnoremap <silent><leader>0 <Cmd>BufferLast<CR>
" Close buffer
nnoremap <silent><leader>x <Cmd>BufferClose<CR>

" my default plugin config - coc - default
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

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

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" my plugin config - coc
"let g:coc_node_path = "/opt/homebrew/bin/node"
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

"if has('nvim')
"  inoremap <silent><expr> <c-space> coc#refresh()
"else
"  inoremap <silent><expr> <c-@> coc#refresh()
"endif

"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

" coc - map to tab for autocomplete
"inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
"inoremap <silent><expr> <cr> "\<c-g>u\<CR>"

" collections - haskell config
" haskell-vim config
let g:haskell_classic_highlighting = 1
let g:haskell_indent_if = 3
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1
let g:haskell_indent_guard = 2
let g:haskell_indent_case_alternative = 1
let g:cabal_indent_section = 2

" haskell vim-hindent config
let g:hindent_on_save = 1
let g:hindent_indent_size = 2
let g:hindent_line_length = 100
let g:hindent_command = "stack exec -- hindent"

" general neovim config
syntax on
colorscheme default
" colorscheme nord


" meta plugin steps
" install plugin x
" add "Plug 'z'"
" open neovim
" :PlugInstall or :PlugUpdate to install all pending plugins
"
" setup steps
" :CocInstall coc-rust-analyzer
"
" basic usage guide for plugins
"
" plugin - Copilot
" :Copilot enable
" :Copilot disable
" M-[ cycle through suggestions
" (this requires modifying iterm settings to allow alt key to be used as Meta
" or Esc+ key)
"
" plugin - Coc
" gd - goto definition
" Ctrl+O - return back
" :CocEnable
" :CocDisable
"
" plugin - AutoSave
" :ASToggle - to switch between auto save true and false
"
" plugin - NERDCommenter
" \cc -  comment  line or visual selection
" \c-space - uncomment line or visual selection
"
" plugin - Telescope fuzzy finder
" \ff - fuzzy find files
"
" plugin - Neovim tree
" :NvimTreeToggle - enable/disable 
" :NvimTreeFocus - focus on tree browser
"
" plugin - barbar tab switcher
" \-h prev tab
" \-l next tab
" \-1,2,3, - pick tab
" \-x - close tab
"
" plugin - ctrlp
" ctrl + p - fuzzy search files like sublimetext
"
" plugin - Ack.vim
" :Ack search-term
"
" plugin - haskell - haskell-vim
" automatic syntax highlighting
"
" plugin - haskell - vim-hindent
" install hindent in stack $ stack install hindent
" automatic formatting and indenting on save
