/*----函数的基本结构-----//
返回值类型 函数名(参数类型 参数定义,参数类型 参数定义)
{
   函数主体
}
*/
#property copyright "shiyingpan"
#property link      "https://www.myfxlab.cn"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| OnStart()也是一个函数，并且没有返回值                                   |
//+------------------------------------------------------------------+
void OnStart()
  {
   Acc_check(); //---没有参数
   int a=1,b=2,c=3,res;
   res = add(a,b,c,4);//---有4个参数，与函数定义需一一对应
   Print("res:",res);
  }
  
void Acc_check()
{
   if(!IsDemo())
   {
      Alert("非模拟账户，请谨慎操作！");
   }   
   return;
}

int add(int aa,int bb,int cc,int dd)
{
   int r=0;
   r=aa+bb+cc+dd;
   return r;
}