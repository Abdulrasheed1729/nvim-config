set expandtab
set shiftwidth=4
set softtabstop=4
set colorcolumn=80
set ruler
set mouse
set visualbell
set showmatch
set showmode
set scrolloff=999
set t_Co=256
set number
set rnu
set tabstop=4
set shiftwidth=4
colorscheme vim
syntax on

" Backup settings
" execute "set directory=" . g:vim_home_path . "/swap"
" execute "set backupdir=" . g:vim_home_path . "/backup"
" execute "set undodir=" . g:vim_home_path . "/undo"
set backup
set undofile
set writebackup

" Search settings
set hlsearch   " Highlight results
set ignorecase " Ignore casing of searches
set incsearch  " Start showing results as you type
set smartcase  " Be smart about case sensitivity when searching


" Tab completion settings
set wildmode=list:longest     " Wildcard matches show a list, matching the longest first
set wildignore+=.git,.hg,.svn " Ignore version control repos
set wildignore+=*.6           " Ignore Go compiled files
set wildignore+=*.pyc         " Ignore Python compiled files
set wildignore+=*.rbc         " Ignore Rubinius compiled files
set wildignore+=*.swp         " Ignore vim backups

set termguicolors
