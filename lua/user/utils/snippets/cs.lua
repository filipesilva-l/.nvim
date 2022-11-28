local snippet_utils = require("user.utils.snippets")

local function compose_namespace(dir)
	local namespace = ""
	local has_csproj = false

	while not has_csproj do
		local splitted = snippet_utils.split(dir, "/")
		local last_element = splitted[#splitted]
		local last_element_is_dir = not string.find(last_element, ".cs")

		if #splitted == 0 then
			return ""
		end

		if last_element_is_dir then
			dir = dir:gsub(last_element .. "/", "")
		else
			dir = dir:gsub(last_element, "")
		end

		local files = snippet_utils.scandir(dir)

		local csprojs = vim.tbl_filter(function(file)
			return string.find(file, ".csproj") ~= nil
		end, files)

		has_csproj = #csprojs ~= 0

		if not has_csproj and last_element_is_dir then
			namespace = last_element .. "." .. namespace
		elseif has_csproj then
			local to_concat = ""

			if last_element_is_dir then
				to_concat = last_element
			end

			namespace = string.sub(csprojs[1], 0, #csprojs[1] - #".csproj") .. "." .. to_concat .. "." .. namespace
		end
	end

	namespace = snippet_utils.trim(namespace:gsub("%.", " ")):gsub("%-", "_"):gsub("%s+", ".")

	return namespace
end

local function get_cs_constructable_node()
	local constructable_nodes =
		{ "abstract_class_declaration", "class_declaration", "record_declaration", "struct_declaration" }
	local node = require("nvim-treesitter.ts_utils").get_node_at_cursor()

	while node ~= nil and not vim.tbl_contains(constructable_nodes, node:type()) do
		node = node:parent()
	end

	return node
end

return {
	compose_namespace = compose_namespace,
	get_cs_constructable_node = get_cs_constructable_node,
}
