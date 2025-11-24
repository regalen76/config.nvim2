vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

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

    -- Goto
    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
    nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("gt", vim.lsp.buf.type_definition, "[G]oto [T]ype")

    -- Hover / info
    nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Help")

    -- Workspace / symbols
    nmap("<leader>cwa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>cwr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<leader>cwl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")
    nmap("<leader>cds", vim.lsp.buf.document_symbol, "[D]ocument [S]ymbols")
    nmap("<leader>cws", vim.lsp.buf.workspace_symbol, "[W]orkspace [S]ymbols")

    -- Code actions / refactor
    nmap("<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    -- Diagnostics
    nmap("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
    nmap("]d", vim.diagnostic.goto_next, "Go to next diagnostic")
    nmap("<leader>ce", vim.diagnostic.open_float, "Open diagnostic float")
    nmap("<leader>cq", vim.diagnostic.setloclist, "Diagnostics to loclist")
  end,
})
