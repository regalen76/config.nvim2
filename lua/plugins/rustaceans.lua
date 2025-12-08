return {
	"mrcjkb/rustaceanvim",
	ft = { "rust" }, -- optional; plugin is lazy by itself
	opts = {
		server = {
			on_attach = function(_, bufnr)
				-- Code action
				vim.keymap.set("n", "<leader>cR", function()
					vim.cmd.RustLsp("codeAction")
				end, { desc = "Rust Code Action", buffer = bufnr })

				-- Debuggables
				vim.keymap.set("n", "<leader>dr", function()
					vim.cmd.RustLsp("debuggables")
				end, { desc = "Rust Debuggables", buffer = bufnr })
			end,

			default_settings = {
				["rust-analyzer"] = (function()
					local enable_ra_diagnostics = false -- change to false if you don’t want them

					return {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							buildScripts = {
								enable = true,
							},
						},
						checkOnSave = enable_ra_diagnostics,
						diagnostics = {
							enable = enable_ra_diagnostics,
						},
						procMacro = {
							enable = true,
						},
						files = {
							exclude = {
								".direnv",
								".git",
								".jj",
								".github",
								".gitlab",
								"bin",
								"node_modules",
								"target",
								"venv",
								".venv",
							},
							-- Avoid Roots Scanned hanging
							watcher = "client",
						},
					}
				end)(),
			},
		},
		tools = {
			enable_clippy = true,
		},
	},

	config = function(_, opts)
		-- DAP / codelldb (optional)
		local codelldb = vim.fn.exepath("codelldb")
		if codelldb ~= "" then
			local ok, cfg = pcall(require, "rustaceanvim.config")
			if ok then
				-- detect OS
				local sysname = vim.uv and vim.uv.os_uname().sysname or vim.loop.os_uname().sysname
				local ext = (sysname == "Linux") and ".so" or ".dylib"

				-- mason install dir
				local mason = vim.fn.stdpath("data") .. "/mason"
				local liblldb_path = mason .. "/packages/codelldb/extension/lldb/lib/liblldb" .. ext

				opts.dap = {
					adapter = cfg.get_codelldb_adapter(codelldb, liblldb_path),
				}
			end
		end

		-- Apply rustaceanvim options
		vim.g.rustaceanvim = vim.tbl_deep_extend("force", vim.g.rustaceanvim or {}, opts or {})

		-- rust-analyzer presence check
		if vim.fn.executable("rust-analyzer") == 0 then
			vim.notify(
				"rust-analyzer not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
				vim.log.levels.ERROR
			)
		end

		-- bacon
		vim.diagnostic.config(vim.tbl_deep_extend("force", vim.diagnostic.config(), {
			update_in_insert = true,
		}))
		vim.lsp.config("bacon-ls", {
			init_options = {
				-- Bacon export filename (default: .bacon-locations).
				locationsFile = ".bacon-locations",
				-- Try to update diagnostics every time the file is saved (default: true).
				updateOnSave = true,
				--  How many milliseconds to wait before updating diagnostics after a save (default: 1000).
				updateOnSaveWaitMillis = 1000,
				-- Try to update diagnostics every time the file changes (default: true).
				updateOnChange = true,
				-- Try to validate that bacon preferences are setup correctly to work with bacon-ls (default: true).
				validateBaconPreferences = true,
				-- f no bacon preferences file is found, create a new preferences file with the bacon-ls job definition (default: true).
				createBaconPreferencesFile = true,
				-- Run bacon in background for the bacon-ls job (default: true)
				runBaconInBackground = true,
				-- Command line arguments to pass to bacon running in background (default "--headless -j bacon-ls")
				runBaconInBackgroundCommandArguments = "--headless -j bacon-ls",
				-- How many milliseconds to wait between background diagnostics check to synchronize all open files (default: 2000).
				synchronizeAllOpenFilesWaitMillis = 2000,
			},
		})
		vim.lsp.enable("bacon_ls")
	end,
}
