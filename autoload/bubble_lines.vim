func! bubble_lines#Up()
  call s:MoveUp('.', '')
endf

func! bubble_lines#Down()
  call s:MoveDown('.', '')
endf

func! bubble_lines#VisualUp()
  call s:MoveUp("'<", "'<,'>")
  normal gv
endf

func! bubble_lines#VisualDown()
  call s:MoveDown("'>", "'<,'>")
  normal gv
endf

func! s:MoveUp(line_getter, range)
  let l_num = line(a:line_getter)
  if l_num - v:count1 - 1 < 0
    let move_arg = "0"
  else
    let move_arg = a:line_getter." -".(v:count1 + 1)
  endif
  call s:Move(a:range."move ".move_arg)
endf

func! s:MoveDown(line_getter, range)
  let l_num = line(a:line_getter)
  if l_num + v:count1 > line("$")
    let move_arg = "$"
  else
    let move_arg = a:line_getter." +".v:count1
  endif
  call s:Move(a:range."move ".move_arg)
endf

func! s:Move(move_arg)
  let col_num = virtcol('.')
  execute 'silent! ' . a:move_arg
  execute 'normal! ' . col_num . '|'
endf
