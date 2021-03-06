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


