---
title: "MQL4零基础课程"
date: "2017-03-16 10:10:16"
categories: MQL4课程
toc: true
---

<strong>本教程是属于视频课程的配套课程,结合视频课程，效果更佳，课程时间预计4小时</strong>

## 初识 EA智能交易 ##

所谓EA智能外汇全自动交易系统，就是将您自己或别人的外汇交易策略用特殊的编程语言（MQL）编写成一个电脑软件程序（Expert Advisor）, 让电脑按照您事先设定好的条件自动地为您买卖与交易，当然赢亏结果取决于您的自动交易系统设计得好坏。

EA交易的优点：

- 由于是电脑自动下单，可以保证更快的下单，平仓速度，可以更敏感地响应价格变动和趋势变动。

- 电脑可以克服人性中的弱点，该买则买，该卖则卖，无犹豫，无贪心，赢则不狂妄，亏也不沮丧，避免了情绪化操作。

- 电脑可以每天24小时不间断地监控行情，并在适当的时机和点位自动进出场，完全不用人工的干预，可以让您夜晚安枕入眠，白天安心从事别的工作。

### 制作第一个外汇脚本 ###
只需1分钟，跟着视频的步骤来执行第一个EA程序吧
``` 
// 将下面的代码复制到脚本中，这是一个下单指令
//这是个以当前价格当前货币对开0.1手多单且无止损止盈的下单脚本

 OrderSend(Symbol(),OP_BUY,0.1,Ask,3,0,0,"多单",123,0,clrNONE);
```
 
###  编辑器操作 ###

- 新建脚本
 脚本可以进行订单操作，在页面加载只执行一次，无需卸载。

``` c++
void OnStart()
  {
    脚本主体
  }

```

- 新建指标
  自定义指标的编写比较复杂，将在进阶课程中讲解。
- 新建EA

``` c++
// EA初始化函数，在EA执行前需要确定的事情需要写在这个函数里面，比如网络连接是否正常，账户是否是确定账户等。
int OnInit()
  {
   return(INIT_SUCCEEDED);
  }

// 这个函数是EA卸载时执行的代码，一般不用，但保留格式
void OnDeinit(const int reason)
  {

  }

// 程序的主体内容写在这个函数里面，这个函数在图表货币对每次报价的时候执行一次。如果报价不变就不会执行，即周末的时候，报价不变，代码也不会执行。
void OnTick()
  {

  }

```

- MQL4文件夹

MQL4文件夹是MT4平台涉及智能交易的文件夹，其中EA，指标和脚本分别处于不同的文件夹中，放错位置将无法执行。

	Experts   ：存放EA
	Files     ：MQL4可以进行文件操作，文件一般会在这个文件夹中
	Images    ： 用不到
	Include   ：函数库文件夹，用于存放函数库文件，在写EA和脚本时可以调用这个文件中的函数
	Indicators：指标文件夹，存放指标
	Libraries ：动态链接库文件夹，借用动态链接库文件可扩展MQL4的功能
	Logs      ：日志文件夹，运行EA的日志存放在这个地方
	Presets   ：EA的参数可以保存，放在这个文件夹中
	Project   ：用不到
	Scripts   ：脚本文件夹，存放脚本 
	
- MetaEditor编辑器操作
MetaEditor编辑器是专门用于编写MQL4语言的编辑器，需要掌握以下功能：

	- 新建文档     : 创建新文件
	- 编译文档     : 编写写好的代码
	- 查看编译信息 ： 查看错误信息，调试代码
	- 打开导航栏   : 方便查找文件
	- 查看帮助文件 ： 帮助操作


## 变量 ##
变量,是指没有固定的值,在程序中可以改变的数。与之相对应的是不变量，即一旦设定，在整个程序中的值都不会变，也不允许改变。

<strong>注：程序中所有变量都需要先定义，后使用。</strong>
### 变量的定义 ###
变量的定义，有三个部分组成：

数据类型 变量名=初始值 结束符

