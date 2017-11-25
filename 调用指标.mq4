//+------------------------------------------------------------------+
//|                                                         调用指标.mq4 |
//|                                                       shiyingpan |
//|                                     https://shiyingpan.github.io |
//+------------------------------------------------------------------+
#property copyright "shiyingpan"
#property link      "https://shiyingpan.github.io"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
 //  double a1,a2,a3,a4,a5;
 //  for(int i=0;i<100;i++)
 //  {
 //  a1=iCustom(Symbol(),PERIOD_M30,"MACD_Histogram","first",12,26,9,"second",True,True,True,0,i);
 //  a2=iCustom(Symbol(),PERIOD_M30,"MACD_Histogram","first",12,26,9,"second",True,True,True,1,i);
 //  a3=iCustom(Symbol(),PERIOD_M30,"MACD_Histogram","first",12,26,9,"second",True,True,True,2,i);
 //  a4=iCustom(Symbol(),PERIOD_M30,"MACD_Histogram","first",12,26,9,"second",True,True,True,3,i);
 //  a5=iCustom(Symbol(),PERIOD_M30,"MACD_Histogram","first",12,26,9,"second",True,True,True,4,i);
 //  if(a4<1 || a5<1)
 //  PrintFormat("%.5f,%.5f,%.5f,%.5f,%.5f,%d",a1,a2,a3,a4,a5,i);
 //}
 
 
 
   double long_value,short_value,macd_value;

   macd_value = iCustom(Symbol(),PERIOD_M30,"MACD_Histogram","first",12,26,9,"second",True,True,True,0,2);
   long_value = iCustom(Symbol(),PERIOD_M30,"MACD_Histogram","first",12,26,9,"second",True,True,True,3,2);
   short_value = iCustom(Symbol(),PERIOD_M30,"MACD_Histogram","first",12,26,9,"second",True,True,True,4,2);
   
   if(long_value<1 && MathAbs(macd_value-long_value)<0.01)
   {
      //底背离，多单
      Print("dddd",i);
   }
   if(short_value<1 && MathAbs(macd_value-short_value)<0.01)
   {
      //顶背离，空单
      Print("dffs",i);
   }   

  }
//+------------------------------------------------------------------+
