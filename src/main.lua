local charset = require "charset"

local set = charset.loadFromFile("../res/chars.cst")

for k, v in pairs(set) do
	print(k)
	for i = 1, #v do
		print(v[i])
	end
end