- 数据类型：表明变量属于哪一类
- 变量名：是字母a-z,A-Z，数字0-9，以及“_”的组合，不能以字母开头。
- 结束符：分号“;”。分号必须为英文分号，代码中所有字符（除注释）必须为英文字符。

### 常量的定义 ###
常量的定义，有三部分

\#define 常量名 常量值 

- 不变量使用\#define定义
- 不变量需在程序开始时定义。
- 不需要结束符
- 不变量的变量名，不能够再定义成变量

``` c++
#property copyright "shiyingpan"
#property link      "https://www.myfxlab.cn"
#property version   "1.00"
#property strict

//----常量的定义----//

#define N 10 //常量标识符(#define) 常量名(N) 常量值(10) 注：不需要分号结束


//----变量的定义----//

int var=1; //数据类型(int) 变量名(var)=初始值(1) 结束符(;)
double lot=1.2; //数据类型(double) 变量名(lot)=初始值(1.2) 结束符(;)



void OnStart()
  {
//----- 整数-----//
   int a=1,b=2,c;
   c=a+b;
   Print("a=",a,",b=",b,",a+b=",c);
   c=a-b;
   Print("a=",a,",b=",b,",a-b=",c);
   c=a*b;
   Print("a=",a,",b=",b,",a*b=",c);
   c=a/b; //----这是整除----//
   Print("a=",a,",b=",b,",a/b=",c);
   c=a%b; 
   Print("a=",a,",b=",b,",a%b=",c);
//----- 浮点数-----//
   double d=1,e=2,f;
   f=d+e;
   Print("d=",d,",e=",e,",d+e=",f);
   f=d-e;
   Print("d=",d,",e=",e,",d-e=",f);
   f=d*e;
   Print("d=",d,",e=",e,",d*e=",f);
   f=d/e;
   Print("d=",d,",e=",e,",d/e=",f);

//----- 布尔量-----//
   bool g=true,h=false,i;
   
   i= g && h;
   Print("g=",g,",h=",h,",g/h=",i);
   
   i= g || h;
   Print("g=",g,",h=",h,",g/h=",i);

//----- 字符串-----//
   string j="ni",k="hao",m;
   m=j+k;
   Print("j=",j,",k=",k,",j/k=",m);

//----- 时间量-----//
   datetime now;
   now=TimeCurrent();
   Print("now=",now,"now_int=",int(now));
   now=now-60;   //----时间量可以转化为整型作为时间的计算方式，1个单位代表1秒
   Print("now-60=",now);
   
//----- 颜色变量-----//
// 颜色变量一般不定义，直接使用。   

  }

```

## 数据类型 ##
### 整数 ###
整数是不带小数的数字，包含负整数，零和正整数。

- 整数的定义：int a=10;
- 整数转化为浮点数： b=double(a);
- 整数转化为字符串： string c=IntegerToString(a);
- 整除：整数除整数，结果仍然是整数，整数除浮点数，结果为浮点数。int a=1,b=2; Print(a/b);结果为0

### 浮点数 ###
浮点数是带有小数部分的数字。

- 浮点数的定义：double a=10;
- 浮点数转化为整数： b=int(a);只保留整数部分
- 浮点数转化为字符串： string c=DoubleToString(a，2);2表示保留2位小数

### 布尔量 ###
布尔量是表示真假的量，只有True（真）和False（假）两种情况。

布尔量的定义：bool a=True;
布尔量一般不做类型转换。

### 字符串 ###
字符串可以理解为一段文字，可以是英文或中文。

- 字符串的定义：string a="你好"；字符串需要用英文引号包含起来。
- 字符串转化为整型 :如果字符串中都是整数可转化为整数，b=StringToInteger(a)
- 字符串转化为浮点数：如果字符串是浮点数，则可以转化为浮点数，b=StringToDouble(a)
- 字符串转化为时间量 : 如果字符串是日期，则可以转化为时间量，b=StringToTime()
- 字符串的拼接：string a ="你"，b="好"; c=a+b; Print(c); "你好"

### 时间量 ###
时间量是MQL4表示时间的变量。

