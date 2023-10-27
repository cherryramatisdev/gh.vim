function! s:ReturnProjectRoot() abort
  " TODO: This doesn't work on non git projects
  return system('git rev-parse --show-toplevel')->substitute('\n', '', '')
endfunction

function! pr#Create() abort
  let l:template_path = s:ReturnProjectRoot() . '/.github/pull_request_template.md'

  call execute('tabe ' . tempname())

  if filereadable(l:template_path)
    call setline(1, readfile(l:template_path))
    setlocal filetype=markdown
  endif
endfunction

function! pr#Submit() abort
  let l:filepath = expand('%')
  let l:base_branch = 'main'
  let l:reviewers = getenv('REVIEWERS')

  let l:gh_pr_cmd = '!gh pr -a @me create -B ' . l:base_branch

  if l:reviewers
    l:gh_pr_cmd = l:gh_pr_cmd . ' -r ' . l:reviewers
  endif

  l:gh_pr_cmd = l:gh_pr_cmd . ' -F "' . l:filepath . '"'

  if tabpagebuflist()->len() > 1
    tabclose
  endif

  execute 'Dispatch ' . l:gh_pr_cmd
endfunction

function! pr#Open() abort
  Dispatch! gh pr view -w
endfunction
