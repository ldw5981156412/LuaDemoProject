--- 启动调试

--导入自定义的模块
local basic = require("luaScript.module.common.basic");

ngx.say("hello world." );
ngx.say("<br>" );

--使用模块的成员属性
ngx.say("Lua path is: " .. basic.app_info.path);
ngx.say("<br>" );
--使用模块的成员方法
ngx.say("max 1 and 11 is: ".. basic.max(1,11) );