- 时间量的定义：datetime a=D'2017.12.25 12:12:00'; 时，分，秒可以不写，默认为00:00:00
- 时间戳：以1970.01.01 为0，到现在的秒数，所以时间量也可以是整型，参与数学运算。
- 时间量转化为字符串：b=TimeToString(a)

### 颜色变量 ###
在MQL4中表示颜色的量，一般是使用的可用以下几种

- 红色：clrRed
- 黄色：clrYellow
- 白色：clrWhite
- 绿色：clrGreen
- 无颜色：clrNone


## 运算符 ##
### 加 ###

- 数字相加
- 自加
- 时间相加
- 字符串相加

### 减 ###

- 数字减
- 自减
- 时间减

### 乘 ###
在程序中，乘法符号用"*"(shift+8)表示 int a=1,b=2; double c=a*b; Print(c);输出 2

### 除 ###
在程序中，除法符号用"/"表示，除数不能为零。 int a=1;double b=2; double c=a/b;Print(c);输出 0.5

### 取余数 ### 
取余数，又称为模运算，在程序中有重要的作用，取余数的符号是"%"(shift+5)，取余数的双方必须是整数。余数，类似于3除2，余1。

### 指数运算 ###
指数运算需要使用到系统自带的函数：MathPow(底数，次方数)。

### 逻辑运算 ###
逻辑运算符是配合控制语句使用。其运算结果是布尔量，只有“真”或“假”。

- ==：等于等于，若两边一致，则为 True（真），否则为False（假）
- ！=：不等于，若两边不一致，则为True(真)，否则为False（假）
- \>  :大于，左边大于右边为True（真），否则为False（假）
- \>= :大于等于，左边大于或等于右边为True（真），否则为False（假）
- <  :小于，左边小于于右边为True（真），否则为False（假）
- <= :小于等于，左边小于或等于右边为True（真），否则为False（假）
- && :逻辑与，左边和右边都为True(真)时，结果为True(真)，否则为False（假）
- || :逻辑或，左边和右边都为False（假）时，结果为False（假），否则为True（真）。
- ！：非操作，也称取反操作。


``` c++
#property copyright "shiyingpan"
#property link      "https://www.myfxlab.cn"
#property version   "1.00"
#property strict

void OnStart()
  {
//-------加-------// 
   int a=1;
   double b=2,c;
   c=a+b;
   Print("a=",a,",b=",b,",a+b=",c);
   
   string j="ni",k="hao",m;
   m=j+k;
   Print("j=",j,",k=",k,",j/k=",m);  
   
   Print("a=",a);
   a++;          //自加1
   Print("a",a);
 
//-------减-------//
   c=a-b;
   Print("a=",a,",b=",b,",a-b=",c);
   
   Print("a=",a);
   a--;          //自加1
   Print("a",a);
 
//-------乘-------// 
   c=a*b;
   Print("a=",a,",b=",b,",a*b=",c);

//-------除-------// 
   int aa=1,bb=2,cc;
   cc=aa/bb; //----这是整除----//
   Print("aa=",aa,",bb=",bb,",aa/bb=",cc);
   double d=1,e=2,f;
   f=d/e; //----结果带小数---//
   Print("d=",d,",e=",e,",d/e=",f);
//-------取余-------// 
   cc=aa%bb; //----这是整除取余----//
   Print("aa=",aa,",bb=",bb,",aa%bb=",cc);

//-------指数运算-------//
   c=MathPow(b,a); //----b的a次方----//
   Print("a=",a,",b=",b,",b^a=",c);

//-------逻辑运算-------// 
   bool r;
   r= a>b;
   Print("a=",a,",b=",b,",a>b=",r); 
   r=!(a>b);
   Print("a=",a,",b=",b,",a>b=",r); 
   r= a>=b;
   Print("a=",a,",b=",b,",a>=b=",r); 
   r= a<b;
   Print("a=",a,",b=",b,",a<b=",r); 
   r= a<=b;
   Print("a=",a,",b=",b,",a<=b=",r);       
   r= a==b;
   Print("a=",a,",b=",b,",a==b=",r); 
   r= a>b || a==b;
   Print("a=",a,",b=",b,",a>b || a==b=",r); 
   r= a>=b || a==b;
   Print("a=",a,",b=",b,",a>=b || a==b=",r); 

  }

```

