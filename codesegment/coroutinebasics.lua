--[[
-- code 1
co = coroutine.create(function() print("hello") end)
print(co)
print('the state of the co: ', coroutine.status(co))
coroutine.resume(co) -- The function coroutine.resume (re)starts the execution of a coroutine, changing its state from suspended to running
print('after running the co status: ', coroutine.status(co))

coy = coroutine.create(function ()
      for i = 1, 10 do
         print("co", i)
         coroutine.yield()
      end
end)

coroutine.resume(coy)
print('coy status: ', coroutine.status(coy))
coroutine.resume(coy)
print('coy status: ', coroutine.status(coy))
-- code 1 end
--]]

---[[
-- code 2
co = coroutine.create(function (a, b, c)
      print("co", a, b, c)
end)
coroutine.resume(co, 1, 2, 3)
print('co status:', coroutine.status(co))

co = coroutine.create(function (a, b)
      coroutine.yield(a + b, a - b)
end)
print(coroutine.resume(co, 20, 10))

co = coroutine.create(function()
      print("co", coroutine.yield())
end)
coroutine.resume(co)
coroutine.resume(co, 4, 5)
--]]
