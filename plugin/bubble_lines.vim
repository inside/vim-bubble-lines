" Thanks to http://vim.wikia.com/wiki/VimTip191
nnoremap <script> <Plug>BubbleLinesUp <SID>Up
nnoremap <script> <Plug>BubbleLinesDown <SID>Down
xnoremap <script> <Plug>BubbleLinesVisualUp <SID>VisualUp
xnoremap <script> <Plug>BubbleLinesVisualDown <SID>VisualDown

nnoremap <silent> <SID>Up :<c-u>call bubble_lines#Up()<cr>
nnoremap <silent> <SID>Down :<c-u>call bubble_lines#Down()<cr>
xnoremap <silent> <SID>VisualUp :<c-u>call bubble_lines#VisualUp()<cr>
xnoremap <silent> <SID>VisualDown :<c-u>call bubble_lines#VisualDown()<cr>