## 标示 ##
程序中标示，包含自定义变量的名称，函数的名称等。标示的作用主要是便于读代码。
- 良好的标示有助于读懂代码，修改代码。
- 杂乱的标示会增加破译代码策略的难度。

### 保留字 ###
每种编程语言都会有些关键字，是保留下来的，不能够当变量名使用。保留字都有特定的颜色。不能够使用保留字的名称作为变量。

- 类型保留字
- 函数保留字
- 订单保留字
- 其他保留字

### 结束符 ###
在程序主体中，每句代码的结束，都要以英文分号";"结束。

### 注释 ###
程序中注释不会影响程序的运行。
- 注释一行：使用"//"
- 注释一段：使用"//* 注释内容 /*/"

``` c++
#property copyright "shiyingpan"
#property link      "https://www.myfxlab.cn"
#property version   "1.00"
#property strict

void OnStart()
  {
//保留字，系统留用。保留字有特殊的颜色
//类型
int,double,datetime,string
//函数
OrderSend(),OrderClose(),OnStart();
//订单
OP_BUY,OP_SELL
//其他保留字
Ask,Bid 
//中文字符  
注意中文字符的颜色，MQL4支持中文字符。  
  
//结束符
每句代码的结束都要以英文分号(;)结束

  
// 这是一行注释

/* 

这是一段注释

*/
  }

```

## 函数 ##
函数本质上是一段代码，只不过这段代码经常被使用或者这段代码实现特定的功能。函数并不是一定要用，用了有以下优势：

- 代码框架清晰
- 代码重用性提高，减少代码量
- 函数可以嵌套函数，可实现递归

### 下单函数 ###
MQL4中只有一个下单函数：Ordersend()，下单函数的属性，参照订单参数。

发送订单时，币种是必须要给予的。币种的类型是string（字符串类型的），可以有以下几种表现形式：
- 调用Symbol()：Symbol()函数是MQL4内部定义函数，返回当前加载EA图表中的币种。
- 直接指定：使用字符串指定，如欧元兑美元可直接使用"EURUSD"
- 间接指定：定义一个货币对字符串，然后使用这个字符串


``` c++
#property copyright "shiyingpan"
#property link      "https://www.myfxlab.cn"
#property version   "1.00"
#property strict

void OnStart()
  {
   string 币种=Symbol(),注释="测试";
   double 单量=0.1,开仓价=Ask;
   int 滑点=3,魔数=1243;
   double 止损=开仓价-100*Point,止盈=开仓价+100*Point;
   datetime 过期时间=0;
   
   int ticket=0;
   ticket=OrderSend(币种,OP_BUY,单量,开仓价,滑点,止损,止盈,注释,魔数,过期时间,clrNONE);
   
   if(ticket==0)
      Print("开单失败！错误原因：",GetLastError());
   else
      Print("开单成功！订单号：",ticket);   
      
   GetSymInfo();  
 
  }

//----获得币种的各种信息----//
void GetSymInfo()
{
   string 货币对名="EURUSD";
   double 买价,卖价,多仓隔夜利息,空仓隔夜利息,最低点位;
   double 点差,报价位数;
   double 最低单量;
   
   买价=MarketInfo(货币对名,MODE_ASK);
   卖价=MarketInfo(货币对名,MODE_BID);
   多仓隔夜利息=MarketInfo(货币对名,MODE_SWAPLONG);
   空仓隔夜利息=MarketInfo(货币对名,MODE_SWAPSHORT);
   点差=MarketInfo(货币对名,MODE_SPREAD);
   报价位数=MarketInfo(货币对名,MODE_DIGITS);
   最低点位=MarketInfo(货币对名,MODE_POINT);
   最低单量=MarketInfo(货币对名,MODE_MINLOT);
   
   Print("货币对      :", 货币对名     );
   Print("买价        :", 买价         );
   Print("卖价        :", 卖价         );
   Print("多仓隔夜利息:", 多仓隔夜利息 );
   Print("空仓隔夜利息:", 空仓隔夜利息 );
   Print("点差        :", 点差         );
   Print("报价位数    :", 报价位数     );
   Print("最低点位    :", 最低点位     );
   Print("最低单量    :", 最低单量     );  

}  

/*-----订单类型-------
多单 OP_BUY
空单 OP_SELL

买入限价 OP_BUYLIMIT 等价位跌倒某值买入
买入止损 OP_SELLLIMIT 等价格涨到某值卖出

卖出限价 OP_BUYSTOP  等价格涨到某值买入（一般为突破多挂单）
卖出止损 OP_SELLSTOP 等价格跌倒某值卖出（一般为跌破空挂单）

----------------------*/

```

