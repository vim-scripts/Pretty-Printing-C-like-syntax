map <Leader>f :call PrettyPrint ()<CR>
map <CR> :set cmdheight=1<CR>

function! PrettyPrint ()
  execute "normal! mf"
  set cmdheight=6

  try
    %s/\(\w\)(/\1 (/g
  catch
    echo "No brackets to correct"
  endtry

  try
    %s/^\(\s*\w\+.*\){\(.*\)/\1\r{\2/g
  catch
    echo "No inline curly braces!"
  endtry

  try
    %s/^\s*{\(.\+\)/{\r\1/g
  catch
    echo "No text after cury braces!"
  endtry

  try
    %s/\(\w\+.*\)\s*}\(.*\)/\1\r}\2/g
  catch
    echo "No text before cury braces!"
  endtry

  try
    %s/\s\+$//g
  catch
    echo "No whitespace at lineend"
  endtry

  execute "normal! gg=G"
  execute "normal! `f"

  echom "Pretty printed!"
endfunction
