--导入自定义的dataType模块
local dataType = require("luaScript.module.demo.dataType")
ngx.say("下面是数据类型演示的结果输出：<br>")
dataType.showDataType();

ngx.say("<hr>下面是数字取整的输出：<br>" );
dataType.intPart(0.01);
dataType.intPart(3.14);

ngx.say("<hr>");
dataType.stringOperator();

ngx.say("<hr>");
dataType.tableOperator();

ngx.say("<hr>");
dataType.forOperator();

ngx.say("<br><hr>下面是面向对象操作的演示：<br>");
local Square = dataType.Square;
local square = Square:new(20);
ngx.say("正方形的面积为",square:getArea());