### 修改订单函数 ###
MQL4中修改订单，使用OrderModify()函数。
对于已经下单的订单，能够修改的参数只有止损和止盈。
对于挂单，可以修改止损，止盈和开仓价

- 修改订单

``` c++
#property copyright "shiyingpan"
#property link      "https://www.myfxlab.cn"
#property version   "1.00"
#property strict

/*----------修改订单使用 OrderModify() 函数---
    本例将所有  多单的止损扩大100点
                空单的止盈扩大100点  
---------------------------------------------*/
bool res;

void OnStart()
  {
   for(int i=0;i<OrdersTotal();i++)
   {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==True)
      {
         if(OrderType()==OP_BUY || OrderType()==OP_BUYLIMIT || OrderType()==OP_BUYSTOP)
         {
            if(OrderStopLoss()==0)
            {
               res=OrderModify(OrderTicket(),OrderOpenPrice(),MarketInfo(OrderSymbol(),MODE_ASK)-100*MarketInfo(OrderSymbol(),MODE_POINT),OrderTakeProfit(),0,clrNONE);
               if(res==false)
                  Print("多单修改失败，订单号：",OrderTicket());
            }  
            else
            {
               res=OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss()+100*MarketInfo(OrderSymbol(),MODE_POINT),OrderTakeProfit(),0,clrNONE);
               if(res==false)
                  Print("空单修改失败，订单号：",OrderTicket());
            }
         }
         if(OrderType()==OP_SELL || OrderType()==OP_SELLLIMIT || OrderType()==OP_SELLSTOP)
         {
            if(OrderTakeProfit()==0)
            {
               res=OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),MarketInfo(OrderSymbol(),MODE_BID)-100*MarketInfo(OrderSymbol(),MODE_POINT),0,clrNONE);
               if(res==false)
                  Print("空单修改失败，订单号：",OrderTicket());                 
            }
            else
            {
               res=OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),OrderTakeProfit()-100*MarketInfo(OrderSymbol(),MODE_POINT),0,clrNONE);
               if(res==false)
                  Print("空单修改失败，订单号：",OrderTicket());              
            }        
         }
      }   
   }
  }

```

### 平仓函数 ###
MQL4对已开仓位使用平仓函数，可将仓位按当前价平仓。


### 删除订单函数 ###
MQL4对未执行的挂单使用删除订单函数，将此挂单删除。


