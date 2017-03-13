local charset = require "charset"
-- local http = require "socket.http"
local socket = require "socket"

local set = charset.loadFromFile("../res/chars.cst")

-- for k, v in pairs(set) do
-- 	print(k)
-- 	for i = 1, #v do
-- 		print(v[i])
-- 	end
-- end

currentTime = {
	-- hours, minutes
	HH = 0,
	MM = 0,

	-- visual properties
	chars = charset.loadFromFile("../res/chars.cst")
}

function currentTime.increment(self)
	self.MM = (self.MM + 1) % 60
	if self.MM == 0 then
		self.HH = (self.HH + 1) % 24
	end
end

function currentTime.show(self)
	local digits = {
		math.floor(self.HH / 10),
		self.HH % 10,
		math.floor(self.MM / 10),
		self.MM % 10
	}
	for i = 1, #digits do
		digits[i] = tostring(digits[i])
	end

	if self.chars == nil then
		for i = 1, #digits do
			print(digits[i])
		end
	else
		for i = 1, 5 do
			io.write(self.chars[digits[1]][i] .. " ")
			io.write(self.chars[digits[2]][i] .. " ")
			io.write(self.chars[":"][i] .. " ")
			io.write(self.chars[digits[3]][i] .. " ")
			io.write(self.chars[digits[4]][i])
			io.write("\n")
		end
	end
end

-- currentTime:increment()
-- currentTime:show()

for i = 1, 1000 do
	socket.sleep(.01)
	print("\n\n\n\n\n\n\n")
	currentTime:show()
	currentTime:increment()
end