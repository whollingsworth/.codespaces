return {
	-- This causes import order issues that I can only resolve by manually adding
	-- it to `lua/config/lazy.lua`, which doesn't seem smart.
	-- { import = "lazyvim.plugins.extras.lang.ruby" },
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "ruby" } },
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				-- Disable Mason to ensure the correct gem is selected, per
				-- recommendation from the Ruby LSP team:
				-- https://shopify.github.io/ruby-lsp/editors.html#lazyvim-lsp
				ruby_lsp = {
					mason = false,
					cmd = { vim.fn.expand("$GEM_HOME") .. "/bin/ruby-lsp" },
				},
				-- Tell Rubocop where the gems we use for linting are
				rubocop = {
					root_dir = vim.fn.expand("$PANORAMA_TOP/monorama"),
					cmd_env = { BUNDLE_GEMFILE = ".overcommit/Gemfile" },
					cmd = { "bundle", "exec", "rubocop", "--lsp" },
				},
			},
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters = {
				-- Tell Rubocop where the gems we use for linting are
				rubocop = {
					cwd = require("conform.util").root_file({ ".overcommit_gems.rb" }),
					env = { BUNDLE_GEMFILE = ".overcommit/Gemfile" },
					command = "bundle",
					args = { "exec", "rubocop", "$FILENAME" },
				},
			},
		},
	},
}
