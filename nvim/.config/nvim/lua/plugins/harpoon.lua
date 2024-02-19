return {
  "ThePrimeagen/harpoon",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = true,
  keys = {
    { "<leader>hm", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Harpoon: Mark File" },
    { "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", desc = "Harpoon: Prev" },
    { "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<cr>", desc = "Harpoon: Next" },
    { "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", desc = "Harpoon: File 1" },
    { "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", desc = "Harpoon: File 2" },
    { "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", desc = "Harpoon: File 3" },
    { "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", desc = "Harpoon: File 4" },
    { "<leader>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Harpoon: Menu" },
    { "<leader><CR>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Harpoon: Menu" },
  },
}
