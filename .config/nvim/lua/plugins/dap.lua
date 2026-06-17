return { -- Debug Adapter Protocol configuration for Dart & Flutter
	-- The `dap.core` extra already provides nvim-dap, dap-ui and virtual-text
	-- (along with the default `<leader>d` keymaps), so here we only register the
	-- Dart/Flutter adapters and their launch configurations.
	"mfussenegger/nvim-dap",
	optional = true,
	-- Use `opts` (chained additively by lazy.nvim) rather than `config`, so we
	-- register adapters without clobbering the `dap.core` extra's own setup.
	opts = function()
		local dap = require("dap")

		-- Adapters: shipped with the Dart and Flutter SDKs (`dart`/`flutter` on $PATH).
		if not dap.adapters["dart"] then
			dap.adapters["dart"] = {
				type = "executable",
				command = "dart",
				args = { "debug_adapter" },
			}
		end
		if not dap.adapters["flutter"] then
			dap.adapters["flutter"] = {
				type = "executable",
				command = "flutter",
				args = { "debug_adapter" },
			}
		end

		dap.configurations.dart = {
			{
				type = "dart",
				request = "launch",
				name = "Launch dart",
				dartSdkPath = "dart",
				flutterSdkPath = "flutter",
				program = "${file}",
				cwd = "${workspaceFolder}",
			},
			{
				type = "flutter",
				request = "launch",
				name = "Launch flutter",
				dartSdkPath = "dart",
				flutterSdkPath = "flutter",
				program = "${workspaceFolder}/lib/main.dart",
				cwd = "${workspaceFolder}",
			},
		}
	end,
}
