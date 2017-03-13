-- module to load a multi-line charset from file
local charset = {}

-- char identifiers start with this
local CHAR_IDENTIFIER = "~"

-- charset files look like this:
-- ~0
--  ---
-- |   |
--
-- |   |
--  ---
-- ~1
--
--     |
--
--     |
--
-- ~2
--  ---
--     |
--  ---
-- |
--  ---
--

 -- single-char substrings
local line = ""
getmetatable(line).__index = function(self, i) return string.sub(self, i, i) end

-- support appending to tables
local function fn_append(self, element) table.insert(self, element) end

-- load chars line by line into a charset table
-- keys are single chars, values are tables of strings
function charset.loadFromFile(charsetFilename)
	-- open charset file
	local charsetFile = io.open(charsetFilename)
	if charsetFile == nil then
		io.stderr:write("could not open charset file \"" + arg[0] + "\".")
		os.exit(1)
	end

	-- start by moving file ptr to first char identifier
	-- anything before the first is ignored
	line = charsetFile:read()
	while line ~= nil and line[1] ~= CHAR_IDENTIFIER do
		line = charsetFile:read()
	end

	-- populate from file
	local cset = {}
	while line ~= nil do
		-- set up a new character in the set
		if line[1] == CHAR_IDENTIFIER then
			charKey = line[2]
			cset[charKey] = {}
			cset[charKey].append = fn_append
		else -- add row to set
			cset[charKey]:append(line)
		end

		-- get the next line
		line = charsetFile:read()
	end
	return cset
end

return charset