``` c++
#property copyright "shiyingpan"
#property link      "https://www.myfxlab.cn"
#property version   "1.00"
#property strict
/*---------------------------------------------
平仓函数的使用需要慎重对待，必须使用订单号平仓，
一般的使用方式为先选中订单，然后再平仓。
本例：在图表周期中，若K线收盘价低于10日均线时，
      平掉本货币对多仓
----------------------------------------------*/
input int 周期=10;
int 魔数=1243;

int OnInit()
  {
   return(INIT_SUCCEEDED);
  }
void OnDeinit(const int reason)
  {
  
  }
void OnTick()
  {
   double ma_value=iMA(Symbol(),0,周期,0,MODE_EMA,PRICE_CLOSE,0);//--调用均线指标
   double close_price=iClose(Symbol(),0,0); //------调用收盘价
   
   if(close_price<ma_value)
   {
      for(int i=0;i<OrdersTotal();i++)
      {
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==True)
         { 
//----------------选择需要平仓的订单---------------、、           
            if(OrderSymbol()==Symbol() && OrderMagicNumber()==魔数)
            {
//----------------开仓单使用OrderClose() ----------//
               if(OrderType()==OP_BUY)
               {
                  if(!OrderClose(OrderTicket(),OrderLots(),MarketInfo(Symbol(),MODE_BID),3,clrNONE))
                     Alert("平仓失败，错误号：",GetLastError());
               }
//-----------------挂单使用 OrderDelete() ----------//               
               if(OrderType()==OP_BUYLIMIT || OrderType()==OP_BUYSTOP)
               {
                  if(!OrderDelete(OrderTicket(),clrNONE))
                     Alert("删除挂单失败，错误号：",GetLastError());
               }               
               
               
            }
          }  
       }     
   }
  }

```


### 自定义函数 ###
自定义函数用于实现特定的功能。函数有以下属性

- 函数的形式：函数需写在主体程序之外，如下：

- 返回值：函数可以带有返回值，定义类型与返回类型需一致。

- 无返回值：对于不需要返回值的函数，定义类型用void。

``` c++
/*----函数的基本结构-----//
返回值类型 函数名(参数类型 参数定义,参数类型 参数定义)
{
   函数主体
}
*/
#property copyright "shiyingpan"
#property link      "https://www.myfxlab.cn"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| OnStart()也是一个函数，并且没有返回值                                   |
//+------------------------------------------------------------------+
void OnStart()
  {
   Acc_check(); //---没有参数
   int a=1,b=2,c=3,res;
   res = add(a,b,c,4);//---有4个参数，与函数定义需一一对应
   Print("res:",res);
  }
  
void Acc_check()
{
   if(!IsDemo())
   {
      Alert("非模拟账户，请谨慎操作！");
   }   
   return;
}

int add(int aa,int bb,int cc,int dd)
{
   int r=0;
   r=aa+bb+cc+dd;
   return r;
}
```

## 控制语句 ##
控制语句是实现策略的主要方法，在程序中非常重要，控制语句的执行代码需要用大括号括起来。

### if条件判断 ###
if是条件判断语句，若条件为True（真）时，执行if内容，否则不执行。

### if-else条件判断 ###
若if判断条件为真，执行if的内容，否则执行else里面的内容。

``` c++
#property copyright "shiyingpan"
#property link      "https://www.myfxlab.cn"
#property version   "1.00"
#property strict

void OnStart()
  {
//-----23点到1点之间不交易------//
   if(TimeHour(TimeCurrent())==23 || TimeHour(TimeCurrent())==0) //--函数带有括号()
   {
      Alert("非交易时段");
      return;
   }
   
//--- else 并不是一定要有，根据需要-------//
//--- 本根K线RSI指标高于50下空单，低于50下多单----//
   double rsi_value=iRSI(Symbol(),0,14,PRICE_CLOSE,0);
   int ticket=0;
   if(rsi_value>50)
   {
      ticket=OrderSend(Symbol(),OP_SELL,0.1,Bid,3,0,0,"测试",1242,0,clrNONE);
      
      if(ticket==0)
         Print("开单失败！错误原因：",GetLastError());
      else
         Print("开单成功！订单号：",ticket);      
   }
   else
   {
      ticket=OrderSend(Symbol(),OP_BUY,0.1,Ask,3,0,0,"测试",1242,0,clrNONE);
      
      if(ticket==0)
         Print("开单失败！错误原因：",GetLastError());
      else
         Print("开单成功！订单号：",ticket); 
   }
   
//--- 本根K线RSI指标高于70下空单，低于30下多单,其他情况不下单----// 

   if(rsi_value>70)
   {
      ticket=OrderSend(Symbol(),OP_SELL,0.1,Bid,3,0,0,"测试",1242,0,clrNONE);
      
      if(ticket==0)
         Print("开单失败！错误原因：",GetLastError());
      else
         Print("开单成功！订单号：",ticket);      
   }
   else if(rsi_value<30)   // else if 追加判断
   {
      ticket=OrderSend(Symbol(),OP_BUY,0.1,Ask,3,0,0,"测试",1242,0,clrNONE);
      
      if(ticket==0)
         Print("开单失败！错误原因：",GetLastError());
      else
         Print("开单成功！订单号：",ticket); 
   }
   
  }

```

