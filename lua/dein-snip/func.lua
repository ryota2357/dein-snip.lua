local call = vim.call
local M = {}

vim.cmd('let g:dein_toml_func_util_empty_dict = {}')
M.util = {
    empty_dict = vim.g.dein_toml_func_util_empty_dict
}

-- dein#min#load_state(base_path: string)
M.load_state = function(base_path)
    return call('dein#min#load_state', base_path)
end

-- dein#begin(base_path: string, [vimrcs: list])
M.begin = function(base_path, vimrcs)
    return call('dein#util#_begin', base_path, vimrcs or {})
end

-- dein#end()
M.end0 = function()
    return call('dein#util#_end')
end

-- dein#save_state()
M.save_state = function()
    return call('dein#util#_save_state', vim.fn.has('vim_starting'))
end

-- dein#load_toml(filename: string, [options: dict])
M.load_toml = function(filename, options)
    return call('dein#parse#_load_toml', filename, options or M.util.empty_dict)
end

-- dein#local(directory: string, [options: dict, [names: list]])
M.local0 = function(directory, options, names)
    return call('dein#parse#_local',directory, options or M.util.empty_dict, names or {'*'})
end

return M
