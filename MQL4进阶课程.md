---
title: "MQL4进阶课程"
date: "2017-12-16 10:10:16"
categories: MQL4课程
toc: true
---

<strong>本教程是属于视频课程的配套课程，课程时间预计4小时</strong>

``` c++

```
## 指标的调用 ##

### 均线指标 ###
``` c++
#property copyright "shiyingpan"
#property link      "https://aijy.github.io"
#property version   "1.00"
#property strict

void OnStart()
  {
//---------- 默认币种4小时周期，前三根K线14日均线值 -----------//
 
   string 币种=Symbol(); //----币种Symbol为图表币种，也可直接定义如“EURUSD”
   int 时间周期=240;     //----时间周期指图表周期，240（分钟）是4小时图，使用0，则默认图表周期
   int 均线周期=14;      //----均线周期，本例指14均线

   double ma_0=iMA(币种,时间周期,均线周期,0,MODE_EMA,PRICE_CLOSE,0);  //---最后一个参数表示第几根k线，0是从右往左第一根，即最近的一根K线
   double ma_1=iMA(币种,时间周期,均线周期,0,MODE_EMA,PRICE_CLOSE,1);  //---第二根，从右往左。注意第n+1根K线的标号为n。
   double ma_2=iMA(币种,时间周期,均线周期,0,MODE_EMA,PRICE_CLOSE,2);  

   PrintFormat("前三根K线均线值为：%.5f,%.5f,%.5f",ma_0,ma_1,ma_2);
   
//---------- 获取 EURUSD 日线50日周期的前日收盘均线值 -----------//  
   double ma_eurusd=iMA("EURUSD",PERIOD_D1,50,0,MODE_EMA,PRICE_CLOSE,1);  
   PrintFormat("EURUSD的均线值为：%.5f",ma_eurusd); 
  }


```
### MACD指标 ###
``` c++
#property copyright "shiyingpan"
#property link      "https://aijy.github.io"
#property version   "1.00"
#property strict

void OnStart()
  {
/*
    设置币种4小时周期，前根K线MACD值,MACD有2个返回值macd的值，与macd的均线值
*/
   string 币种=Symbol(); //----币种Symbol为图表币种，也可直接定义如“EURUSD”
   int 时间周期=240;     //----时间周期指图表周期，240（分钟）是4小时图，使用0，则默认图表周期
   int 慢周期=26,快周期=12,均滑周期=9;
   
   double macd_main=iMACD(币种,时间周期,快周期,慢周期,均滑周期,PRICE_CLOSE,MODE_MAIN,1);  //---最后一个参数表示第几根k线，0是从右往左第一根，即最近的一根K线
   double macd_signal=iMACD(币种,时间周期,快周期,慢周期,均滑周期,PRICE_CLOSE,MODE_SIGNAL,1);  //---第二根，从右往左。注意第n+1根K线的标号为n。

   PrintFormat("MACD值为：%.5f,SIGNAL：%.5f",macd_main,macd_signal);
   
//---------- 获取 EURUSD 日线当前MACD值 -----------//  
   macd_main=iMACD("EURUSD",PERIOD_D1,快周期,慢周期,均滑周期,PRICE_CLOSE,MODE_MAIN,0);  //---最后一个参数表示第几根k线，0是从右往左第一根，即最近的一根K线
   macd_signal=iMACD("EURUSD",PERIOD_D1,快周期,慢周期,均滑周期,PRICE_CLOSE,MODE_SIGNAL,0);  //---第二根，从右往左。注意第n+1根K线的标号为n。

   PrintFormat("MACD值为：%.5f,SIGNAL：%.5f",macd_main,macd_signal);
  }
```
### 布林线  ###
``` c++
#property copyright "shiyingpan"
#property link      "https://aijy.github.io"
#property version   "1.00"
#property strict

void OnStart()
  {
/*
    设置币种4小时周期，前根K线布林线上、中、下轨值
*/
   string 币种=Symbol(); //----币种Symbol为图表币种，也可直接定义如“EURUSD”
   int 时间周期=240;     //----时间周期指图表周期，240（分钟）是4小时图，使用0，则默认图表周期
   int 布林线周期=20,布林线方差=2;
   
   double bands_upper  =iBands(币种,时间周期,布林线周期,布林线方差,0,PRICE_CLOSE,MODE_UPPER,1);  //---第二根k线，布林线上轨值
   double bands_middle =iBands(币种,时间周期,布林线周期,布林线方差,0,PRICE_CLOSE,MODE_MAIN,1);  //---第二根k线，布林线中轨值
   double bands_lower  =iBands(币种,时间周期,布林线周期,布林线方差,0,PRICE_CLOSE,MODE_LOWER,1);  //---第二根k线，布林线下轨值

   PrintFormat("4小时布林线前K线上轨值：%.5f,中轨值：%.5f,下轨值：%.5f",bands_upper,bands_middle,bands_lower);
   
//---------- 获取 EURUSD 日线当前布林线值 -----------//  
   bands_upper  =iBands("EURUSD",PERIOD_D1,20,2,0,PRICE_CLOSE,MODE_UPPER,0);  //--- 布林线上轨值
   bands_middle =iBands("EURUSD",PERIOD_D1,20,2,0,PRICE_CLOSE,MODE_MAIN,0);  //--- 布林线中轨值
   bands_lower  =iBands("EURUSD",PERIOD_D1,20,2,0,PRICE_CLOSE,MODE_LOWER,0);  //--- 布林线下轨值

   PrintFormat("当前日线布林线上轨值：%.5f,中轨值：%.5f,下轨值：%.5f",bands_upper,bands_middle,bands_lower);
  }


```
### RSI    ###
``` c++
#property copyright "shiyingpan"
#property link      "https://aijy.github.io"
#property version   "1.00"
#property strict

void OnStart()
  {
//---------- 设置币种4小时周期，前三根K线14日RSI值 -----------//
 
   string 币种=Symbol(); //----币种Symbol为图表币种，也可直接定义如“EURUSD”
   int 时间周期=240;     //----时间周期指图表周期，240（分钟）是4小时图，使用0，则默认图表周期
   int RSI周期=14;      //----均线周期，本例指14均线

   double rsi_0=iRSI(币种,时间周期,RSI周期,PRICE_CLOSE,0);  //---最后一个参数表示第几根k线，0是从右往左第一根，即最近的一根K线
   double rsi_1=iRSI(币种,时间周期,RSI周期,PRICE_CLOSE,1);  //---第二根，从右往左。注意第n+1根K线的标号为n。
   double rsi_2=iRSI(币种,时间周期,RSI周期,PRICE_CLOSE,2);  

   PrintFormat("前三根K线RSI值为：%.5f,%.5f,%.5f",rsi_0,rsi_1,rsi_2);
   
//---------- 获取 EURUSD 日线日收盘RSI值 -----------//  
   double rsi_eurusd=iRSI("EURUSD",PERIOD_D1,14,PRICE_CLOSE,1);  
   PrintFormat("EURUSD日线的RSI值为：%.5f",rsi_eurusd); 
  }


```
### KD指标 ###
``` c++
#property copyright "shiyingpan"
#property link      "https://aijy.github.io"
#property version   "1.00"
#property strict

void OnStart()
  {
/*
    设置币种4小时周期，前根K线KD值,KD有2个返回值K值，与D值
*/
   string 币种=Symbol(); //----币种Symbol为图表币种，也可直接定义如“EURUSD”
   int 时间周期=240;     //----时间周期指图表周期，240（分钟）是4小时图，使用0，则默认图表周期
   int K周期=5,D周期=3,均滑周期=3;
   
   double kd_main=iStochastic(币种,时间周期,K周期,D周期,均滑周期,MODE_EMA,0,MODE_MAIN,1);  //---最后一个参数表示第几根k线，0是从右往左第一根，即最近的一根K线
   double kd_signal=iStochastic(币种,时间周期,K周期,D周期,均滑周期,MODE_EMA,0,MODE_SIGNAL,1);  //---第二根，从右往左。注意第n+1根K线的标号为n。

   PrintFormat("KD值为：%.5f,SIGNAL：%.5f",kd_main,kd_signal);
   
//---------- 获取 EURUSD 日线当前KD值 -----------//  
   kd_main=iStochastic("EURUSD",PERIOD_D1,5,3,3,MODE_EMA,0,MODE_MAIN,0);  //---最后一个参数表示第几根k线，0是从右往左第一根，即最近的一根K线
   kd_signal=iStochastic("EURUSD",PERIOD_D1,5,3,3,MODE_EMA,0,MODE_SIGNAL,0);  //---第二根，从右往左。注意第n+1根K线的标号为n。

   PrintFormat("KD值为：%.5f,SIGNAL：%.5f",kd_main,kd_signal);
  }
```
### 其他系统自带指标 ###
其他系统自带指标参照帮助文件中的指标调用方式调用，调用形式都是一样的。

