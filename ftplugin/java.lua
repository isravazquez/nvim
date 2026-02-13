local ok_jdtls, jdtls = pcall(require, "jdtls")
if not ok_jdtls then
  return
end

if vim.fn.executable("java") ~= 1 then
  vim.notify("Java no esta en PATH. Instala/configura un JDK 21+.", vim.log.levels.ERROR)
  return
end

local java_version_output = vim.fn.systemlist("java -version 2>&1")
local version_line = java_version_output[1] or ""
local major = tonumber(version_line:match('version%s+"(%d+)'))
if major and major < 21 then
  vim.notify("jdtls actual requiere JDK 21+. Version detectada: " .. major, vim.log.levels.ERROR)
  return
end

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", "build.gradle.kts" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == nil or root_dir == vim.NIL or root_dir == "" then
  return
end

root_dir = vim.fs.normalize(root_dir)

local mason_bin_jdtls = vim.fn.stdpath("data") .. "/mason/bin/jdtls"
if vim.fn.executable(mason_bin_jdtls) ~= 1 then
  vim.notify("No se encontro jdtls en Mason. Ejecuta :Mason y verifica jdtls.", vim.log.levels.ERROR)
  return
end

local project_name = vim.fs.basename(root_dir)
if project_name == nil or project_name == "" then
  project_name = "java-workspace"
end
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

local config = {
  cmd = {
    mason_bin_jdtls,
    "-data",
    workspace_dir,
  },
  root_dir = root_dir,
  capabilities = capabilities,
  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
      },
    },
  },
  init_options = {
    bundles = {},
  },
}

jdtls.start_or_attach(config)
