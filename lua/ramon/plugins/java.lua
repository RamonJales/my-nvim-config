return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
  },
  config = function()
    local function start_jdtls()
      if vim.bo.filetype ~= "java" then
        return
      end

      local ok_jdtls, jdtls = pcall(require, "jdtls")
      local ok_setup, jdtls_setup = pcall(require, "jdtls.setup")
      local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

      if not (ok_jdtls and ok_setup and ok_cmp) then
        return
      end

      local java_home = vim.env.JDTLS_JAVA_HOME or vim.env.JAVA_HOME
      local java_bin = java_home and (java_home .. "/bin/java") or "java"
      local java_version_output = vim.fn.system(java_bin .. " -version 2>&1")
      local java_major = tonumber(java_version_output:match('version%s+"(%d+)'))

      if java_major ~= nil and java_major < 21 then
        local msg = "jdtls requires Java 21+. Current runtime: Java " .. java_major .. ". Set JDTLS_JAVA_HOME or JAVA_HOME to a Java 21 installation."
        vim.schedule(function()
          vim.notify(msg, vim.log.levels.ERROR)
        end)
        return
      end

      local root_markers = {
        ".git",
        "mvnw",
        "gradlew",
        "pom.xml",
        "build.gradle",
        "build.gradle.kts",
      }
      local root_dir = jdtls_setup.find_root(root_markers)

      if root_dir == "" then
        root_dir = vim.fn.getcwd()
      end

      local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
      local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. project_name
      local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
      local jdtls_path = mason_packages .. "/jdtls"
      local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

      if launcher == "" then
        vim.notify("jdtls launcher was not found inside Mason.", vim.log.levels.ERROR)
        return
      end

      local os_config = "config_linux"
      if vim.fn.has("mac") == 1 then
        os_config = "config_mac"
      elseif vim.fn.has("win32") == 1 then
        os_config = "config_win"
      end

      local config = {
        cmd = {
          java_bin,
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ERROR",
          "-Xmx1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens",
          "java.base/java.util=ALL-UNNAMED",
          "--add-opens",
          "java.base/java.lang=ALL-UNNAMED",
          "-jar",
          launcher,
          "-configuration",
          jdtls_path .. "/" .. os_config,
          "-data",
          workspace_dir,
        },
        root_dir = root_dir,
        capabilities = cmp_nvim_lsp.default_capabilities(),
        settings = {
          java = {
            eclipse = {
              downloadSources = true,
            },
            maven = {
              downloadSources = true,
            },
            signatureHelp = {
              enabled = true,
            },
            contentProvider = {
              preferred = "fernflower",
            },
            completion = {
              favoriteStaticMembers = {
                "org.junit.jupiter.api.Assertions.*",
                "org.mockito.Mockito.*",
                "org.assertj.core.api.Assertions.*",
              },
            },
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
            codeGeneration = {
              toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
              },
              useBlocks = true,
            },
            format = {
              enabled = true,
            },
          },
        },
      }

      jdtls.start_or_attach(config)
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = start_jdtls,
    })
  end,
}