### 自定义指标 ###
``` c++
#property copyright "shiyingpan"
#property link      "https://aijy.github.io"
#property version   "1.00"
#property strict

void OnStart()
  {
//---------- 调用自定义指标，指标需在指标文件夹中 -----------//
 
/*----  iCustom用法
 iCustom(货币对名称, 时间周期, 指标名, 指标输入参数1,指标输入参数2,第几个数据,第几根K线); 
*/ 
   string 币种=Symbol(); //----币种Symbol为图表币种，也可直接定义如“EURUSD”
   int 时间周期=240;     //----时间周期指图表周期，240（分钟）是4小时图，使用0，则默认图表周期
   string 指标名="RSI";

   double value_0=iCustom(币种,时间周期,指标名,14,0,0);  //---最后一个参数表示第几根k线，0是从右往左第一根，即最近的一根K线
   double value_1=iCustom(币种,时间周期,指标名,14,0,1);  //---第二根，从右往左。注意第n+1根K线的标号为n。
   double value_2=iCustom(币种,时间周期,指标名,14,0,2);  

   PrintFormat("前三根K线RSI值为：%.5f,%.5f,%.5f",value_0,value_1,value_2);
   
//---------- 获取 EURUSD 日线的zigzag值 -----------// 
    
   double zz_value=0;
   double position=0;
   for(int i=0;i<100;i++)
   {
      zz_value=iCustom("EURUSD", PERIOD_D1, "ZigZag", 12, 5, 3, 0, i); 
      if(zz_value!=0)
      {
         position=i;
         break;
      }   
   }   
   PrintFormat("EURUSD日线上个峰值/底值为：%.5f,第%d根K线",zz_value,position); 
  }

```

