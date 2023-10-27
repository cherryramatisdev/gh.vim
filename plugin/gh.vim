if exists("g:loaded_gh_vim")
  finish
endif
let g:loaded_gh_vim = 1

command! GHCreate :call pr#Create()
command! GHSubmit :call pr#Submit()
command! GHOpen :call pr#Open()
