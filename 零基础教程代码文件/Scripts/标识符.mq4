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

