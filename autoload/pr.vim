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

  if l:reviewers != ''
    let l:gh_pr_cmd = l:gh_pr_cmd . ' -r ' . l:reviewers
  endif

  if exists('g:GH_pr_title_cmd')
    let l:pr_title = systemlist(g:GH_pr_title_cmd)->join()

    let l:gh_pr_cmd = l:gh_pr_cmd . ' -t "' . l:pr_title . '"'
  endif

  let l:gh_pr_cmd = l:gh_pr_cmd . ' -F "' . l:filepath . '"'

  if tabpagenr('$') > 1
    tabclose
  endif

  if exists('g:GH_before_create_hook')
    call g:GH_before_create_hook()
  endif

  execute 'Dispatch ' . l:gh_pr_cmd
endfunction

function! pr#Open() abort
  Dispatch! gh pr view -w
endfunction
