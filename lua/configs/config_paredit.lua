
local paredit = require("nvim-paredit")
paredit.setup({
	filetypes = { "clojure", "fennel", "scheme" },
	keys = {
		["[l"] = { paredit.api.slurp_forwards, "Slurp forwards" },
		["[h"] = { paredit.api.barf_forwards, "Barf forwards" },

		["[j"] = { paredit.api.slurp_backwards, "Slurp backwards" },
		["[k"] = { paredit.api.barf_backwards, "Barf backwards" },

		["[W"] = { function() paredit.api.wrap_element_under_cursor('(', ')') end, "Wrap form" },
		["[S"] = { paredit.api.unwrap_form_under_cursor, "Splice form" },
		["[O"] = { paredit.api.raise_form, "Raise form" },
	},
})
