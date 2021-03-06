#property copyright "shiyingpan"
#property link      "https://aijy.github.io"
#property version   "1.00"
#property strict

input double 单量=0.2;
input int 止损=400;
input int 移动止损=100;
input int 启动移动止损=300;

input int 交易开始时间=2;
input int 交易停止时间=22;

int Magic_num=445678;
datetime trade_time;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   if(AccountNumber()==0) //----通过判断账户号，确定是否连接网络
      return;

   double kd15_main,kd15_main_prv,kd15_sig,kd15_sig_prv;
   int ticket;
   bool long_order_exist=false,short_order_exist=false;

   for(int i=OrdersTotal()-1;i>=0;i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES) && OrderSymbol()==Symbol())
        {
         if(OrderType()==OP_BUY && OrderMagicNumber()==Magic_num)
           {
            long_order_exist=true;
            //--首先价格要超过启动止损位置，然后还要比当前止损大 移动止损以上
            if(Bid>(OrderOpenPrice()+启动移动止损*Point) && (Bid-OrderStopLoss())>移动止损*Point)
               OrderModify(OrderTicket(),OrderOpenPrice(),Bid-移动止损*Point,0,0,clrNONE);// 设置移动止损         
           }

         if(OrderType()==OP_SELL && OrderMagicNumber()==Magic_num)
           {
            short_order_exist=true;
            if(Ask<(OrderOpenPrice()-启动移动止损*Point) && (OrderStopLoss()-Ask)>移动止损*Point)
               OrderModify(OrderTicket(),OrderOpenPrice(),Ask+移动止损*Point,0,0,clrNONE);// 设置移动止损         

           }
        }
     }

   //-- TimeHour() 函数返回 时间参数 的小时数
   if(TimeHour(TimeCurrent())>=交易停止时间 || TimeHour(TimeCurrent())<交易开始时间) //---------在流动性差的时间段不交易（点差高）
      return;

   if(trade_time==iTime(Symbol(),PERIOD_M15,0)) //---每隔15分钟计算一次是否要下单
     {
      return;
     }
   trade_time=iTime(Symbol(),PERIOD_M15,0);

   kd15_main=iStochastic(Symbol(),PERIOD_M15,5,3,3,MODE_EMA,0,MODE_MAIN,1);
   kd15_sig=iStochastic(Symbol(),PERIOD_M15,5,3,3,MODE_EMA,0,MODE_SIGNAL,1);

   kd15_main_prv=iStochastic(Symbol(),PERIOD_M15,5,3,3,MODE_EMA,0,MODE_MAIN,2);
   kd15_sig_prv=iStochastic(Symbol(),PERIOD_M15,5,3,3,MODE_EMA,0,MODE_SIGNAL,2);

   if(long_order_exist==false) //---当前有多单，就不再下多单
     {
      // 在35以下的金叉买入
      if(kd15_main_prv<kd15_sig_prv && kd15_main>kd15_sig && kd15_main_prv<35 && kd15_sig_prv<35 && kd15_main<35 && kd15_sig<35)
        {
         ticket=OrderSend(Symbol(),OP_BUY,单量,Ask,3,止损*Point,0,"KD_long",Magic_num,0,clrRed);
         if(ticket==0)
           {
            Print("open buy order error:",GetLastError());
           }
        }
     }

   if(short_order_exist==false)  //---当前有空单，就不再下空单
     {
      //--在65以上的死叉卖出
      if(kd15_main_prv>kd15_sig_prv && kd15_main<kd15_sig && kd15_main_prv>65 && kd15_sig_prv>65 && kd15_main>65 && kd15_sig>65)
        {
         ticket=OrderSend(Symbol(),OP_SELL,单量,Bid,3,止损*Point,0,"KD_short",Magic_num,0,clrYellow);
         if(ticket==0)
           {
            Print("open sell order error:",GetLastError());
           }
        }
     }
  }
