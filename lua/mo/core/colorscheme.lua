local statuss, _ = pcall(vim.cmd, "colorscheme nightfly")
if not status then
  print("colorshceme not found")
  return
end
