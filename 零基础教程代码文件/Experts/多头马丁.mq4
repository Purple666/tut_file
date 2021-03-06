#property copyright "www.fxlab.cn"
#property link      "https://www.fxlab.cn"
#property version   "1.00"

input bool    UseAdd=true;    // 是否使用加仓策略，true：是
input double  LotExponent=1; // 加仓系数
input int  slip=3;   // 滑点
input double  Lots=0.05; // 初始单量
input int  LotsDigits=2;  //单量精确到小数点后2位
input double  TakeProfit=200; // 止盈
input double  PipStep=300; //  加仓间隔，当一根K线的开盘价与上次开仓价之间价格大于这个数值，才加倍开仓
input int     MaxTrades=10;  //最大订单数
input bool    UseEquityStop=true;  //未使用
input double  TotalEquityRisk=20; //loss as a percentage of equity

int MagicNumber=123456;
double PriceTarget,StartEquity,BuyTarget,SellTarget;
double AveragePrice,SellLimit,BuyLimit;
double LastBuyPrice,LastSellPrice,ClosePrice,Spread;
string EAName="BUY";
datetime timeprev=0;
int NumOfTrades=0;
double iLots;
int cnt=0,total;
bool TradeNow=false,LongTrade=false,ShortTrade=false;

bool NewOrdersPlaced=false;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int init()
  {
   Spread=MarketInfo(Symbol(),MODE_SPREAD)*Point;
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int deinit()
  {
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
//---------开仓条件
   bool long_trade=false;
   if(iClose(Symbol(),PERIOD_M1,2)<iClose(Symbol(),PERIOD_M1,1))
      long_trade=true;
//------------------------
//---获取平均的开仓价格---
//------------------------
   int ticket;
   total=CountTrades();
   AveragePrice=0;
   double Count=0;
   for(cnt=OrdersTotal()-1;cnt>=0;cnt--)
     {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
            if(OrderType()==OP_BUY || OrderType()==OP_SELL)
              {
               AveragePrice=AveragePrice+OrderOpenPrice()*OrderLots();
               Count=Count+OrderLots();
              }
     }
   if(total>0)
      AveragePrice=NormalizeDouble(AveragePrice/Count,Digits);

   for(int i=OrdersTotal()-1;i>=0;i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES) && OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
        {
         if(OrderType()==OP_BUY)
           {
            PriceTarget=AveragePrice+TakeProfit*Point;
            if(Bid>PriceTarget && PriceTarget>0)
              {
               CloseThisSymbolAll();
              }
           }
        }
     }

   if(timeprev==Time[0])
     {
      return;
     }
   timeprev=Time[0];
   

   double CurrentPairProfit=CalculateProfit();
   if(UseEquityStop)
     { //当资金损失低于风险值，不再开仓
      if(CurrentPairProfit<0 && MathAbs(CurrentPairProfit)>(TotalEquityRisk/100)*AccountEquityHigh())
        {
           if(TimeCurrent()%120==0)
               Print("stop opening new orders");
           return;
        }
     }
   
   Print("货币对"+Symbol()+"的止盈:",PriceTarget);

   total=CountTrades(); //计算本货币对订单总数（不包括其他货币对）
   NumOfTrades=total;

   double LastBuyLots;
   double LastSellLots;
   for(cnt=OrdersTotal()-1;cnt>=0;cnt--)
     {
      //统计所有订单，从中间查找本EA执行的本货币对订单，判断之前下的是多单还是空单，供后续使用
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
            if(OrderType()==OP_BUY)
              {
               LongTrade=true;
               ShortTrade=false;
               LastBuyLots=OrderLots();
               break;
              }
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
         if(OrderType()==OP_SELL)
           {
            LongTrade=false;
            ShortTrade=true;
            LastSellLots=OrderLots();
            break;
           }
     }
   if(total>0 && total<=MaxTrades) //有订单且订单总量小于最大值
     {
      LastBuyPrice=FindLastBuyPrice(); //得到上次开仓的买价（多单）
      LastSellPrice=FindLastSellPrice();//得到上次开仓的卖价（空单）
      if(LongTrade && (LastBuyPrice-Ask)>=(PipStep*Point))//判断是否要增开多仓
        {
         TradeNow=true;
        }
      if(ShortTrade && (Bid-LastSellPrice)>=(PipStep*Point))//判断是否要增开空仓
        {
         TradeNow=true;
        }
     }
   if(total<1) //无订单的情况
     {
      ShortTrade=false;
      LongTrade=false;
      TradeNow=true;
      StartEquity=AccountEquity();
     }
   if(TradeNow && total>0) //如果之前判断要加仓则执行if
     {
      LastBuyPrice=FindLastBuyPrice(); //得到上次开仓的买价（多单）
      LastSellPrice=FindLastSellPrice();//得到上次开仓的卖价（空单）
      if(ShortTrade) //如果是空仓
        {
         NumOfTrades=total;
         iLots=fGetLots(OP_SELL);//获得增加仓位的订单手数
         if(UseAdd)//按以上计算出来的加仓手数下单
           {
            if(iLots>0)
              {//#
               RefreshRates();
               ticket=OpenPendingOrder(OP_SELL,iLots,Bid,slip,Ask,0,0,EAName+"-"+IntegerToString(NumOfTrades),MagicNumber,0,HotPink);
               if(ticket<0){Print("Error: ",GetLastError()); return;}
               LastSellPrice=FindLastSellPrice();
               TradeNow=false;
               NewOrdersPlaced=true;
              }//#
           }
        }
      else if(LongTrade)//如果是多仓
        {
         NumOfTrades=total;

         iLots=fGetLots(OP_BUY);//获得增加仓位的订单手数
         if(UseAdd)//按以上计算出来的加仓手数下单
           {
            if(iLots>0)
              {//#
               ticket=OpenPendingOrder(OP_BUY,iLots,Ask,slip,Bid,0,0,EAName+"-"+NumOfTrades,MagicNumber,0,Lime);
               if(ticket<0)
                 {Print("Error: ",GetLastError()); return;}
               LastBuyPrice=FindLastBuyPrice();
               TradeNow=false;
               NewOrdersPlaced=true;
              }//#
           }
        }
     }
   if(TradeNow && total<1)//当前无本货币对订单，并且需要交易
     {
      SellLimit=Bid;
      BuyLimit=Ask;
      if(!ShortTrade && !LongTrade)//当前既无多单又无空单
        {
         NumOfTrades=total;
         if(long_trade==true)//多单
           {
            iLots=fGetLots(OP_BUY);
            if(iLots>0)
              {//#      
               ticket=OpenPendingOrder(OP_BUY,iLots,BuyLimit,slip,BuyLimit,0,0,EAName+"-"+NumOfTrades,MagicNumber,0,Lime);
               if(ticket<0)
                 {
                  Print(iLots,"Error: ",GetLastError());
                  return;
                 }
               LastSellPrice=FindLastSellPrice();
               NewOrdersPlaced=true;
              }//#
           }
        }
      TradeNow=false;
     }

//------------------------------------------------------
//---以平均开仓价格，计算出止损供所有本货币对仓位使用---
//------------------------------------------------------

   if(NewOrdersPlaced)
      for(cnt=OrdersTotal()-1;cnt>=0;cnt--)
        {
         if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
            if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
               if(OrderType()==OP_BUY) // Calculate profit/stop target for long 
                 {
                  PriceTarget=AveragePrice+(TakeProfit*Point);
                  BuyTarget=PriceTarget;
                 }
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
            if(OrderType()==OP_SELL) // Calculate profit/stop target for short
              {
               PriceTarget=AveragePrice-(TakeProfit*Point);
               SellTarget=PriceTarget;
              }
        }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double fGetLots(int aTradeType)
  {
   double tLots;
   tLots=NormalizeDouble(Lots*MathPow(LotExponent,NumOfTrades),LotsDigits);
   if(AccountFreeMarginCheck(Symbol(),aTradeType,tLots)<=0)
     {
      return(-1);
     }
   if(GetLastError()==134)
     {
      return(-2);
     }
   return(tLots);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CountTrades()
  {
   int count=0;
   int trade;
   for(trade=OrdersTotal()-1;trade>=0;trade--)
     {
      if(OrderSelect(trade,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
            if(OrderType()==OP_SELL || OrderType()==OP_BUY)
               count++;
     }//for
   return(count);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CloseThisSymbolAll()
  {
   int trade;
   for(trade=OrdersTotal()-1;trade>=0;trade--)
     {
      if(OrderSelect(trade,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
           {
            if(OrderType()==OP_BUY)
               OrderClose(OrderTicket(),OrderLots(),Bid,slip,Blue);
            if(OrderType()==OP_SELL)
               OrderClose(OrderTicket(),OrderLots(),Ask,slip,Red);
           }
      Sleep(1000);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OpenPendingOrder(int pType,double pLots,double pLevel,int sp,double pr,int sl,int tp,string pComment,int pMagic,datetime pExpiration,color pColor)
  {
   int ticket=0;
   int err=0;
   int c=0;
   int NumberOfTries=100;
   switch(pType)
     {
      case OP_BUYLIMIT:
         for(c=0;c<NumberOfTries;c++)
           {
            ticket=OrderSend(Symbol(),OP_BUYLIMIT,pLots,pLevel,sp,StopLong(pr,sl),TakeLong(pLevel,tp),pComment,pMagic,pExpiration,pColor);
            err=GetLastError();
            if(err==0)
              {
               break;
              }
            else
              {
               if(err==4 || err==137 || err==146 || err==136) //Busy errors
                 {
                  Sleep(1000);
                  continue;
                 }
               else //normal error
                 {
                  break;
                 }
              }
           }
         break;
      case OP_BUYSTOP:
         for(c=0;c<NumberOfTries;c++)
           {
            ticket=OrderSend(Symbol(),OP_BUYSTOP,pLots,pLevel,sp,StopLong(pr,sl),TakeLong(pLevel,tp),pComment,pMagic,pExpiration,pColor);
            err=GetLastError();
            if(err==0)
              {
               break;
              }
            else
              {
               if(err==4 || err==137 || err==146 || err==136) //Busy errors
                 {
                  Sleep(5000);
                  continue;
                 }
               else //normal error
                 {
                  break;
                 }
              }
           }
         break;
      case OP_BUY:
         for(c=0;c<NumberOfTries;c++)
           {
            RefreshRates();
            ticket=OrderSend(Symbol(),OP_BUY,pLots,Ask,sp,StopLong(Bid,sl),TakeLong(Ask,tp),pComment,pMagic,pExpiration,pColor);
            err=GetLastError();
            if(err==0)
              {
               break;
              }
            else
              {
               if(err==4 || err==137 || err==146 || err==136) //Busy errors
                 {
                  Sleep(5000);
                  continue;
                 }
               else //normal error
                 {
                  break;
                 }
              }
           }
         break;
      case OP_SELLLIMIT:
         for(c=0;c<NumberOfTries;c++)
           {
            ticket=OrderSend(Symbol(),OP_SELLLIMIT,pLots,pLevel,sp,StopShort(pr,sl),TakeShort(pLevel,tp),pComment,pMagic,pExpiration,pColor);
            err=GetLastError();
            if(err==0)
              {
               break;
              }
            else
              {
               if(err==4 || err==137 || err==146 || err==136) //Busy errors
                 {
                  Sleep(5000);
                  continue;
                 }
               else //normal error
                 {
                  break;
                 }
              }
           }
         break;
      case OP_SELLSTOP:
         for(c=0;c<NumberOfTries;c++)
           {
            ticket=OrderSend(Symbol(),OP_SELLSTOP,pLots,pLevel,sp,StopShort(pr,sl),TakeShort(pLevel,tp),pComment,pMagic,pExpiration,pColor);
            err=GetLastError();
            if(err==0)
              {
               break;
              }
            else
              {
               if(err==4 || err==137 || err==146 || err==136) //Busy errors
                 {
                  Sleep(5000);
                  continue;
                 }
               else //normal error
                 {
                  break;
                 }
              }
           }
         break;
      case OP_SELL:
         for(c=0;c<NumberOfTries;c++)
           {
            ticket=OrderSend(Symbol(),OP_SELL,pLots,Bid,sp,StopShort(Ask,sl),TakeShort(Bid,tp),pComment,pMagic,pExpiration,pColor);
            err=GetLastError();
            if(err==0)
              {
               break;
              }
            else
              {
               if(err==4 || err==137 || err==146 || err==136) //Busy errors
                 {
                  Sleep(5000);
                  continue;
                 }
               else //normal error
                 {
                  break;
                 }
              }
           }
         break;
     }

   return(ticket);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double StopLong(double price,int stop)
  {
   if(stop==0)
      return(0);
   else
      return(price-(stop*Point));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double StopShort(double price,int stop)
  {
   if(stop==0)
      return(0);
   else
      return(price+(stop*Point));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double TakeLong(double price,int take)
  {
   if(take==0)
      return(0);
   else
      return(price+(take*Point));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double TakeShort(double price,int take)
  {
   if(take==0)
      return(0);
   else
      return(price-(take*Point));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CalculateProfit()
  {
   double Profit=0;
   for(cnt=OrdersTotal()-1;cnt>=0;cnt--)
     {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
            if(OrderType()==OP_BUY || OrderType()==OP_SELL)
              {
               Profit=Profit+OrderProfit();
              }
     }
   return(Profit);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double AccountEquityHigh()
  {
   static double AccountEquityHighAmt,PrevEquity;
   if(CountTrades()==0) AccountEquityHighAmt=AccountEquity();
   if(AccountEquityHighAmt<PrevEquity) AccountEquityHighAmt=PrevEquity;
   else AccountEquityHighAmt=AccountEquity();
   PrevEquity=AccountEquity();
   return(AccountEquityHighAmt);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double FindLastBuyPrice()
  {
   double oldorderopenprice=0,orderprice=0;
   int cnt_temp,oldticketnumber=0,ticketnumber;
   for(cnt_temp=OrdersTotal()-1;cnt_temp>=0;cnt_temp--)
     {
      if(OrderSelect(cnt_temp,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber && OrderType()==OP_BUY)
           {
            ticketnumber=OrderTicket();
            if(ticketnumber>oldticketnumber)
              {
               orderprice=OrderOpenPrice();
               oldorderopenprice=orderprice;
               oldticketnumber=ticketnumber;
              }
           }
     }
   return(orderprice);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double FindLastSellPrice()
  {
   double oldorderopenprice=0,orderprice=0;
   int cnt_temp,oldticketnumber=0,ticketnumber;
   for(cnt_temp=OrdersTotal()-1;cnt_temp>=0;cnt_temp--)
     {
      if(OrderSelect(cnt_temp,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber && OrderType()==OP_SELL)
           {
            ticketnumber=OrderTicket();
            if(ticketnumber>oldticketnumber)
              {
               orderprice=OrderOpenPrice();
               oldorderopenprice=orderprice;
               oldticketnumber=ticketnumber;
              }
           }
     }
   return(orderprice);
  }
//+------------------------------------------------------------------+
