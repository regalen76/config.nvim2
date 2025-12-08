vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local signs = {
			Error = " ",
			Warn = " ",
			Hint = "󰌵 ",
			Info = " ",
		}

		local signConf = {
			text = {},
			texthl = {},
			numhl = {},
		}

		for type, icon in pairs(signs) do
			local severityName = string.upper(type)
			local severity = vim.diagnostic.severity[severityName]
			local hl = "DiagnosticSign" .. type
			signConf.text[severity] = icon
			signConf.texthl[severity] = hl
			signConf.numhl[severity] = hl
		end

		vim.diagnostic.config({
			signs = signConf,
		})

		local bufnr = args.buf
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

		-- Inline completion
		if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, bufnr) then
			vim.lsp.inline_completion.enable(true, { bufnr = bufnr })

			vim.keymap.set(
				"i",
				"<C-F>",
				vim.lsp.inline_completion.get,
				{ desc = "LSP: accept inline completion", buffer = bufnr }
			)
			vim.keymap.set(
				"i",
				"<C-G>",
				vim.lsp.inline_completion.select,
				{ desc = "LSP: switch inline completion", buffer = bufnr }
			)
		end

		vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

		local function nmap(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
		end

		-- Try Snacks
		local ok_snacks, Snacks = pcall(require, "snacks")

		---------------------------------------------------------------------------
		-- LSP navigation using Snacks picker (with LSP fallback)
		---------------------------------------------------------------------------
		if ok_snacks then
			-- Goto
			nmap("gd", function()
				Snacks.picker.lsp_definitions()
			end, "Goto Definition")

			nmap("gD", function()
				Snacks.picker.lsp_declarations()
			end, "Goto Declaration")

			nmap("gr", function()
				Snacks.picker.lsp_references()
			end, "References")

			nmap("gi", function()
				Snacks.picker.lsp_implementations()
			end, "Goto Implementation")

			nmap("gy", function()
				Snacks.picker.lsp_type_definitions()
			end, "Goto T[y]pe Definition")

			nmap("gai", function()
				Snacks.picker.lsp_incoming_calls()
			end, "C[a]lls Incoming")

			nmap("gao", function()
				Snacks.picker.lsp_outgoing_calls()
			end, "C[a]lls Outgoing")

			-- Symbols
			nmap("<leader>ss", function()
				Snacks.picker.lsp_symbols()
			end, "LSP Symbols")

			nmap("<leader>sS", function()
				Snacks.picker.lsp_workspace_symbols()
			end, "LSP Workspace Symbols")
		else
			-- Fallback to plain LSP if Snacks isn't available
			nmap("gd", vim.lsp.buf.definition, "Goto Definition")
			nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
			nmap("gr", vim.lsp.buf.references, "References")
			nmap("gi", vim.lsp.buf.implementation, "Goto Implementation")
			nmap("gy", vim.lsp.buf.type_definition, "Goto Type Definition")
			if vim.lsp.buf.incoming_calls then
				nmap("gai", vim.lsp.buf.incoming_calls, "Calls Incoming")
			end
			if vim.lsp.buf.outgoing_calls then
				nmap("gao", vim.lsp.buf.outgoing_calls, "Calls Outgoing")
			end
			nmap("<leader>ss", vim.lsp.buf.document_symbol, "Document Symbols")
			nmap("<leader>sS", vim.lsp.buf.workspace_symbol, "Workspace Symbols")
		end

		---------------------------------------------------------------------------
		-- Other LSP keymaps (kept as before)
		---------------------------------------------------------------------------
		-- Hover / info
		nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Help")

		-- Workspace folders
		nmap("<leader>cwa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
		nmap("<leader>cwr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
		nmap("<leader>cwl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "[W]orkspace [L]ist Folders")

		-- Code actions / refactor
		nmap("<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")
		nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

		-- Diagnostics
		nmap("[d", vim.diagnostic.jump({next = false}), "Go to previous diagnostic")
		nmap("]d", vim.diagnostic.jump({next = true}), "Go to next diagnostic")
		nmap("<leader>ce", vim.diagnostic.open_float, "Open diagnostic float")
		nmap("<leader>cq", vim.diagnostic.setloclist, "Diagnostics to loclist")
	end,
})