## 基于KD指标的下单程序 ##
本例有以下几个要点：

- 移动止损
- 一根K线下一次单
- 如何避免无限重复下单
- 
``` c++
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

```

## 指标的编写 ##
### KD指标代码解读 ###
``` c++

#property copyright   "2005-2014, MetaQuotes Software Corp."
#property link        "http://www.mql4.com"
#property description "Stochastic Oscillator"
#property strict

#property indicator_separate_window  //-- 显示在附图上,若要主图显示用 indicator_chart_window 
#property indicator_minimum    0     //-- 指标下限（可选） 
#property indicator_maximum    100   //-- 指标上限（可选） 
#property indicator_buffers    2     //-- 指标数据缓存，2表示这个指标有2个数据。非常重要
#property indicator_color1     LightSeaGreen   //-- 第一根指标线的颜色
#property indicator_color2     Red   //-- 第二根指标线的颜色
#property indicator_level1     20.0    //-- 指标数值参考线
#property indicator_level2     80.0    //-- 指标数值参考线
#property indicator_levelcolor clrSilver  //-- 指标数值参考线颜色（统一的颜色）
#property indicator_levelstyle STYLE_DOT  //-- 指标数值参考线类型（统一的类型），本例点线
//--- input parameters
input int InpKPeriod=5; // K Period     参数定义与输入
input int InpDPeriod=3; // D Period
input int InpSlowing=3; // Slowing

//-- 定义需要使用的缓存器,按需定义。只要要定义上面设置的数据缓存数目
double ExtMainBuffer[];       //-- 定义主缓存空间
double ExtSignalBuffer[];     //-- 定义Signal数值的缓存空间
double ExtHighesBuffer[];     //-- 中间变量空间，供中间计算
double ExtLowesBuffer[];      //-- 中间变量空间，供中间计算
//---
int draw_begin1=0;
int draw_begin2=0;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit(void)
  {
   string short_name;
//--- 2 additional buffers are used for counting.
   IndicatorBuffers(4);                   //-- 声明4个缓存空间
   SetIndexBuffer(2, ExtHighesBuffer);    //-- 缓存空间与编号要一一对应，ExtHighesBuffer对应2
   SetIndexBuffer(3, ExtLowesBuffer);     //-- ExtLowesBuffer对应3，问题：为什么中间变量空间不对应0和1？
                                          //-- 答：编号首先供指标缓存使用，然后才能给中间变量空间使用
   
//--- indicator lines
   SetIndexStyle(0,DRAW_LINE);            //-- 设置数据1是线型  
   SetIndexBuffer(0, ExtMainBuffer);      //-- 指定数据1的缓存空间
   SetIndexStyle(1,DRAW_LINE);            //-- 设置数据2是线型
   SetIndexBuffer(1, ExtSignalBuffer);    //-- 指定数据2的缓存空间
//--- name for DataWindow and indicator subwindow label
   short_name="Sto("+IntegerToString(InpKPeriod)+","+IntegerToString(InpDPeriod)+","+IntegerToString(InpSlowing)+")";
   IndicatorShortName(short_name); //--指标名
   SetIndexLabel(0,short_name); //-- 数据1的名称
   SetIndexLabel(1,"Signal"); //-- 数据2的名称
//---
   draw_begin1=InpKPeriod+InpSlowing;
   draw_begin2=draw_begin1+InpDPeriod;
   SetIndexDrawBegin(0,draw_begin1);   //-- 数据1画线起始位置
   SetIndexDrawBegin(1,draw_begin2);   //-- 数据2画线起始位置
//--- initialization done
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Stochastic oscillator                                            |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
   int    i,k,pos;
//--- rates_total是当前可用的K线数量，如果太小，则不能计算指标
   if(rates_total<=InpKPeriod+InpDPeriod+InpSlowing)
      return(0);
//--- 指标的数据存储是按K线从左到右计算的，不需要反向
   ArraySetAsSeries(ExtMainBuffer,false);
   ArraySetAsSeries(ExtSignalBuffer,false);
   ArraySetAsSeries(ExtHighesBuffer,false);
   ArraySetAsSeries(ExtLowesBuffer,false);
   ArraySetAsSeries(low,false);
   ArraySetAsSeries(high,false);
   ArraySetAsSeries(close,false);
//---
   pos=InpKPeriod-1;
   if(pos+1<prev_calculated) //---prev_calculated表示未参与运算的K线数
      pos=prev_calculated-2;
   else
     {
      for(i=0; i<pos; i++)      //--  通过for循环为最初没有用到的空间赋初值0
        {                       //--  比如highbuffer是记录前5日的高点的，那么0-4的值是没有的，赋为0
         ExtLowesBuffer[i]=0.0;  
         ExtHighesBuffer[i]=0.0;
        }
     }
//--- calculate HighesBuffer[] and ExtHighesBuffer[]
   for(i=pos; i<rates_total && !IsStopped(); i++) //-- 从未计算的K线开始，一直计算到所有K线
     {
      double dmin=1000000.0;
      double dmax=-1000000.0;
      for(k=i-InpKPeriod+1; k<=i; k++)
        {
         if(dmin>low[k])
            dmin=low[k];        //-- 前InpKPeriod（5）根K线的低点
         if(dmax<high[k])
            dmax=high[k];       //-- 前InpKPeriod（5）根K线的高点
        }
      ExtLowesBuffer[i]=dmin;   //-- ExtLowesBuffer[i]，指的是第i根K线前InpKPeriod（5）根K线的低点
      ExtHighesBuffer[i]=dmax;  //-- ExtLowesBuffer[i]，指的是第i根K线前InpKPeriod（5）根K线的低点
     }
//--- 为未使用到的K值存储空间赋初值0
   pos=InpKPeriod-1+InpSlowing-1;
   if(pos+1<prev_calculated)
      pos=prev_calculated-2;
   else
     {
      for(i=0; i<pos; i++)
         ExtMainBuffer[i]=0.0;
     }
//--- 计算K值，主循环，
   for(i=pos; i<rates_total && !IsStopped(); i++)
     {
      //-- 自定义指标的的数据缓存空间的计算主要在这个位置进行计算
      //-- 以下是K值计算方法，每种指标计算方法不同，理解这种结构和操作形式即可
      double sumlow=0.0;
      double sumhigh=0.0;
      for(k=(i-InpSlowing+1); k<=i; k++)
        {
         sumlow +=(close[k]-ExtLowesBuffer[k]); //-- 计算均滑（3）日的总和值。
         sumhigh+=(ExtHighesBuffer[k]-ExtLowesBuffer[k]);
        }
      if(sumhigh==0.0)
         ExtMainBuffer[i]=100.0;
      else
         ExtMainBuffer[i]=sumlow/sumhigh*100.0;
     }
//--- 计算D值，主循环
   pos=InpDPeriod-1;
   if(pos+1<prev_calculated)
      pos=prev_calculated-2;
   else
     {
      for(i=0; i<pos; i++)
         ExtSignalBuffer[i]=0.0;
     }
   for(i=pos; i<rates_total && !IsStopped(); i++)
     {
      double sum=0.0;
      for(k=0; k<InpDPeriod; k++)
         sum+=ExtMainBuffer[i-k];
      ExtSignalBuffer[i]=sum/InpDPeriod;
     }
//--- 到此计算结束，只要在计算中给缓存空间赋值即可，图表会根据数值和设定的图表类型自动画上去。
   return(rates_total);
  }

```
### 三色线指标代码实现 ###
``` c++
/*--------------------------------
本例制作一款趋势类型的变色均线指标，
红色是跌势
黄色是震荡
绿线是上涨
均线周期可选
----------------------------------*/
#property copyright "shiyingpan"
#property link      "https://aijy.github.io"
#property version   "1.00"
#property strict
//---定义指标属性
#property indicator_chart_window
#property indicator_buffers 3
#property indicator_color1 Red
#property indicator_color2 Green
#property indicator_color3 Yellow
//---设置输入参数
input int 短周期=10;
input int 中周期=20;
input int 长周期=30;

//---定义指标缓存空间
double LongBuffer[];
double ShortBuffer[];
double NoTrendBuffer[];

//--- 指标起始点
int draw_begin=0;
int OnInit()
  {
//-- 为指标取个名字  
   string short_name="趋势指标("+IntegerToString(短周期)+IntegerToString(中周期)+IntegerToString(长周期)+")";
   IndicatorShortName(short_name);
//-- 设置指标缓存空间数量，设置线型并做连接,在此都设置为线型
   IndicatorBuffers(3);
   SetIndexStyle(0,DRAW_LINE,STYLE_SOLID,2);  
   SetIndexBuffer(0,LongBuffer);
   SetIndexStyle(1,DRAW_LINE,STYLE_SOLID,2);
   SetIndexBuffer(1,ShortBuffer);
   SetIndexStyle(2,DRAW_LINE,STYLE_SOLID,2);
   SetIndexBuffer(2,NoTrendBuffer);
//-- 设置指标起始的地方,小于长周期的K线并没有值   
   draw_begin=长周期;
   SetIndexDrawBegin(0,draw_begin);
//-- 返回初始化成功，若返回 INIT_FAILED则指标不会成功加载
   return(INIT_SUCCEEDED);
  }

int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//-- 若K线数量小于长周期数目，则不够计算
   if(rates_total<=长周期)
      return(0);
//-- 缓存空间顺序是从左到右的，最左边是1      
   ArraySetAsSeries(LongBuffer,false);
   ArraySetAsSeries(ShortBuffer,false);
   ArraySetAsSeries(NoTrendBuffer,false);

         
   double ma_fast,ma_mid,ma_slow;
   double ma_fast_prv,ma_mid_prv,ma_slow_prv;

//-- 为显示趋势变化快慢，为较短的周期赋予较大的权重
   double sum=短周期+中周期+长周期;
   double w1=长周期/sum,w2=中周期/sum,w3=短周期/sum;
    
   for(int i=draw_begin+1; i<=rates_total && !IsStopped(); i++)
   {
      ma_fast = iMA(Symbol(),0,短周期,0,MODE_EMA,PRICE_CLOSE,rates_total-i);
      ma_mid = iMA(Symbol(),0,中周期,0,MODE_EMA,PRICE_CLOSE,rates_total-i);
      ma_slow = iMA(Symbol(),0,长周期,0,MODE_EMA,PRICE_CLOSE,rates_total-i); 
      
      ma_fast_prv = iMA(Symbol(),0,短周期,0,MODE_EMA,PRICE_CLOSE,rates_total-i+1);
      ma_mid_prv = iMA(Symbol(),0,中周期,0,MODE_EMA,PRICE_CLOSE,rates_total-i+1);
      ma_slow_prv = iMA(Symbol(),0,长周期,0,MODE_EMA,PRICE_CLOSE,rates_total-i+1); 
      
      if(ma_fast>ma_mid && ma_mid>ma_slow)  //--- 多头排列，上涨趋势
      {
         LongBuffer[i]=(ma_fast+ma_mid+ma_slow)/3;              //--  计算本根和上一根的值，做不同趋势的连接
         LongBuffer[i-1]=(ma_fast_prv+ma_mid_prv+ma_slow_prv)/3;
         
         //LongBuffer[i]  =ma_fast*w1+ma_mid*w2+ma_slow*w3;              
         //LongBuffer[i-1]=ma_fast_prv*w1+ma_mid_prv*w2+ma_slow_prv*w3;
      }
      else if(ma_fast<ma_mid && ma_mid<ma_slow)  //--- 空头排列，下跌趋势
      {
         ShortBuffer[i]=(ma_fast+ma_mid+ma_slow)/3;
         ShortBuffer[i-1]=(ma_fast_prv+ma_mid_prv+ma_slow_prv)/3;
         
         //ShortBuffer[i]  =ma_fast*w1+ma_mid*w2+ma_slow*w3;              
         //ShortBuffer[i-1]=ma_fast_prv*w1+ma_mid_prv*w2+ma_slow_prv*w3;
      }
      else  //-- 除了上涨、下跌趋势，就是归纳于震荡
      {
         NoTrendBuffer[i]=(ma_fast+ma_mid+ma_slow)/3;
         NoTrendBuffer[i-1]=(ma_fast_prv+ma_mid_prv+ma_slow_prv)/3;
         
         //NoTrendBuffer[i]  =ma_fast*w1+ma_mid*w2+ma_slow*w3;              
         //NoTrendBuffer[i-1]=ma_fast_prv*w1+ma_mid_prv*w2+ma_slow_prv*w3;
      }
   }
   return(rates_total);
  }

```

