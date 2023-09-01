--定义一个应用程序公有的Lua对象app_info
local app_info = { version = "0.1.0" }

--增加一个path属性，保存Nginx进程所保存的Lua模块路径，包括conf文件配置的部分路径
app_info.path = package.path

--局部函数,取得最大值
local function max(num1,num2)
    local result = nil;
    if num1 > num2 then
        result = num1;
    else
        result = num2;
    end
    return result;
end

--在屏幕上打印日志
local function log_screen(...)
    --这里的...和{}符号中间需要有空格号，否则会出错
    local args = { ... }
    for i, v in pairs(args) do
        print("index:", i, " value:", v)
        ngx.say(tostring(v) .. ",");
    end
    ngx.say("<br>");

end


--统一的模块对象
local _Module = {
    app_info = app_info;
    max = max;
    log_screen = log_screen;
}
return _Module