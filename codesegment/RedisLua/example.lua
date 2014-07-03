-- redis-cli eval "$(cat example.lua)" 0
-- code 1
--[[
local msg = "hello, world!"
return msg
--]]

-- 调用redis中的函数
-- code 2
--[[
local link_id = redis.call("INCR", KEYS[1])
return link_id
--]]

-- 结合使用条件判断
-- code3
--[[
if redis.call("HEXISTS", KEYS[1], ARGV[1]) == 1 then
   return redis.call("HINCR", KEYS[1], ARGV[1])
else
   return nil
end
--]]

-- 调用库
-- code4
--[[
if redis.call("EXISTS", KEYS[1]) == 1 then
   local payload = redis.call("GET", KEYS[1])
   return cjson.decode(payload)[ARGV[1] ] -- 正常情况下两个]中间无空格，此处的空格是为了不让与注释向冲突
   return cmsgpack.decode(payload)[ARGV[1] ] -- error?
else
   return nil
end
--]]

-- 数值转换， 在redis中会输出3
-- code5
--[[
local inpi = 3.2
return inpi
--]]

-- redis中输出3.2, 但此3.2是用字符串表示的,非数值类型
local inpi = 3.2
redis.call("set", "pi", inpi)
return redis.call("get", "pi")