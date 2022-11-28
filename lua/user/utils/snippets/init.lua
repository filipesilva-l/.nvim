local function split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local result = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(result, str)
	end
	return result
end

local function scandir(directory)
	local index, result, popen = 0, {}, io.popen
	local pfile = popen('ls -a "' .. directory .. '"')
	for filename in pfile:lines() do
		index = index + 1
		result[index] = filename
	end
	pfile:close()
	return result
end

local function trim(value)
	return (value:gsub("^%s*(.-)%s*$", "%1"))
end

local function get_current_buffer_filename()
	local buf_name = vim.api.nvim_buf_get_name(0)

	local splitted = split(buf_name, "/")

	return splitted[#splitted]:gsub(".cs", "")
end

local function get_node_identifier(node)
	for child in node:iter_children() do
		if child:type() == "identifier" then
			return require("vim.treesitter.query").get_node_text(child, 0)
		end
	end

	return get_current_buffer_filename()
end

local ri = function(insert_node_id)
	return require("luasnip").function_node(function(args)
		return args[1][1]
	end, insert_node_id)
end

return {
	split = split,
	scandir = scandir,
	trim = trim,
	get_current_buffer_filename = get_current_buffer_filename,
	get_node_identifier = get_node_identifier,
	ri = ri,
}
