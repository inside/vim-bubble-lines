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
  let l_adjacent = l_num - 1
  let move_arg = l_num - v:count1 - 1 < 0 ?
        \ '0' :
        \ printf('%s -%d', a:line_getter, v:count1 + 1)
  let move_cmd = printf('%smove %s', a:range, move_arg)
  let indent_cmd = s:GetIndentCmd(l_num, l_adjacent, a:range)

  call s:Move(move_cmd, indent_cmd)
endf

func! s:MoveDown(line_getter, range)
  let l_num = line(a:line_getter)
  let move_arg = l_num + v:count1 > line('$') ?
        \ '$' :
        \ printf('%s +%d', a:line_getter, v:count1)
  let move_cmd = printf('%smove %s', a:range, move_arg)

  if a:line_getter == '.'
    let l_adjacent = l_num + 1
    let l_first = l_num
  else
    let l_adjacent = line("'>") + 1
    let l_first = line("'<")
  endif

  let indent_cmd = s:GetIndentCmd(l_num, l_adjacent, a:range)

  call s:Move(move_cmd, indent_cmd)
endf

func! s:GetIndentCmd(l_num, l_adjacent, range)
  let l_indent = indent(a:l_num)
  let l_adjacent_indent = indent(a:l_adjacent)
  let indent_diff = l_indent - l_adjacent_indent
  let indent_count = 0
  let indent_cmd = ''

  if indent_diff != 0
    let indent_count = abs(indent_diff) / shiftwidth()

    if l_indent < l_adjacent_indent
      let indent_cmd = '>'
    else
      let indent_cmd = '<'
    endif
  endif

  return a:range . repeat(indent_cmd, indent_count)
endf

func! s:Move(move_cmd, indent_cmd)
  " Move the lines
  execute 'silent! ' . a:move_cmd
  " Indents to same level of adjacent lines
  execute a:indent_cmd
  " Preserve the cursors position
  execute 'normal! ' . virtcol('.') . '|'
endf
