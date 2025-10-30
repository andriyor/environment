-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
-- if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add gruvbox
  { "sindrets/diffview.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fd",
        function()
          require("telescope.builtin").find_files({
            attach_mappings = function(_, map)
              local actions = require("telescope.actions")
              local action_state = require("telescope.actions.state")

              map("n", "<leader>d", function(prompt_bufnr)
                local picker = action_state.get_current_picker(prompt_bufnr)
                local selections = picker:get_multi_selection()

                if #selections == 2 then
                  actions.close(prompt_bufnr)
                  vim.cmd("edit " .. selections[1].path)
                  vim.cmd("diffthis")
                  vim.cmd("vsplit " .. selections[2].path)
                  vim.cmd("diffthis")
                else
                  print("Select exactly 2 files with <Tab>")
                end
              end)

              return true
            end,
          })
        end,
        desc = "Find files (with diff support)",
      },
    },
  },
}
