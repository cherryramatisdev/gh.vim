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
