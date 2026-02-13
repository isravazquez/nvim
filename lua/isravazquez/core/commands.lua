vim.api.nvim_create_user_command("SaveBufAs", function(opts)
  local path = vim.fn.expand(opts.args or "")
  if path == "" then
    vim.notify("Uso: :SaveBufAs /ruta/archivo.txt", vim.log.levels.ERROR)
    return
  end

  if vim.bo.buftype == "" then
    vim.cmd("saveas " .. vim.fn.fnameescape(path))
    return
  end

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local ok, err = pcall(vim.fn.writefile, lines, path)
  if not ok then
    vim.notify("No se pudo guardar: " .. tostring(err), vim.log.levels.ERROR)
    return
  end

  vim.notify("Buffer exportado a: " .. path)
end, { nargs = 1, complete = "file" })
