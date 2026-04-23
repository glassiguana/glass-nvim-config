local function apply_transparency()
    local file = io.open(vim.fn.expand("~/.config/nvim/active-transparency"), "r")
    if file then
        local state = file:read("*l")
        file:close()
        if state == "transparent" then
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end
    end
end

apply_transparency()

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.schedule(apply_transparency)
    end,
})
