require "socket"

--[[
-- code 1   
host = "www.w3.org"
file = "/TR/REC-html32.html"

c = assert(socket.connect(host, 80))
c:send("GET" .. file .. " HTTP/1.0\r\n\r\n")

while true do
   local s, status, partial = c:receive(2^10)
   io.write(s or partial)
   if status == "closed" then break end
end

c:close()
--]]

function receive (connection)
   return connection:receive(2 ^ 10)
end

-- concurrent implementation
function receive (connection)
   connection:settimeout(0) -- do not block
   local s, status, partial = connection:receive(2 ^ 10)
   if status == "timeout" then
      coroutine.yield(connection)
   end
   return s or partial, status
end

function download (host, file)
   local c = assert(socket.connect(host, 80))
   local count = 0 -- counts number of bytes read
   c:send("GET" .. file .. " HTTP/1.0\r\n\r\n")
   while true do
      local s, status, partial = receive(c)
      count = count + #(s or partial)
      if status == "closed" then break end
   end
   c:close()
   print(file, count)
end

threads = {} --list of all live threads

function get (host, file)
   -- create coroutine
   local co = coroutine.create(function ()
         download(host, file)
   end)
   -- insert it in the list
   table.insert(threads, co)
end

--[[
function dispatch ()
   local i = 1
   while true do
      if threads[i] == nil then -- no more threads?
         if threads[1] == nil then break end -- list is empty
         i = 1 -- restart the loop
      end
      local status, res = coroutine.resume(threads[i])
      if not res then -- thread finished its task
         table.remove(threads, i)
      else
         i = i + 1
      end
   end
end
--]]

-- dispatcher using select
function dispatch ()
   local i = 1
   local connections = {}
   while true do
      if threads[i] == nil then -- no more threads?
         if threads[1] == nil then break end
         i = 1 -- restart the loop
         connections = {}
      end
      local status, res = coroutine.resume(threads[i])
      if not res then -- thread finished its task ?
         table.remove(threads, i)
      else -- time out
         i = i + 1
         connections[#connections + 1] = res
         if #connections == #threads then -- all threads blocked?
            socket.select(connections)
         end
      end
   end
end

host = "www.w3.org"
get(host, "/TR/html401/html40.txt")
dispatch() -- main loop
