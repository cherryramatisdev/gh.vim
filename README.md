# Bring the power of github CLI to vim

## Installation

This plugin has dependency with the [tpope vim-dispatch](https://github.com/tpope/vim-dispatch) and can be installed as follows using some package manager like [vim-plug](https://github.com/junegunn/vim-plug):

```vim
call plug#begin()
Plug 'tpope/vim-dispatch'
Plug 'cherryramatisdev/gh.vim'
call plug#end()
```

## Available commands

- `GHCreate`: This command open a new tab with the `pull_request_template.md` content if it exists on the current project or just a blank one, this buffer is the body of your pull request
- `GHSubmit`: This command use the current buffer to create the PR as the body
- `GHOpen`: This command run `gh pr view -w` to open the current pull request on the browser

## Useful tips

1. If you define a comma separated list of names in a environment variable called `REVIEWERS`, this plugin will use this list to pre select the reviewers for the pull request.

2. If you have any script that generate a custom pull request title, it's possible to plug in by setting up the `g:GH_pr_title_cmd` that will be run on the shell and the output will be used as the pull request title, as the following example:

```vim
let g:GH_pr_title_cmd = 'jira pr-title'
```

3. If you want to run anything before the pull request is run (like moving the jira card from one column to another), it's possible to set a funcref on the global variable `g:GH_before_create_hook` as the following example:

```vim
function! JiraReview() abort
  Dispatch! jira review
endfunction

let g:GH_before_create_hook = function('JiraReview')
```
