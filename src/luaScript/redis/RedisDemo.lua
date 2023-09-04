local redis = require("resty.redis");
local config = require("luaScript.module.config.redis-config");

-- 设置超时时长
local red = redis:new();
-- 设置超时时长,单位为ms
red:set_timeouts(config.timeout,config.timeout,config.timeout);

-- 连接服务器
local ok,err = red:connect(config.host_name,config.port);
if not ok then
    ngx.say("failed to connect: ",err);
    return
else
    ngx.say("succeed to connect redis","<br>");
end



