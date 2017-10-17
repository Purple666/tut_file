#property copyright "shiyingpan"
#property link      "https://shiyingpan.github.io"
#property version   "1.00"
#property strict
/*------------------------------------------------------------------
常用的数据类型有 bool,int,double,string,datetime.
  bool：真假类型，只有 true(真),false(假)。
  int ：整型，即整数，不能带有小数。
  double ：浮点数，可以带小数，如1.2,1.33等。
  string ：字符，使用时用英文引号("")包括。
  datetime : 时间类型，格式为 D'年.月.日 时:分:秒'，如D'2017.11.20 12:34:34'
                                     
*/
void OnStart()
  {
   bool     允许交易=true;
   int      EA魔术数=123;
   double   订单手数=0.1;
   string   订单标注="这是一个多单";
   datetime 交易时间=D'2017.11.20 12:00:00';
   
   Print("允许交易:",允许交易);
   Print("EA魔术数:",EA魔术数);
   Print("订单手数:",订单手数);
   Print("订单标注:",订单标注);
   Print("交易时间:",交易时间);
  }
//+------------------------------------------------------------------+
