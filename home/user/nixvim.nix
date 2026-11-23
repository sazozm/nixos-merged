{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    opts = {
      autoread = true;
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      termguicolors = true;
      signcolumn = "yes";
      clipboard = "unnamedplus";
      conceallevel = 2;

      cursorline = true;
      scrolloff = 8;
      sidescrolloff = 8;
      splitbelow = true;
      splitright = true;
      ignorecase = true;
      smartcase = true;
      wrap = false;
      undofile = false;
      swapfile = false;
      backup = false;

      updatetime = 300;
      timeoutlen = 250;

      synmaxcol = 240;

      lazyredraw = true;
      ttyfast = true;

      foldcolumn = "1";
      foldlevel = 99;
      foldlevelstart = 99;
      foldenable = true;

      list = true;
      listchars = "tab:→ ,trail:·,nbsp:␣";
      fillchars = "eob: ,fold: ,foldopen:▼,foldclose:▶,vert:│";
      pumheight = 10;
      confirm = true;
      mouse = "a";
      grepprg = "rg --vimgrep --no-heading";
      completeopt = "menuone,noinsert,noselect";
    };

    globals.mapleader = " ";
    globals.maplocalleader = ",";
  };
}