### for循环 ###
for循环，在任何编程语言中都占据重要的地位。很复杂的类似操作，使用for循环将会变得简单。
for循环需要定义循环次数，通常情况下使用如下：
``` c++
#property copyright "shiyingpan"
#property link      "https://www.myfxlab.cn"
#property version   "1.00"
#property strict

void OnStart()
  {
//-----做1到100的累加----//

   int sum=0;
   for(int i=1;i<=100;i++)
   {
      sum=sum+i;
   }
   Print("1到100的累加结果为：",sum);
   
   int i=1;
   sum=0;
   while(i<=100)
   {
      sum=sum+i;
   }

   Print("1到100的累加结果为：",sum);
  }

```

### while循环 ###
while循环是一直循环，只要条件满足就执行，在没有停止条件的情况下会一直执行。没有停止条件的情况下，会无限循环，导致程序陷入死循环，有时会崩溃。在可选的条件下，尽量不用。

``` c++
#property copyright "shiyingpan"
#property link      "https://www.myfxlab.cn"
#property version   "1.00"
#property strict

void OnStart()
  {
//-----做1到100的累加----//

   int sum=0;
   int i=1;
   while(i<=100)
   {
      sum=sum+i;
   }

   Print("1到100的累加结果为：",sum);
  }

```

### switch-case条件选择 ###
根据switch的内容，选定相应的case。使用switch-case时，需要事情拟定所有可能的情况。

``` c++
#property copyright "shiyingpan"
#property link      "https://www.myfxlab.cn"
#property version   "1.00"
#property strict

void OnStart()
  {
//-----选择下单方式----//

   int type=OP_BUY;
   
   switch(type)
   {
      case OP_BUY:
         Print("下多单");
         break;
      case OP_BUYLIMIT:
         Print("下限价买入挂单");
         break;
      case OP_SELL:      
         Print("下空单");
         break;
      default:
         Print("其他情况，不操作");
         break;   
   }
  }

```

### continue 循环中断 ###
在循环语句的代码中，执行到continue时，将直接进入下一次循环。

### break 循环结束 ###
在循环语句的代码中，执行到break时，循环将被终止。


## 订单参数 ##
每一个订单都有自己的参数，在使用OrderSelect()选中订单的前提下，可使用内置函数调用订单参数。在未选中的情况下，无法返回参数。选择订单的两种方法：

- 按订单号选择
- 按订单序列选择

### 订单号 ###
使用OrderTicket()返回订单得订单号，数据类型为整型

### 币种 ###
使用OrderSymbol()函数返回订单币种，类型为string（字符串）

### 单量 ###
使用OrderLots()函数返回订单单量，类型为一个浮点数

### 交易类型 ###
使用OrderType()函数返回订单方向，可能是OP_BUY,OP_SELL,OP_BUY_LIMIT,OP_BUY_STOP,OP_SELL_LIMIT,OP_SELL_STOP中的其中一个

### 开仓价 ###
使用OrderOpenPrice()返回订单得订单开仓价，数据类型为整型

### 开仓时间 ###
使用OrderOpenTime()返回订单得订单开仓时间，数据类型为整型

### 止损 ###
使用OrderStopLoss()返回订单得订单止损，数据类型为整型

### 止盈 ###
使用OrderTakeProfit()返回订单得订单止盈，数据类型为整型

### 注释 ###
使用OrderComment()返回订单得订单注释，数据类型为整型

