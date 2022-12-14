local M = {}

local fnamemodify = vim.fn.fnamemodify

--- dein#add({repo}[, {options}])
---   Initialize a plugin.
---   {repo} is the repository URI or local repository directory path. If {repo} starts with github user name (ex:"Shougo/dein.vim"), dein will install github plugins.
---   See |dein-options| for what to set in {options}.
---   Note: If plugin is already defined, duplicated calls will be ignored. If you want to overwrite plugin config, you need to use |dein-options-overwrite| or |dein#config()| instead.
---   Note: You must call it in |dein#begin()| block.
---   Note: If you install plugins, you need to call |dein#install()| manually.
---@param repo string
---@param options table|nil default: {} (dictionary)
M.add = function(repo, options)
    return vim.fn['dein#parse#_add'](repo, options or vim.empty_dict(), false)
end

--- dein#begin({base-path}[, {vimrcs}])
---   Initialize dein.vim and start plugins configuration block.
---   {base-path} is where your downloaded plugins will be placed. For example, "Shougo/dein.vim" will be downloaded in "{base-path}/repos/github.com/Shougo/dein.vim" directory.
---   {vimrcs} is a list of compared .vimrc and/or other configuration(TOML) files. The default is |$MYVIMRC|.
---   The typical {base-path} is "~/.cache/dein" or "~/.local/share/dein".
---   Note: You must not call the function inside a "has('vim_starting')" block.
---   Note: It executes ":filetype off" automatically.
---@param base_path string
---@param vimrcs table|nil default: {} (list)
M.begin = function(base_path, vimrcs)
    local go = {}
    if vimrcs ~= nil then
        for _, value in ipairs(vimrcs) do
            table.insert(go, fnamemodify(value, ':p'))
        end
    end
    return vim.fn['dein#util#_begin'](fnamemodify(base_path, ':p'), go)
end

--- dein#check_install({plugins})
---   Check {plugins} installation.
---   If {plugins} are not installed, it will return non-zero.
---   If {plugins} are invalid, it will return -1.
---   {plugins} are the plugins name list or the plugin name to check.
---   If you omit it, dein will check all plugins installation.
---   Note: You can disable the message by |:silent|.
---@param plugins table|nil default: {} (list)
M.check_install = function(plugins)
    return vim.fn['dein#util#_check_install'](plugins or {})
end

--- dein#end()
---   End dein configuration block.
---   You must not use the plugins in |dein#begin()| block. If you enable |g:dein#auto_recache|, it executes |dein#recache_runtimepath()| automatically.
---   Note: 'runtimepath' is changed after |dein#end()|.
M.end_ = function()
    return vim.fn['dein#util#_end']()
end

--- dein#install([{plugins}])
---   Install the plugins asynchronously.
---   {plugins} is the plugins name list.
---   If you omit it, dein will install all plugins.
---@param plugins table|nil default: {} (list)
M.install = function(plugins)
    return vim.fn['dein#install#_do'](plugins or {}, 'install', vim.fn['dein#install#_is_async']())
end

--- dein#min#load_state({base-path})
---   Load dein's state from the cache script, {base-path} is where your downloaded plugins will be placed.
--    Note: You must call it before |dein#begin()|. It clears dein all configuration.
--    Note: It overwrites your 'runtimepath' completely, you must not call it after change 'runtimepath' dynamically.
--    Note: The block is skipped if dein's state is loaded.
--    Note: |dein#min#load_state()| is faster a bit.
--    It returns 1, if the cache script is old or invalid or not found.
---@param base_path string
M.load_state = function(base_path)
    return vim.fn['dein#min#load_state'](fnamemodify(base_path, ':p'))
end

--- dein#load_toml({filename}[, {options}])
---   Load TOML plugin configuration from {filename}. See |dein-options| for keys to set in {options}.
---   Note: TOML parser is slow.  You should use it with |dein#load_state()| and |dein#save_state()|.
---   Note: You need to specify toml files in |dein#begin()| argument.
---   For toml file formats: |dein-toml|
---@param filename string
---@param options table|nil default: {} (dictionary)
M.load_toml = function(filename, options)
    return vim.fn['dein#parse#_load_toml'](fnamemodify(filename, ':p'), options or vim.empty_dict())
end

--- dein#local({directory}[, {options} [, {names}]])
---   Add the subdirectories in {directory} to 'runtimepath', like "pathogen" does. See |dein-options| for keys to set in {options}.
---   If {names} is given, {names} directories are only loaded. {names} is |wildcards| list.
---@param directory string
---@param options table|nil default: {} (dictionary)
---@param names table|nil default: {'\*'} (list)
M.local_ = function(directory, options, names)
    return vim.fn['dein#parse#_local'](fnamemodify(directory, ':p'), options or vim.empty_dict(), names or { '*' })
end

--- dein#save_state()
---   Save dein's state in the cache script.
---   It must be after |dein#end()|.
---   Note: It is available when loading .vimrc.
---   Note: It saves your 'runtimepath' completely, you must not call it after change 'runtimepath' dynamically.
M.save_state = function()
    return vim.fn['dein#util#_save_state'](vim.fn.has('vim_starting'))
end

return M
