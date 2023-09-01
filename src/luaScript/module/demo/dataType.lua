--导入自定义的模块
local basic = require("luaScript.module.common.basic");

local function _showDataType()
    local i;
    basic.log_screen("字符串的类型", type("hello world"));
    basic.log_screen("方法的类型", type(showDataType));
    basic.log_screen("true的类型", type(true));
    basic.log_screen("整数数字的类型", type(360));
    basic.log_screen("浮点数字的类型", type(360.0));
    basic.log_screen("nil值的类型", type(nil));
    basic.log_screen("未赋值变量i的类型", type(i));
end

--演示取整操作
local function _intPart(number)
    basic.log_screen("演示的整数", number);
    basic.log_screen("向下取整是", math.floor(number));
    basic.log_screen("向上取整是", math.ceil(number));
end

--统一的模块对象
local _Module = {
    showDataType = _showDataType;
    intPart = _intPart;
}
return _Module