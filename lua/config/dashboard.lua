local dashboard = require("dashboard")

local header = {
    "                                                          ",
    "   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗   ",
    "   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║   ",
    "   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║   ",
    "   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║   ",
    "   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║   ",
    "   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝   ",
    "                                                          ",
}

local version = vim.version()
local plugins = require("lazy").stats().count

local fortune = vim.fn.system("fortune -s 2>/dev/null | tr '\n' ' '")
fortune = fortune:gsub("%s+$", "")
if fortune == "" or vim.v.shell_error ~= 0 then
    fortune = "Have a great coding session!"
end

local function wrap(str, limit)
    local result = {}
    local line = ""
    for word in str:gmatch("%S+") do
        if #line + #word + 1 > limit then
            table.insert(result, line)
            line = word
        else
            line = line == "" and word or line .. " " .. word
        end
    end
    if line ~= "" then table.insert(result, line) end
    return result
end

local wrapped_fortune = wrap(fortune, 60)

local total_lines = vim.o.lines
local content_height = #header + #wrapped_fortune + 2 + 4 + 2 + 2
local padding = math.floor((total_lines - content_height) / 2)
padding = math.max(padding, 0)

local final_header = {}
for _ = 1, padding do
    table.insert(final_header, "")
end
for _, line in ipairs(header) do
    table.insert(final_header, line)
end
table.insert(final_header, "")
for _, line in ipairs(wrapped_fortune) do
    table.insert(final_header, line)
end
table.insert(final_header, "")

local footer = {
    "",
    "v" .. version.major .. "." .. version.minor .. "." .. version.patch .. "   " .. plugins .. " plugins",
}

dashboard.setup({
    theme = "doom",
    config = {
        header = final_header,
        center = {
            {
                icon = "  ",
                desc = "Find File",
                key = "f",
                action = "Telescope find_files",
            },
            {
                icon = "  ",
                desc = "Recent Files",
                key = "r",
                action = "Telescope oldfiles",
            },
            {
                icon = "  ",
                desc = "New File",
                key = "n",
                action = "enew",
            },
            {
                icon = "  ",
                desc = "Quit",
                key = "q",
                action = "qa",
            },
        },
        footer = footer,
    },
})
