# dein-snip

**dein.vim has lua api (`require('dein')`).**

The wrapper plugin for [dein.vim](https://github.com/Shougo/dein.vim).

## Setup

1st, clone this repository.

```sh
$ git clone https://github.com/ryota2357/dein-snip.lua
```

2nd, load this plugin at the top of init.lua.

```lua
-- init.lua
vim.opt.runtimepath:prepend(vim.fn.expand('~/path/to/dein-snip.lua'))
```

<details>
<summary>How to auto-install and load dein-snip.lua. </summary>

If you have not set `path` in `setup()` or are using the default settings, the following script is good for you.

For `path`, please read `:help dein-snip-config-path`.

```lua
local dein_snip = vim.fn.fnamemodify('~/.cache/dein/repos/github.com/ryota2357/dein-snip.lua', ':p')
if not string.match(vim.o.runtimepath, '/dein-snip.lua') then
    if vim.fn.isdirectory(dein_snip) == 0 then
        os.execute('git clone https://github.com/ryota2357/dein-snip.lua.git ' .. dein_snip)
    end
    vim.opt.runtimepath:prepend(dein_snip)
end
```

</details>

Last, call setup() function.

```lua
require('dein-snip').setup()
```

**NOTE**: You don't have to install or load dein.vim. dein-snip.lua automatically install dein.vim and add it to runtimepath.

For more details, please read [help](doc/dein-snip.txt)

## Example

```lua
require('dein-snip').setup {
    load = {
        vim = {
            '~/dotfiles/vim/rc/option.rc.vim',
            '~/dotfiles/vim/rc/mapping.rc.vim'
        },
        toml = {
            '~/dotfiles/vim/rc/dein.toml',
            { '~/dotfiles/vim/rc/dein-lazy.toml', { lazy = true } }
        },
        raw = {
            'vim-denops/denops.vim',
            { 'vim-jp/vimdoc-ja', { hook_add = 'set helplang=ja,en' } }
        },
        check_install = true
    },
    notification = {
        enable = true,
        time = 3000
    },
    auto_recache = true
}
```

## Correspondence Table

### Functions

You don't have to call dein's functions.  
Based on your configuation setted in dein-snip.setup(), dein's functions are automatically called.

If you want to call a dein's function, you can use `vim.call()` or `vim.cmd()`.  
However, this plugin defines some wrappers, so you can use them too with `require('dein-snip.func')`.

| dein-functions                                    | require('dein-snip.func')                                           |
| :------------------------------------------------ | :------------------------------------------------------------------ |
| `dein#add({repo}[, {options}])`                   | `add(repo: string, options: table\|nil)`                            |
| `dein#begin({base-path}[, {vimrcs}])`             | `begin(base_path: string, vimrcs: list\|nil)`                       |
| `dein#check_install({plugins})`                   | `check_install(plugins: table\|nil)`                                |
| `dein#end()`                                      | `end_()`                                                            |
| `dein#install([{plugins}])`                       | `install(plugins: table\|nil)`                                      |
| `dein#min#load_state({base-path})`                | `load_state(base_path: string)`                                     |
| `dein#load_toml({filename}[, {options}])`         | `load_toml(filename: string, options: table\|nil)`                  |
| `dein#local({directory}[, {options}[, {names}]])` | `local_(directory: string, options: table\|nil, names: table\|nil)` |
| `dein#save_state()`                               | `save_state()`                                                      |

### Variables

You can set dein's variables without wrriing vimscript.  
You can set them in dein-snip.setup().

| dein-variables                          | dein-snip-config                 |
| :-------------------------------------- | :------------------------------- |
| `g:dein#auto_recache`                   | `auto_recache`                   |
| `g:dein#auto_remote_plugins`            | `auto_remote_plugins`            |
| `g:dein#cache_directory`                | `cache_directory`                |
| `g:dein#default_options`                | `default_options`                |
| `g:dein#download_command`               | `download_command`               |
| `g:dein#enable_hook_function_cache`     | `enable_hook_function_cache`     |
| `g:dein#enable_name_conversion`         | `enable_name_conversion`         |
| `g:dein#enable_notification`            | `notification.enable`            |
| `g:dein#ftplugin`                       | not support                      |
| `g:dein#inline_vimrc`                   | `load.vim`                       |
| `g:dein#install_check_diff`             | `install.check_diff`             |
| `g:dein#install_check_remote_threshold` | `install.check_remote_threshold` |
| `g:dein#install_copy_vim`               | `install.copy_vim`               |
| `g:dein#install_github_api_token`       | `install.github_api_token`       |
| `g:dein#install_max_processes`          | `install.max_processes`          |
| `g:dein#install_process_timeout`        | `install.process_timeout`        |
| `g:dein#install_progress_type`          | `install.progress_type`          |
| `g:dein#install_message_type`           | `install.message_type`           |
| `g:dein#install_log_filename`           | `install.log_filename`           |
| `g:dein#lazy_rplugins`                  | `lazy_rplugins`                  |
| `g:dein#name` (deprecated)              | not support                      |
| `g:dein#notification_icon`              | `notification.icon`              |
| `g:dein#notification_time`              | `notification.time`              |
| `g:dein#plugin`                         | not support                      |
| `g:dein#types#git#clone_depth`          | `install.git.clone_depth`        |
| `g:dein#types#git#command_path`         | `install.git.command_path`       |
| `g:dein#types#git#default_hub_site`     | `install.git.default_hub_site`   |
| `g:dein#types#git#default_protocol`     | `install.git.default_protocol`   |
| `g:dein#types#git#pull_command`         | `install.git.pull_command`       |
| `g:dein#types#git#enable_partial_clone` | `install.git.partial_clone`      |
