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
