local call = vim.call
local fnamemodify = vim.fn.fnamemodify
local M = {}

vim.cmd('let g:dein_snip_func_util_empty_dict = {}')
M.util = {
    empty_dict = vim.g.dein_snip_func_util_empty_dict
}

-- dein#add(repo: string, [options: dict])
M.add = function(repo, options)
    options = options or M.util.empty_dict
    return call('dein#parse#_add', repo, options, false)
end

-- dein#begin(base_path: string, [vimrcs: list])
M.begin = function(base_path, vimrcs)
    base_path = fnamemodify(base_path, ':p')
    local go = {}
    for _, value in ipairs(vimrcs) do
        table.insert(go, fnamemodify(value, ':p'))
    end
    return call('dein#util#_begin', base_path, go)
end

-- dein#end()
M.end0 = function()
    return call('dein#util#_end')
end

-- dein#min#load_state(base_path: string)
M.load_state = function(base_path)
    base_path = fnamemodify(base_path, ':p')
    return call('dein#min#load_state', base_path)
end

-- dein#load_toml(filename: string, [options: dict])
M.load_toml = function(filename, options)
    filename = fnamemodify(filename, ':p')
    options = options or M.util.empty_dict
    return call('dein#parse#_load_toml', filename, options)
end

-- dein#local(directory: string, [options: dict, [names: list]])
M.local0 = function(directory, options, names)
    directory = fnamemodify(directory, ':p')
    options = options or M.util.empty_dict
    names = names or { '*' }
    return call('dein#parse#_local', directory, options, names)
end

-- dein#save_state()
M.save_state = function()
    return call('dein#util#_save_state', vim.fn.has('vim_starting'))
end



return M
