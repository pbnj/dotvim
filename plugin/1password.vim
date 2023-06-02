" Custom cmmand for `op` (aka 1password cli) with completion for item names

function! OnePasswordItemCompletion(A,L,P) abort
  return filter(systemlist("op item list | awk 'NR>1 {print $2}'"),'v:val =~ a:A')
endfunction

command! -nargs=* -complete=customlist,OnePasswordItemCompletion OP <mods> terminal op item get <args>