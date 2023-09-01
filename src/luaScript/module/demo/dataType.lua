-- 导入自定义的模块
local basic = require("luaScript.module.common.basic");
local table = table or require "table"

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

-- 演示取整操作
local function _intPart(number)
    basic.log_screen("演示的整数", number);
    basic.log_screen("向下取整是", math.floor(number));
    basic.log_screen("向上取整是", math.ceil(number));
end

local function _stringOperator()
    local here = "这里是" .. "中国" .. "北京";
    print(here);
    basic.log_screen("字符串拼接演示", here);

    basic.log_screen("获取字符串的长度", string.len(here));
    basic.log_screen("获取字符串的长度", #here);

    basic.log_screen("字符串查找", string.find(here, "北京"));
    basic.log_screen("字符串转成大写", string.upper("Hello World"));
    basic.log_screen("字符串转成小写", string.lower("Hello World"));
end

local function _tableOperator()
    local array1 = { "这里是：", "北京", "朝阳" }
    local array2 = { k1 = "这里是：", k2 = "河南", k3 = "郑州" }
    basic.log_screen("table.getn(t)获取长度", table.getn(array1));
    basic.log_screen("一元操作符#", #array1);

    basic.log_screen("连接元素", table.concat(array1));
    basic.log_screen("带分隔符连接元素", table.concat(array1, "*"));

    table.insert(array1, "望京");
    basic.printTable(array1);
    table.insert(array1, 2, "望京");
    basic.printTable(array1);

    --删除最后一个元素
    table.remove(array1);
    basic.printTable(array1);
    --删除第二个元素
    table.remove(array1, 2);
    basic.printTable(array1);
end


--演示for操作
local function _forOperator()
    -- foreach循环，打印table t中所有的键和值
    local days2 = {
        Sunday = 1,
        Monday = 2,
        Tuesday = 3,
        Wednesday = 4,
        Thursday = 5,
        Friday = 6,
        Saturday = 7
    }
    for key, value in pairs(days2) do
        ngx.say(key .. ":" .. value);
    end
end

-- 正方形类
local _Square = { side = 0}
_Square.__index = _Square
-- 类的方法getArea
function _Square.getArea(self)
    return self.side * self.side;
end
-- 类的方法new
function _Square.new(self,side)
    local cls = {}
    setmetatable(cls,self)
    cls.side = side or 0
    return cls
end

-- 统一的模块对象
local _Module = {
    showDataType = _showDataType;
    intPart = _intPart;
    stringOperator = _stringOperator;
    tableOperator = _tableOperator;
    forOperator = _forOperator;
    Square = _Square;
}
return _Module
