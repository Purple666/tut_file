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
