function mydofile(filename)
   local f = assert(loadfile(filename))
   return f
end

i = 32
local i = 0
f = loadstring("i = i + 1; print(i)")
g = function () i = i + 1; print(i) end

f() --> 33
g() --> 1

--[[ 
The g function manipulates the local i, as expected, but f manipulates a global i,
because loadstring always compiles its strings in the global environment
--]]

print "enter your expression:"
local l = io.read()
local func = assert(loadstring("return " .. l))
print("the value of your expression is " .. func())

--[[
Because the function returned by loadstring is a regular function, you can
call it several times:
--]]
for i=1, 20 do
   x = i -- global 'x'
   print(string.rep('*', func()))
end

         