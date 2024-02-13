local M = {}

local buffers, windows = {}, {}
local size = 0.9

local function open_window(process)
    local ui_info = vim.api.nvim_list_uis()[1]
    local width = math.floor(ui_info.width * size)
    local height = math.floor(ui_info.height * size)
    local border = "rounded"
    if size == 1 then
        border = "none"
    end
    windows[process] = vim.api.nvim_open_win(buffers[process], true, {
        relative = "editor",
        width = width,
        height = height,
        row = (ui_info.height - height) * 0.5 - 1,
        col = (ui_info.width - width) * 0.5,
        style = "minimal",
        border = border
    })
end

local function create_window(process)
    local termplug_augroup = vim.api.nvim_create_augroup("termplug_" .. process, { clear = true })
    vim.api.nvim_create_autocmd("TermClose", {
        callback = function()
            if vim.api.nvim_get_current_buf() ~= buffers[process] then
                return
            end
            if vim.api.nvim_buf_is_valid(buffers[process]) then
                vim.api.nvim_buf_delete(buffers[process], { force = true })
            end
            if vim.api.nvim_win_is_valid(windows[process]) then
                vim.api.nvim_win_close(windows[process], true)
            end
        end,
        group = termplug_augroup,
    })
    open_window(process)
    vim.cmd("set winhl=NormalFloat:Normal")
end

function M.toggle(process)
    if process == nil then
        process = "bash"
    end
    if buffers[process] == nil or not vim.api.nvim_buf_is_valid(buffers[process]) then
        local new_buf = vim.api.nvim_create_buf(false, true)
        buffers[process] = new_buf
        create_window(process)
        vim.fn.termopen(process)
        vim.cmd("startinsert")
    else
        if vim.api.nvim_get_current_buf() == buffers[process] then
            vim.api.nvim_win_close(windows[process], true)
        else
            open_window(process)
            vim.cmd("startinsert")
        end
    end
end

function M.setup(opts)
    opts = opts or {}

    size = opts.size or size

    vim.api.nvim_command('command! -nargs=? Term lua require("termplug").toggle(<f-args>)')
end

return M