## 账户的操作 ##
- 账号
- 账户名
- 账户资金
- 账户类型

### 账户净值风险控制 ###
``` c++
#property copyright "shiyingpan"
#property link      "https://aijy.github.io"
#property version   "1.00"
#property strict

int 授权账号=123;
double 初始资金=0;

int OnInit()
  {
   while(AccountNumber()==0) //-- 加载前可先使用账户号判断时候可交易，网络未连接时，账号为0
      Sleep(500);            //-- 程序在此停留0.5秒，啥也不干，再判断账号值
   if(AccountNumber()!=授权账号)
   {
      Alert("非授权账号");
      return INIT_FAILED;   //-- 非授权账号，不能加载成功
   }
   Print("账号名：",AccountName());    //-- 获取账户名   
   初始资金=AccountEquity();           //-- 加载EA时获取当前账户净值
   
   if(!IsDemo())                  //-- 如果是实盘
   {
      Alert("当前账户为实盘账户！");
   }
   return(INIT_SUCCEEDED);
  }

void OnDeinit(const int reason)
  {

   
  }

void OnTick()
  {
//--------------- 账户净值风险控制 ----------------//
   if(AccountEquity()<初始资金*0.8)
   {
      Alert("当前账户净值亏损20%，已停止交易");
      //-- 添加平仓操作（平仓退出）
      ExpertRemove(); //-- 退出EA
      return;
   }
  }

```

