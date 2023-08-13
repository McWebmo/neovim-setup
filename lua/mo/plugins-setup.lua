-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

return packer.startup(function(use)

  use("wbthomason/packer.nvim") -- packer plugin (manages itself)
  use("bluz71/vim-nightfly-guicolors") -- colorscheme
  use("nvim-lua/plenary.nvim")
  use("christoomey/vim-tmux-navigator") -- tmux & split window navigation (use ctrl+h,j,k,l to navigate between splits)

  -- essential plugins
  use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)
  use("inkarkat/vim-ReplaceWithRegister") -- replace with register contents using motion (gr + motion)
	
	use("kyazdani42/nvim-web-devicons") -- vs code icons

	use("nvim-tree/nvim-tree.lua") -- file explorer

	use("nvim-lualine/lualine.nvim") -- status line 

  if packer_bootstrap then
    require("packer").sync()
  end
end)
