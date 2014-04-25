function allwords(f)
   for line in io.lines() do
      for word in string.gmatch(line, "%w+") do
         f(word) -- call the function
      end
   end
end

-- To use this iterator, we must supply the loop body as a function. If we want only to print each word, we simply use print
--allwords(print)

--we use an anonymous function as the body
local count = 0
allwords(function(w)
            if w == "hello" then count = count + 1 end
         end)
print(count)