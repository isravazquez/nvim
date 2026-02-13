vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("v", "fd", "<ESC>", { desc = "Exit visual mode with fd" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split window sizes equal
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) -- go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) -- go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) -- move current buffer to new tab

-- Save and quit
keymap.set("n", "<leader>w", function()
  local has_name = vim.api.nvim_buf_get_name(0) ~= ""
  local is_normal_buf = vim.bo.buftype == ""

  if has_name and is_normal_buf then
    vim.cmd("w")
    return
  end

  local default_name = has_name and vim.api.nvim_buf_get_name(0) or (vim.fn.getcwd() .. "/")
  vim.ui.input({
    prompt = "Guardar como: ",
    default = default_name,
    completion = "file",
  }, function(input)
    if not input or input == "" then
      return
    end
    vim.cmd("SaveBufAs " .. vim.fn.fnameescape(input))
  end)
end, { desc = "Write or save-as current buffer" })

keymap.set("n", "<leader>wa", function()
  local default_name = vim.api.nvim_buf_get_name(0)
  if default_name == "" then
    default_name = vim.fn.getcwd() .. "/"
  end

  vim.ui.input({
    prompt = "Guardar como: ",
    default = default_name,
    completion = "file",
  }, function(input)
    if not input or input == "" then
      return
    end
    vim.cmd("SaveBufAs " .. vim.fn.fnameescape(input))
  end)
end, { desc = "Always save current buffer as file" })

keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap.set("n", "<leader>qa", ":qa<CR>", { desc = "Quit all" })

-- Delete without yanking
keymap.set({ "n", "x" }, "x", '"_x')
keymap.set("n", "X", '"_X')
