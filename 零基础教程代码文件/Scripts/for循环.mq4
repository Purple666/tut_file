#property copyright "shiyingpan"
#property link      "https://www.myfxlab.cn"
#property version   "1.00"
#property strict

void OnStart()
  {
//-----做1到100的累加----//

   int sum=0;
   for(int i=1;i<=100;i++)
   {
      sum=sum+i;
   }
   Print("1到100的累加结果为：",sum);
   
   int i=1;
   sum=0;
   while(i<=100)
   {
      sum=sum+i;
   }

   Print("1到100的累加结果为：",sum);
  }
