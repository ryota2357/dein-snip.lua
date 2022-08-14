local dein = require('dein-snip.func')
local fnamemodify = vim.fn.fnamemodify
local M = {}

local g = function(variable, value)
    if value ~= nil then
        vim.g[variable] = value
    end
end

M.setup = function(config)
    -- set default option values
    config = config or {}
    config.path = config.path or {}
    config.path.plugins = fnamemodify(config.path.plugins or '~/.cache/dein', ':p')
    config.path.dein = fnamemodify(config.path.dein or '~/.cache/dein/repos/github.com/Shougo/dein.vim', ':p')
    config.path.init = fnamemodify(config.path.init or vim.env.MYVIMRC, ':p')
    config.load = config.load or {}
    config.load.check_install = config.load.check_install or false

    -- setup dein.vim
    if not vim.fn.isdirectory(config.path.plugins) then
        vim.fn.mkdir(config.path.plugins, 'p')
    end
    if not string.match(vim.o.runtimepath, '/dein.vim') then
        if vim.fn.isdirectory(config.path.dein) == 0 then
            os.execute('git clone https://github.com/Shougo/dein.vim ' .. config.path.dein)
        end
        vim.opt.runtimepath:prepend(config.path.dein)
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
        g('dein#install_copy_vim', config.install.copy_vim)
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
    if dein.load_state(config.path.plugins) == 1 then
        if config.load.vim ~= nil then
            local inline_vim = {}
            for _, value in ipairs(config.load.vim) do
                table.insert(inline_vim, fnamemodify(value, ':p'))
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

        if config.load.raw ~= nil then
            for _, value in ipairs(config.load.raw) do
                dein.add(value[1], value[2])
            end
        end

        if config.load.toml ~= nil then
            for _, value in ipairs(config.load.toml) do
                dein.load_toml(value[1], value[2])
            end
        end

        if config.load.directory ~= nil then
            dein.local0(config.load.directory.path, config.load.directory.options, config.load.directory.names)
        end

        if config.load.check_install then
            if dein.check_install() == 1 then
                dein.install()
            end
        end

        dein.end0()
        dein.save_state()
    end
end

return M
