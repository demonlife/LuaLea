--[[ 
-- example 1
print "enter a number:"
n = io.read("*number")
if not n then error("invalid input") end
--]]

--[[
-- example 2
print "enter a number:"
n = assert(io.read("*number"), "invalid input")
-- The assert function checks whether its rst argument is not false and simply returns this argument;
--]]

--[[
-- example 3
n = io.read()
assert(tonumber(n), "invalid input: " .. n .. " is not a number")
--]]

---[[
-- example 4
local file, msg
repeat
   print "enter a file name:"
   local name = io.read()
   if not name then return end -- no input
   file, msg = io.open(name, "r")
   if not file then print(msg) end
until file
--]]
