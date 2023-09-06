--导入自定义的基础模块
local basic = require("luaScript.module.common.basic");
--导入自定义的RedisOperator模块
local redisOp = require("luaScript.redis.RedisOperator");

local PREFIX = "GOOD_CACHE:"

-- RedisCacheDemo类
local _RedisCacheDemo = {}

_RedisCacheDemo.__index = _RedisCacheDemo

function _RedisCacheDemo.new(self)
    local object = {}
    setmetatable(object, self)
    return object;
end

--根据商品id获取缓存数据
function _RedisCacheDemo.getCache(self, goodId)
    --创建自定义的Redis操作对象
    local red = redisOp:new();
    if not red:open() then
        basic:error("Redis连接失败");
        return nil;
    end
    --获取缓存数据
    local json = red:getValue(PREFIX .. goodId);
    red:close();
    if not json or json == ngx.null then
        basic.log(goodId .. "的缓存没有命中");
        return nil;
    end
    basic:log(goodId .. "缓存成功命中");
    return json;
end

--通过capture方法回源上游接口
function _RedisCacheDemo.goUpstream(self)
    local request_method = ngx.var.request_method;
    local args = nil;
    if "GET" == request_method then
        args = ngx.req.get_uri_args();
    elseif "POST" == request_method then
        args = ngx.req.get_post_args();
    end
    --回源上游接口,比如Java后端rest接口
    local res = ngx.location.capture("/java/good/detail", {
        method = ngx.HTTP_GET,
        args = args -- 重要：将请求参数原样向上游传递
    })
    basic:log("上游数据获取成功");
    --返回上游接口的响应体
    return res.body;
end
--设置缓存，此方法主要用于模拟Java后台代码
function _RedisCacheDemo.setCache(self,goodId,goodString)
    --创建自定义的Redis操作对象
    local red = redisOp:new();
    if not red:open() then
        basic:error("Redis连接失败");
        return nil;
    end
    --set缓存数据
    red:setValue(PREFIX .. goodId,goodString);
    --60s内过期
    red:expire(PREFIX .. goodId,60);
    basic:log(goodId .. "缓存设置成功");
    --归还连接到连接池
    red:close();
end
return _RedisCacheDemo;