## 文件夹操作 ##
文件夹操作可用于提取一定格式数据，用于分析。
### 提取隔夜利息 ###
``` c++
#property copyright "shiyingpan"
#property link      "https://aijy.github.io"
#property version   "1.00"
#property strict
/* ------------------------------------------------------------------+
本例统计平台的货币对隔夜利息
//+-----------------------------------------------------------------*/
string forex_name[29]={"EURUSD","AUDUSD","GBPUSD","NZDUSD","USDJPY","USDCAD",
                      "USDCHF","EURGBP","EURJPY","EURCHF","EURCAD","EURAUD","EURNZD","AUDCHF","AUDJPY","AUDNZD","AUDCAD","CADCHF",
                      "CADJPY","GBPCAD","CHFJPY","GBPAUD","GBPNZD","GBPJPY","NZDCAD","NZDJPY","NZDCHF","GBPCHF","XAUUSD"};
string forex_data_name[58],file_name="隔夜利息.csv";
string first_line="forex_name",second_line="LONG",third_line="SHORT";
double swaplong[29],swapshort[29];

void OnStart()
  {
//---
   for(int i=0;i<29;i++)
   {
      first_line=first_line+","+forex_name[i];
   }
   
   for(int i=0;i<29;i++)
   {
      swaplong[i]=MarketInfo(forex_name[i],MODE_SWAPLONG);
      swapshort[i]=MarketInfo(forex_name[i],MODE_SWAPSHORT);
      second_line=second_line+","+DoubleToStr(swaplong[i],2); 
      third_line=third_line+","+DoubleToStr(swapshort[i],2);  
   }
   
   
   
   int handle=FileOpen(file_name,FILE_CSV|FILE_WRITE|FILE_ANSI,',');
   if(handle>0)
   {
      FileSeek(handle,0,SEEK_CUR);
      FileWrite(handle,first_line);
      FileWrite(handle,second_line);
      FileWrite(handle,third_line);         
   }
   
   FileClose(handle);
      
  }

```
### 提取实时点差 ###
``` c++
#property copyright "shiyingpan"
#property link      "https://aijy.github.io"
#property version   "1.00"
#property strict
#property indicator_chart_window

string forex_file_name;
int handle;
int spread1;
int k=0;
int flag=0;
string spread_write;
int count=0;
int start_count=0;
int OnInit()
  {
//--- indicator buffers mapping

//---
   return(INIT_SUCCEEDED);
  }
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
   if(flag==0 && DayOfWeek()==2)
     {
      forex_file_name=Symbol()+"_SPREAD.csv";
      spread_write=TimeToStr(TimeCurrent());
      start_count=1;
      flag=1;
      handle=FileOpen(forex_file_name,FILE_CSV|FILE_WRITE,';');

     }

   if(start_count==1)
     {
      RefreshRates();
      spread1=MarketInfo(Symbol(),MODE_SPREAD);
      spread_write=spread_write+";"+spread1;
      count++;
      //         Print("count:",count);

      if(count==400)
        {

         if(handle>0)
           {
            FileSeek(handle,0,SEEK_CUR);
            FileWriteString(handle,spread_write+"\r\n");
           }

         k=k+1;
         spread_write=TimeToStr(TimeCurrent());
         count=0;
         if(k%1000==0)
            Print("k:",k);
        }
      if(k==300)
        {
         FileClose(handle);
         start_count=0;
         Alert("data is full,time:",TimeCurrent());
        }
     }
//--- return value of prev_calculated for next call
   return(rates_total);
  }

```

