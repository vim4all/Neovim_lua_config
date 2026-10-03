-- clang-format style shared by conform and equalprg: respect a project's
-- .clang-format (e.g. EVerest), fall back to LLVM + Allman braces otherwise.
local M = {}

M.fallback = "{BasedOnStyle: LLVM, BreakBeforeBraces: Allman}"

function M.has_project_style(path)
  return #vim.fs.find({ ".clang-format", "_clang-format" }, { upward = true, path = path }) > 0
end

-- Returns the --style argument for the given buffer
function M.arg(buf)
  local dir = vim.fs.dirname(vim.api.nvim_buf_get_name(buf))
  if M.has_project_style(dir) then return "--style=file" end
  return "--style=" .. M.fallback
end

return M