### 魔数 ###
使用OrderMagicNumber()返回订单得订单魔数，数据类型为整型

### 平仓价 ###
使用OrderClosePrice()返回订单得订单平仓价，数据类型为整型

### 平仓时间 ###
使用OrderCloseTime()返回订单得订单平仓时间，数据类型为整型

### 浮盈 ###
使用OrderProfit()返回订单得订单浮盈，数据类型为整型

### 隔夜利息 ###
使用OrderSwap()返回订单得订单隔夜利息，数据类型为整型

### 手续费 ###
使用OrderCommission()返回订单得订单手续费，数据类型为整型

``` c++
#property copyright "shiyingpan"
#property link      "https://www.myfxlab.cn"
#property version   "1.00"
#property strict
/*--------------------------------
选择订单参数是智能交易中的重要步骤。
----------------------------------*/
void OnStart()
  {
//-------------通用格式-----------
   for(int i=0;i<=OrdersTotal()-1;i++) //---------选择持仓订单
   {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)) 
      {
         Print("订单号：",OrderTicket()); 
         Print("币种：",OrderSymbol());
         Print("方向：",OrderType()); 
         Print("单量：",OrderLots()); 
         Print("开仓价：",OrderOpenPrice()); 
         Print("开仓时间：",OrderOpenTime()); 
         Print("止损：",OrderStopLoss()); 
         Print("止盈：",OrderTakeProfit()); 
         Print("收盘价：",OrderClosePrice()); 
         Print("收盘时间：",OrderCloseTime()); 
         Print("魔数：",OrderMagicNumber()); 
         Print("注释：",OrderComment());
         Print("浮盈：",OrderProfit());
         Print("隔夜利息：",OrderSwap());
         Print("手续费：",OrderCommission());    
      }
   }
   
   for(int i=0;i<=OrdersHistoryTotal()-1;i++) //---------选择历史订单
   {
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY))
      {
         Print("订单号：",OrderTicket()); 
         Print("币种：",OrderSymbol());
         Print("方向：",OrderType()); 
         Print("单量：",OrderLots()); 
         Print("开仓价：",OrderOpenPrice()); 
         Print("开仓时间：",OrderOpenTime()); 
         Print("止损：",OrderStopLoss()); 
         Print("止盈：",OrderTakeProfit()); 
         Print("收盘价：",OrderClosePrice()); 
         Print("收盘时间：",OrderCloseTime()); 
         Print("魔数：",OrderMagicNumber()); 
         Print("注释：",OrderComment());
         Print("浮盈：",OrderProfit());
         Print("隔夜利息：",OrderSwap());
         Print("手续费：",OrderCommission());    
      }
   }
   
//------------直接按订单号选择-------
   int ticket=123;
   
   if(OrderSelect(ticket,SELECT_BY_TICKET)) //----直接按订单号选择需输入正确订单号，很少用
   {
         Print("订单号：",OrderTicket()); 
         Print("币种：",OrderSymbol());
         Print("方向：",OrderType()); 
         Print("单量：",OrderLots()); 
         Print("开仓价：",OrderOpenPrice()); 
         Print("开仓时间：",OrderOpenTime()); 
         Print("止损：",OrderStopLoss()); 
         Print("止盈：",OrderTakeProfit()); 
         Print("收盘价：",OrderClosePrice()); 
         Print("收盘时间：",OrderCloseTime()); 
         Print("魔数：",OrderMagicNumber()); 
         Print("注释：",OrderComment());
         Print("浮盈：",OrderProfit());
         Print("隔夜利息：",OrderSwap());
         Print("手续费：",OrderCommission()); 
   }   
  }


```

## 编程风格 ##

### 养成良好的编程风格 ###

- 良好的书写格式，有助于理清思路，检验策略，查找错误，美观，这是基本功。
- 多使用函数，对于一个功能块，使用一个函数代替。
- 多次使用的字符串或数字，用一个标示符代替。
- 使用MetaEditor的自带编程风格工具

