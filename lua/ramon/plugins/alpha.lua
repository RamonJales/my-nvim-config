return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Set header
		-- some cool headers: https://github.com/goolord/alpha-nvim/discussions/16
		-- dashboard.section.header.val = {
		--   "                                                     ",
		--   "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
		--   "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
		--   "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
		--   "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
		--   "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
		--   "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
		--   "                                                     ",
		-- }
		--
		--

		dashboard.section.header.val = {

			[[                            . .  ,  ,                                    , ,\/\/\           ]],
			[[                            |` \/ \/ \,',                          , |\|\|`     :           ]],
			[[                            ;          ` \/\,.               .-.|`              \           ]],
			[[                           :               ` \,/            \-\                  \          ]],
			[[                           |                  /              \                    :         ]],
			[[                           ;                 :                \          ____ ,-^-.         ]],
			[[                          :                  ;                 \       ,'    `.   o\        ]],
			[[                          |      ,---.      /                   \     (    o  :    ;        ]],
			[[                         :     ,'     `,-._ \                    \     \      ;`-"' )       ]],
			[[                         ;    (   o    \   `'                     \_    `-..-'   -'(        ]],
			[[                       _:      .      ,'  o ;                    ,'a`               \       ]],
			[[                      /,.`      `.__,'`-.__,                     `._,'   ,           )      ]],
			[[                      \_  _               \                         \   '`----=-----'       ]],
			[[                     ,'  / `,          `.,'                         ;       ,-'             ]],
			[[               ___,'`-._ \_/ `,._        ;                         /        \               ]],
			[[            __;_,'      `-.`-'./ `--.____)                       ,'          \              ]],
			[[         ,-'           _,--\^-'                                 ;             \             ]],
			[[       ,:_____      ,-'     \                                  '    ,        \ \            ]],
			[[      (,'     `--.  \;-._    ;                                /    /    .    .) \           ]],
			[[      :    Y      `-/    `,  :                               :    /           \  \          ]],
			[[      :    :       :     /_;'                                ;   |;            \  :         ]],
			[[      :    :       |    :                                    ;   |              | |         ]],
			[[       \    \      :    :                                    \   |          .   | :         ]],
			[[        `-._ `-.__, \    `.                                  )   \             ,' |         ]],
			[[           \   \  `. \     `.                                ,    ) ,----------|_;;         ]],
			[[         ,-;    \---)_\ ,','/                               (_/ //  | CENSORED |            ]],
			[[         \_ `---'--'" ,'^-;'                                  `' |  |__________|            ]],
			[[         (_`     ---'" ,-')                                      |     ; |    |             ]],
			[[         / `--.__,. ,-'    \                                     |     | |    |             ]],
			[[         )-.__,-- ||___,--' `-.                                  |     |,'    `-._          ]],
			[[        /._______,|__________,'\                                 |     `-._    `..)         ]],
			[[        `--.____,'|_________,-'                                  |       `.;""---`          ]],
			[[                                                                  `--._;_)-'                ]],
		}

		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
			dashboard.button("SPC ee", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
			dashboard.button("SPC ff", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
			dashboard.button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
			dashboard.button("SPC wr", "󰁯  > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
			dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
		}

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
