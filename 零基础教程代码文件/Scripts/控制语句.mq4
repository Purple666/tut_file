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
