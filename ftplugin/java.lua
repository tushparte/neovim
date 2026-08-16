local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.expand('~/.cache/jdtls/workspace/') .. project_name

local config = {
  cmd = {'jdtls', '-data', workspace_dir},
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  root_dir = vim.fs.dirname(vim.fs.find({'pom.xml', 'build.gradle', '.git'}, { upward = true })[1]),
  init_options = {
    bundles = vim.split(
      vim.fn.glob('/Users/tushparte/.m2/repository/p2/osgi/bundle/**/*.jar'),
      "\n",
      { trimempty = true }
    )
  },
  settings = {
    java = {
      format = { enabled = true },
      completion = {
        importOrder = { 'java', 'javax', 'com', 'org' },
      },
      inlayHints = {
        parameterNames = { enabled = 'all' },
      },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },
    }
  }
}

require('jdtls').start_or_attach(config)