## 编写马丁EA ##
马丁策略是一种资金管理方式，它的基本原理基于金字塔式的加仓方式。在订单被套的时候，不断同方向间隔加仓，摊薄成本。只要行情回撤，就可以让被套的系列订单解套。
[https://www.jianshu.com/p/4ab42f1f761e](https://www.jianshu.com/p/4ab42f1f761e "转载于")
### 马丁策略优点 ###
1. 马丁策略的原理简单。只要死扛，资金量足够大，马丁在理论上不会爆仓。而市场行情总是在不同时间周期内来回切换摆动，一个回撤就可以解放所有的被套订单。

2. 马丁策略的回撤是可计算的。马丁的加仓与回撤，在等间距、加仓倍数恒定的情况下，是可以事先计算出来的。这意味着马丁策略从数学意义上讲，是可以测算的。

3. 马丁在程序化上代码编写的难度要小。相对于其它策略，马丁策略的代码编写难度要小。在外汇EA编写人才缺乏的现状下，受到各方开发者的青睐。

4. 好的马丁策略，对付震荡型行情可以通杀完胜。马丁怕单边，爱震荡。在可测算的震荡型行情里，马丁策略可以达到大小通吃的完美结果，这对于自动化交易者来说，极具魅力。

### 代码实现 ###
为方便理解，本次代码分为多头马丁和空头马丁，多头马丁只会下买单，而空头马丁只会下空单。
多头马丁：
``` c++
#property copyright "aijy.github.io"
#property link      "https://aijy.github.io"
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

```
空头马丁：
``` c++
#property copyright "aijy.github.io"
#property link      "https://aijy.github.io"
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

int MagicNumber=654321;
double PriceTarget,StartEquity,BuyTarget,SellTarget;
double AveragePrice,SellLimit,BuyLimit;
double LastBuyPrice,LastSellPrice,ClosePrice,Spread;

string EAName="SELL";
datetime timeprev=0,expiration;
int NumOfTrades=0;
double iLots;
int cnt=0,total;
double Stopper=0;
bool TradeNow=false,LongTrade=false,ShortTrade=false;

bool NewOrdersPlaced=false;
int init()
  {
   Spread=MarketInfo(Symbol(),MODE_SPREAD)*Point;
   return(0);
  }
int deinit()
  {
   return(0);
  }
void OnTick()
  {
//---------开仓条件
   bool sell_trade=false;
   if(iClose(Symbol(),PERIOD_M1,2)>iClose(Symbol(),PERIOD_M1,1))
      sell_trade=true;
//------------------------
//---获取平均的开仓价格---
//------------------------
   int ticket;
   total=CountTrades();
   
   if(total>=3)
   {
      int total_profit=CalculateTotalProfit();
      if(total_profit>0)
      {
      
      }
   }
   
   
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
         if(OrderType()==OP_SELL)
           {
            PriceTarget=AveragePrice-TakeProfit*Point;
            if(Ask<PriceTarget)
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
     { 
     //当资金损失低于风险值，不再开仓
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
                 {
                 Print("Error: ",GetLastError());
                  return;
                 }
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
         if(sell_trade==true)//如果第二个K线收盘价大于第一根K线收盘价，下空单（首次下单的判定条件）
           {
            iLots=fGetLots(OP_SELL);
            if(iLots>0)
              {//#
               ticket=OpenPendingOrder(OP_SELL,iLots,SellLimit,slip,SellLimit,0,0,EAName+"-"+NumOfTrades,MagicNumber,0,HotPink);
               if(ticket<0)
                 {
                  Print(iLots,"Error: ",GetLastError());
                  return;
                 }
               LastBuyPrice=FindLastBuyPrice();
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
//|                                                                  |
//+------------------------------------------------------------------+
double CalculateTotalProfit()
  {
   double Profit=0;
   for(cnt=OrdersTotal()-1;cnt>=0;cnt--)
     {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES) && OrderMagicNumber()==MagicNumber)
        {
         Profit=Profit+OrderProfit();
        }
     }
   return(Profit);
  }

```

### 马丁策略的改良方法 ###
马丁策略在单边行情越大时风险越大。下面，我们简单探讨一下马丁的风险控制。

1. 在加仓间距上进行控制，使用较大的加仓可减小风险，过大的加仓间距可能迟迟不能盈利出场，这点比较难把控。

2. 在加仓倍数上进行控制，使用较小的加仓倍数，策略会更稳健。

3. 马丁也可以结合止盈止损，该止损的时候不能犹豫，如果真的触碰了止损线，就要反思参数设置的合理性了。

4. 可以改变马丁加仓的位置，加仓的位置可以是K线有回调的时候才加。

## EA的风险控制 ##
EA风险控制是重中之重。

### 净值风险控制 ###
``` c++
#property copyright "shiyingpan"
#property link      "https://aijy.github.io"
#property version   "1.0"
#property strict

enum mybool
{
   是=1,
   否=0,
};

input mybool 是否手动输入净值=否; 
input double 手动输入初始资金=0;
input double 净值风险率=15;        //--- 净值亏损15%时，强平出场
input double 盈利提示一=5;         //--- 净值盈利到5%时，提示关注
input double 盈利提示二=10;        //--- 净值盈利到10%时，强平出场
input double 亏损提示一=5;         //--- 净值亏损到5%时，提示关注
input double 亏损提示二=10;        //--- 净值亏损到10%时，抢平出场
double 初始资金=0;

int flag[4]={0,0,0,0}; //--- 净值浮动状态

int OnInit()
  {
   while(AccountNumber()==0)
      Sleep(10000);
//   初始资金=AccountEquity();   
   if(是否手动输入净值==否)
       初始资金=AccountBalance();
   else
       初始资金=手动输入初始资金;    
   if(初始资金==0)
   {
      Alert("当前账户无资金！");
      return(INIT_FAILED);
   }
   if(AccountEquity()<初始资金*(100-净值风险率)/100)
   {
      Alert("当前净值亏损超过净值风险率，无法加载！");
      return(INIT_FAILED);  
   }
   
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
 
  }
void OnTick()
  {
   if(AccountEquity()<初始资金*(100-净值风险率)/100)
   {
      Alert("资金亏损超过"+DoubleToString(净值风险率,1)+"%,全部平仓。亏损：",DoubleToStr(AccountEquity()-初始资金,2)," 净值：",AccountEquity());
      SendMail("资金亏损超过"+DoubleToString(净值风险率,1)+"%,全部平仓。亏损："+DoubleToStr(AccountEquity()-初始资金,2)+" 净值："+DoubleToStr(AccountEquity()),"");
      flag[1]=1;flag[2]=1;
      close_chart(); //改Return 为close_chart();
      close_all();
      Sleep(5000);
   }   
   if(AccountEquity()<初始资金*(100-亏损提示一)/100 && flag[1]==0) 
   {
      Alert("资金亏损超过"+DoubleToString(亏损提示一,1)+"%,亏损：",DoubleToStr(AccountEquity()-初始资金,2)," 净值：",AccountEquity());
      SendMail("资金亏损超过"+DoubleToString(亏损提示一,1)+"%,亏损："+DoubleToStr(AccountEquity()-初始资金,2)+" 净值："+DoubleToStr(AccountEquity()),"");
      flag[1]=1;
      return;   
   }  
   if(AccountEquity()<初始资金*(100-亏损提示二)/100 && flag[2]==0) 
   {
      Alert("资金亏损超过"+DoubleToString(亏损提示二,1)+"%,亏损：",DoubleToStr(AccountEquity()-初始资金,2)," 净值：",AccountEquity());
      SendMail("资金亏损超过"+DoubleToString(亏损提示二,1)+"%,亏损："+DoubleToStr(AccountEquity()-初始资金,2)+" 净值："+DoubleToStr(AccountEquity()),"");
      flag[2]=1;
      close_chart();
      close_all();
      ExpertRemove();
      Sleep(100000);
      return;
   }       
   if(AccountEquity()>初始资金*(100+盈利提示一)/100 && flag[3]==0) 
   {
      Alert("资金盈利超过"+DoubleToString(盈利提示一,1)+"%,盈利：",DoubleToStr(AccountEquity()-初始资金,2)," 净值：",AccountEquity());
      SendMail("资金盈利超过"+DoubleToString(盈利提示一,1)+"%,盈利："+DoubleToStr(AccountEquity()-初始资金,2)+" 净值："+DoubleToStr(AccountEquity()),"");
      flag[3]=1;
      return;
   } 
   
   if(AccountEquity()>初始资金*(100+盈利提示二)/100 && flag[4]==0) 
   {
      Alert("资金盈利超过"+DoubleToString(盈利提示二,1)+"%,盈利：",DoubleToStr(AccountEquity()-初始资金,2)," 净值：",AccountEquity());
      SendMail("资金盈利超过"+DoubleToString(盈利提示二,1)+"%,盈利："+DoubleToStr(AccountEquity()-初始资金,2)+" 净值："+DoubleToStr(AccountEquity()),"");
      flag[4]=1;
      close_chart();
      close_all();
      ExpertRemove();
      Sleep(100000);
      return;
   } 
   Sleep(500);   
   
  }

void close_all() //--- 平掉所有仓位
{
   int ticket[200],cnt=0;
   for(int i=0;i<=OrdersTotal()-1;i++)
   {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
      {
         ticket[cnt]=OrderTicket();
         cnt++;
      }   
   }
   for(int i=0;i<=cnt-1;i++)
   {
      if(OrderSelect(ticket[i],SELECT_BY_TICKET,MODE_TRADES))
      {
         if(OrderType()==OP_BUY)
            if(!OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_BID),3,clrRed))
               OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_BID),3,clrRed);
         if(OrderType()==OP_SELL)
            if(!OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_ASK),3,clrRed))
               OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_ASK),3,clrRed);  
         if(OrderType()==OP_BUYLIMIT || OrderType()==OP_SELLLIMIT || OrderType()==OP_BUYSTOP || OrderType()==OP_SELLSTOP)  
            if(!OrderDelete(OrderTicket(),clrRed))
               OrderDelete(OrderTicket(),clrRed);           
      }   
   }

}

void close_chart()  //--- 关闭所有图表和EA
{
   long chart_total[100];
   long currChart,prevChart=ChartFirst(); 
   chart_total[0]=prevChart;
   int i=0,limit=100; 

   while(i<limit)// We have certainly not more than 100 open charts 
     { 
      currChart=ChartNext(prevChart); // Get the new chart ID by using the previous chart ID 
      if(currChart<0) break;          // Have reached the end of the chart list 
      prevChart=currChart;// let's save the current chart ID for the ChartNext() 
      i=i+1;// Do not forget to increase the counter 
      chart_total[i]=prevChart;
      Print(i,chart_total[i]);      
     }

   for(int j=0;j<=i;j++)
      if(chart_total[j]!=ChartID())
         ChartClose(chart_total[j]);
}


```
### 单量风险控制 ###
``` c++
#property copyright "shiyingpan"
#property link      "https://aijy.github.io"
#property version   "1.00"
#property strict

input double 万美金最大单量=2;     //--- 一万美金可下几首单量，按比例缩减
bool new_orders=true;
double max_lots=0;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
   while(AccountNumber()==0)
      Sleep(10000);
   max_lots=AccountEquity()/10000*万美金最大单量;
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {

   double total_lots=0;
   for(int i=OrdersTotal()-1;i>=0;i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         total_lots=total_lots+OrderLots();
        }
     }

   if(total_lots>max_lots)
     {
      new_orders=false;
     }

   if(new_orders==true)
     {
      Print("当前单量未超最大单量，允许下单");
     }
  }

```


