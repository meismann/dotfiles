fun! s:DetectNode()
  if getline(1) == '#!/usr/bin/env ruby'
    set ft=ruby
  endif
endfun

autocmd BufNewFile,BufRead * call s:DetectNode()
