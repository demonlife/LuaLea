-- http://blog.jobbole.com/70480/ 中文版
-- http://tylerneylon.com/a/learn-lua/ 英语版
-- 单行注释
--[[
   多行注释
--]]

num = 23 -- 数值都是双精度的
str = 'hello'
str = "hello"
str = [[   
          多行文本
          内容
       ]]
print(str)

-- 注意else if与elseif的区别
if num > 40 then
   print("> 40")
elseif s ~= 'aspython' then
      io.write('s is not aspython\n')
else
   thisIsGlobal = 5
   local line = io.read()
   print('hello' .. line .. '\n')
end

if num > 40 then
   print("> 40")
else if s == 'aspython' then
      io.write('s is aspython')
     else
        io.write("else if's else\n")
     end
end

-- 三元表达式
ans = aBoolValue and 'yes' or 'no'

-- 闭包函数
function adder(x)
   return function(y)
      return x + y
          end
end
a1 = adder(9)
a2 = adder(10)
print(a1(11))
print(a2(10))
