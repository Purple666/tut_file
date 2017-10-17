#property copyright "shiyingpan"
#property link      "https://www.github.com/shiyingpan/mql_tutorial"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
int Magic_Num=123; // 魔术数，用于识别EA
double lot=0.1;    // 订单手数
int sl=100,tp=100; //止损与止盈（以点数计算）
int slip=3;   // 滑点
string comment="my first EA";

void OnStart()
  {
   int ticket;
   ticket=OrderSend(Symbol(),OP_BUY, lot, Ask,  slip, Ask-sl*Point,Ask+tp*Point,comment,Magic_Num,0,      clrNONE);   
        //OrderSend(币种,   下单方向,单量,买价，滑点，止损,       止盈，        标注，  魔术数，  过期时间,颜色);
   if(ticket>0)
     {
      Print("下单成功！订单号：",ticket);      
     }
   else
     {
      Alert("下单不成功！错误：",GetLastError()); 
     }   
  }

