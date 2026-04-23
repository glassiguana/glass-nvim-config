local function read_colorscheme()
    local file = io.open(vim.fn.expand("~/.config/nvim/active-colorscheme"), "r")
    if file then
        local scheme = file:read("*l")
        file:close()
        return scheme
    end
    return "gruvbox" -- fallback
end

local colorscheme = read_colorscheme()
local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not is_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end
