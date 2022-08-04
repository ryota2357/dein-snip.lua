local dein = require('dein-snip.func')
local expand = vim.fn.expand
local M = {}
--[[
config = {
    path = {
        plugins           -- plugin's downloaded path
        dein              -- dein install(ed) path
        init
    }
    load = {
        vim               -- dein#inline_vimrcs
        toml              -- dein#load_toml()
        directory = {     -- dein#local()
            path
            options
            names
        }
    }
    auto_recache
    auto_remote_plugins
    cache_directory
    default_options
    download_command
    enable_hook_function_cache
    enable_name_conversion
    lazy_rplugins
    install = {
        check_diff
        check_remote_threshold
        github_api_token
        max_processes
        process_timeout
        progress_type
        message_type
        log_filename
        git = {
            clone_depth
            command_path
            default_hub_site
            default_protocol
            pull_command
        }
    }
    notification = {
        enable
        icon
        time
    }
}
]]

local g = function(variable, value)
    if value ~= nil then
        vim.g[variable] = value
    end
end

M.setup = function(config)
    -- set default option values
    config = config or {}
    config.path = config.path or {}
    config.path.plugins = expand(config.path.plugins or '~/.cache/dein')
    config.path.dein = expand(config.path.dein or '~/.cache/dein/repos/github.com/Shougo/dein.vim')
    config.path.init = expand(config.path.init or vim.env.MYVIMRC)
    config.load = config.load or {}

    -- setup dein.vim
    if not vim.fn.isdirectory(config.path.plugins) then
        vim.fn.mkdir(config.path.plugins, 'p')
    end
    if not string.match(vim.o.runtimepath, '/dein.vim') then
        if not vim.fn.isdirectory(config.path.dein) then
            os.execute('git clone https://github.com/Shougo/dein.vim ' .. config.path.dein)
        end
        vim.o.runtimepath = config.path.dein .. ',' .. vim.o.runtimepath
    end

    -- set dein global variables
    g('dein#auto_recache', config.auto_recache)
    g('dein#auto_remote_plugins', config.auto_remote_plugins)
    g('dein#cache_directory', config.cache_directory)
    g('dein#default_options', config.default_options)
    g('dein#download_command', config.download_command)
    g('dein#enable_hook_function_cache', config.enable_hook_function_cache)
    g('dein#enable_name_conversion', config.enable_name_conversion)
    g('dein#lazy_rplugins', config.lazy_rplugins)
    if config.install ~= nil then
        g('dein#install_check_diff', config.install.check_diff)
        g('dein#install_check_remote_threshold', config.install.check_remote_threshold)
        g('dein#install_github_api_token', config.install.github_api_token)
        g('dein#install_max_processes', config.install.max_processes)
        g('dein#install_process_timeout', config.install.process_timeout)
        g('dein#install_progress_type', config.install.progress_type)
        g('dein#install_message_type', config.install.message_type)
        g('dein#install_log_filename', config.install.log_filename)
        if config.install.git ~= nil then
            g('dein#types#git#clone_depth', config.install.git.clone_depth)
            g('dein#types#git#command_path', config.install.git.command_path)
            g('dein#types#git#default_hub_site', config.install.git.default_hub_site)
            g('dein#types#git#default_protocol', config.install.git.default_protocol)
            g('dein#types#git#pull_command', config.install.git.pull_command)
        end
    end
    if config.notification ~= nil then
        g('dein#enable_notification', config.notification.enable)
        g('dein#notification_icon', config.notification.icon)
        g('dein#notification_time', config.notification.time)
    end

    -- load plugins
    -- Note: lua dose not interpret 0 as false
    if dein.load_state(config.path.plugins) == 1 then
        if config.load.vim ~= nil then
            local inline_vim = {}
            for _, value in ipairs(config.load.vim) do
                table.insert(inline_vim, expand(value))
            end
            g('dein#inline_vimrcs', inline_vim)
        end

        local vimrcs = { config.path.init }
        if config.load.toml ~= nil then
            for _, value in ipairs(config.load.toml) do
                table.insert(vimrcs, value[1])
            end
        end

        dein.begin(config.path.plugins, vimrcs)

        if config.load.toml ~= nil then
            for _, value in ipairs(config.load.toml) do
                dein.load_toml(value[1], value[2])
            end
        end

        if config.load.directory ~= nil then
            dein.local0(config.load.directory.path, config.load.directory.options, config.load.directory.names)
        end

        dein.end0()
        dein.save_state()
    end
end

return M
