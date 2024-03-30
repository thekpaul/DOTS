require'barbar'.setup { -- Copied from BarBar README and slightly modified
	-- WARN: do not copy everything below into your config! -> Oops.
	-- It is just an example of what configuration options there are.
	-- The defaults are suitable for most people.

	-- Enable/disable animations
	animation = true,

	-- Enable/disable auto-hiding the tab bar when there is a single buffer
	auto_hide = true,

	-- Enable/disable current/total tabpages indicator (top right corner)
	tabpages = true,

	-- Enables/disable clickable tabs
	--  - left-click: go to buffer
	--  - middle-click: delete buffer
	clickable = true,

	-- Excludes buffers from the tabline
	exclude_ft = {'javascript'},
	exclude_name = {'package.json'},

	-- A buffer to this direction will be focused (if it exists) when closing
	-- the current buffer.
	-- Valid options are 'left' (the default), 'previous', and 'right'
	focus_on_close = 'previous',

	-- Hide inactive buffers and file extensions.
	-- Other options are `alternate`, `current`, and `visible`.
	hide = {extensions = false, inactive = false},

	-- Disable highlighting alternate buffers
	highlight_alternate = false,

	-- Disable highlighting file icons in inactive buffers
	highlight_inactive_file_icons = false,

	-- Enable highlighting visible buffers
	highlight_visible = true,

	icons = {
		-- Configure the base icons on the bufferline.
		-- Valid options to display the buffer index and number are
		-- `true`, 'superscript' and 'subscript'
		buffer_index = true,
		buffer_number = false,
		button = '×',
		-- Enables / disables diagnostic symbols
		diagnostics = {
			[vim.diagnostic.severity.ERROR] = {enabled = true, icon = 'ﬀ'},
			[vim.diagnostic.severity.WARN]  = {enabled = false},
			[vim.diagnostic.severity.INFO]  = {enabled = false},
			[vim.diagnostic.severity.HINT]  = {enabled = true},
		},
		gitsigns = {
			added   = {enabled = true, icon = '+'},
			changed = {enabled = true, icon = '~'},
			deleted = {enabled = true, icon = '-'},
		},
		filetype = {
			-- Sets the icon's highlight group.
			-- If false, will use nvim-web-devicons colors
			custom_colors = false,

			-- Requires `nvim-web-devicons` if `true`
			enabled = true,
		},
		separator = {left = '|', right = ''},

		-- Configure the icons on the bufferline when modified or pinned.
		-- Supports all the base icon options.
		modified = {button = '●'},
		pinned = {button = '', filename = true},

		-- Use a preconfigured buffer appearance,
		-- can be 'default', 'powerline', or 'slanted'
		preset = 'default',

		-- Configure the icons on the bufferline based on visibility.
		-- Supports all the base icon options, plus `modified` and `pinned`.
		alternate = {filetype = {enabled = false}},
		current   = {buffer_index = true},
		inactive  = {button = '×'},
		visible   = {modified = {buffer_number = false}},
	},

	-- If true, new buffers will be inserted at the start/end of the list.
	-- Default is to insert after current buffer.
	insert_at_end = false,
	insert_at_start = false,

	-- Sets the maximum padding width with which to surround each tab
	maximum_padding = 1,

	-- Sets the minimum padding width with which to surround each tab
	minimum_padding = 1,

	-- Sets the maximum buffer name length.
	maximum_length = 30,

	-- Sets the minimum buffer name length.
	minimum_length = 0,

	-- If set, the letters for each buffer in buffer-pick mode will be
	-- assigned based on their name. Otherwise or in case all letters are
	-- already assigned, the behavior is to assign letters in order of
	-- usability (see order below)
	semantic_letters = true,

	-- Set the filetypes which barbar will offset itself for
	sidebar_filetypes = {
		-- Use the default values: {event = 'BufWinLeave', text = nil}
		NvimTree = true,
		-- Or, specify the text used for the offset:
		undotree = {text = 'undotree'},
		-- Or, specify the event which the sidebar executes when leaving:
		['neo-tree'] = {event = 'BufWipeout'},
		-- Or, specify both
		Outline = {event = 'BufWinLeave', text = 'symbols-outline'},
	},

	-- New buffer letters are assigned in this order. This order is
	-- optimal for the qwerty keyboard layout but might need adjustment
	-- for other layouts.
	letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

	-- Sets the name of unnamed buffers.
	-- By default format is "[Buffer X]" where X is the buffer number.
	-- But only a static string is accepted here.
	no_name_title = nil,
}

--[[ Custom highlight groups!
vim.api.nvim_set_hl(0, 'BufferTabpageFill', {bg = '#565656'})
vim.api.nvim_set_hl(0, 'BufferTabpages',    {bg = '#565656', fg = '#ffffff'})
vim.api.nvim_set_hl(0, 'BufferTabpagesSep', {bg = '#565656', fg = '#ffffff'})
--]]

vim.cmd [[ " Temporary custom highlight groups
	autocmd VimEnter,Colorscheme * :hi BufferTabpageFill guibg=#565656
	autocmd VimEnter,Colorscheme * :hi BufferTabpages    guibg=#565656 guifg=#ffffff
	autocmd VimEnter,Colorscheme * :hi BufferTabpagesSep guibg=#565656 guifg=#ffffff
]]

-- Mappings for the `romgrk/barbar.nvim` Plugin.
vim.cmd [[
	" Move to previous/next
	nnoremap <silent> ,, :BufferPrevious<CR>
	nnoremap <silent> ,. :BufferNext<CR>

	" Re-order to previous/next
	nnoremap <silent> ,< :BufferMovePrevious<CR>
	nnoremap <silent> ,> :BufferMoveNext<CR>

	" Goto buffer in position...
	nnoremap <silent> ,1 :BufferGoto 1<CR>
	nnoremap <silent> ,2 :BufferGoto 2<CR>
	nnoremap <silent> ,3 :BufferGoto 3<CR>
	nnoremap <silent> ,4 :BufferGoto 4<CR>
	nnoremap <silent> ,5 :BufferGoto 5<CR>
	nnoremap <silent> ,6 :BufferGoto 6<CR>
	nnoremap <silent> ,7 :BufferGoto 7<CR>
	nnoremap <silent> ,8 :BufferGoto 8<CR>
	nnoremap <silent> ,9 :BufferLast<CR>

	" Pin/unpin buffer
	nnoremap <silent> ,p :BufferPin<CR>

	" Close buffer
	nnoremap <silent> ,c :BufferClose<CR>

	" Wipeout buffer :BufferWipeout<CR>
	" Magic buffer-picking mode :BufferPick<CR>
	" Close commands
	" - :BufferCloseAllButCurrent<CR>
	" - :BufferCloseAllButPinned<CR>
	" - :BufferCloseAllButCurrentOrPinned<CR>
	" - :BufferCloseBuffersLeft<CR>
	" - :BufferCloseBuffersRight<CR>

	" Sort automatically by...
	nnoremap <silent> ,bb :BufferOrderByBufferNumber<CR>
	nnoremap <silent> ,bd :BufferOrderByDirectory<CR>
	nnoremap <silent> ,bl :BufferOrderByLanguage<CR>
	nnoremap <silent> ,bw :BufferOrderByWindowNumber<CR>
]]
