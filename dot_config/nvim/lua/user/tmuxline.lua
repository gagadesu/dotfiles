vim.cmd [[ 
" let g:tmuxline_preset = 'full'
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#{prefix_highlight}',
      \'win'  : [ '#I', '#W' ],
      \'cwin' : [ '#I', '#W', '#F' ],
      \'y'    : [ '%a', '%R' ],
      \'z'    : '#H'
      \}
let g:tmuxline_separators = {
      \ 'left' : '',
      \ 'left_alt': '>',
      \ 'right' : '',
      \ 'right_alt' : '',
      \ 'space' : ' '}

]]
