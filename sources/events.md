
#Events
AgenaTrader is an *event-oriented* application by definition.

Programming in AgenaTrader using the various application programming interface (*API*) methods is based initially on the *Overwriting* of routines predefined for event handling.

The following methods can be used and therefore overwritten:

-   [*OnCalculate()*](#oncalculate)
-   [*OnBrokerConnect()*](#onbrokerconnect)
-   [*OnBrokerDisconnect()*](#onbrokerdisconnect)
-   [*OnChartPanelMouseMove()*](#onchartpanelmousemove)
-   [*OnChartPanelMouseDown()*](#onchartpanelmousedown)
-   [*OnOrderExecution()*](#onorderexecution)
-   [*OnLevel1()*](#onlevel1)
-   [*OnLevel2()*](#onlevel2)
-   [*OnOrderChanged()*](#onorderupdate)
-   [*OnStart()*](#onstartop)
-   [*OnDispose()*](#ondispose)

## OnCalculate()
### Description
The OnCalculate() method is called up whenever a bar changes; depending on the variables of [*CalculateOnClosedBar*](#CalculateOnClosedBar), this will happen upon every incoming tick or when the bar has completed/closed.
OnCalculate is the most important method and also, in most cases, contains the largest chunk of code for your self-created indicators or strategies.
The editing begins with the oldest bar and goes up to the newest bar within the chart. The oldest bar has the number 0. The indexing and numbering will continue to happen; in order to obtain the numbering of the bars you can use the current bar variable. You can see an example illustrating this below.

**Caution:**
**the numbering/indexing is different from the bar index – see [*Bars*](#Bars).**

More information can be found here: [*Events*](#events).

### Parameter
none

### Return Value
none

### Usage
```cs
protected override void OnCalculate()
```

### Example
```cs
protected override void OnCalculate()
{
    Print("Calling of OnCalculate for the bar number " + ProcessingBarIndex + " from " +Time[0]);
}
```
## OnBrokerConnect()
### Description
OnBrokerConnect() method is invoked each time the connection to the broker is established.  With the help of OnBrokerConnect(), it is possible to reassign the existing or still open orders to the strategy in the event of a connection abort with the broker and thus allow it to be managed again.

More information can be found here: [*Events*](#events).

### Parameter
none

### Return Value
none

### Usage
```cs
protected override void OnBrokerConnect()
```

### Example
```cs
private IOrder _takeProfit = null;
private IOrder _trailingStop = null;


protected override void OnBrokerConnect()
{
   if (Trade != null && Trade.PositionType != PositionType.Flat)
   {
       _takeProfit = Orders.FirstOrDefault(o => o.Name == this.GetType().Name && o.OrderType ==OrderType.Limit);
       _trailingStop = Orders.FirstOrDefault(o => o.Name == this.GetType().Name && o.OrderType ==OrderType.Stop);
   }
}

```

## OnBrokerDisconnect()
### Description
OnBrokerDisconnect() method is invoked each time the connection to the broker is interrupted.

More information can be found here: [*Events*](#events).

### Parameter
An object from *TradingDatafeedChangedEventArgs*

### Return Value
none

### Usage
```cs
protected override void OnBrokerDisconnect(TradingDatafeedChangedEventArgs e)
```

### Example
```cs
protected override void OnBrokerDisconnect(TradingDatafeedChangedEventArgs e)
{
   if (e.Connected)
       Print("The connection to the broker will be disconnected.");
   else
       Print("The connection to the broker was disconnected.");
}
```


## OnChartPanelMouseMove()
### Description
In an indicator, or strategy, the current position of the mouse can be evaluated and processed. For this, it is necessary to program an EventHandler as a method and add this method to the Chart.ChartPanelMouseMove event.

### Attention!
It is important to remove the EventHandler from the OnDispose() method, otherwise the EventHandler will still be executed even if the indicator has been removed from the chart.

### Example
```cs
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Linq;
using System.Xml;
using System.Xml.Serialization;
using AgenaTrader.API;
using AgenaTrader.Custom;
using AgenaTrader.Plugins;
using AgenaTrader.Helper;


namespace AgenaTrader.UserCode
{
    public class ChartPanelMouseMove : UserIndicator
    {
        protected override void OnInit()
        {
            IsOverlay = true;
        }

        protected override void OnStart()
        {
            // Add event listener
            if (Chart != null)
                Chart.ChartPanelMouseMove += OnChartPanelMouseMove;
        }

        protected override void OnDispose()
        {
            // Remove event listener
            if (Chart != null)
                Chart.ChartPanelMouseMove -= OnChartPanelMouseMove;
        }

        private void OnChartPanelMouseMove(object sender, System.Windows.Forms.MouseEventArgs e)
        {
            Print("X = {0}, Y = {1}", Chart.GetDateTimeByX(e.X), Chart.GetPriceByY(e.Y));
        }
    }
}
```

## OnChartPanelMouseDown()
### Description
In an indicator, or strategy, the click event of the mouse can be processed. For this, it is necessary to program an EventHandler as a method and add this method to the Chart.ChartPanelMouseDown event.

### Attention!
It is important to remove the EventHandler from the OnDispose() method, otherwise the EventHandler will still be executed even if the indicator has been removed from the chart.

### Example
```cs
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Linq;
using System.Xml;
using System.Xml.Serialization;
using AgenaTrader.API;
using AgenaTrader.Custom;
using AgenaTrader.Plugins;
using AgenaTrader.Helper;


namespace AgenaTrader.UserCode
{
       public class ChartPanelMouseDown : UserIndicator
       {
               protected override void OnInit()
               {
                       IsOverlay = true;
               }

               protected override void OnStart()
               {
                       // Add event listener
                       if (Chart != null)
                               Chart.ChartPanelMouseDown += OnChartPanelMouseDown;
               }


               protected override void OnDispose()
               {
                       // Remove event listener
                       if (Chart != null)
                               Chart.ChartPanelMouseDown -= OnChartPanelMouseDown;
               }


               private void OnChartPanelMouseDown(object sender,System.Windows.Forms.MouseEventArgs e)
               {
                       Print("X = {0}, Y = {1}", Chart.GetDateTimeByX(e.X),Chart.GetPriceByY(e.Y));
               }
       }
}
```

## OnOrderExecution()
### Description
The OnOrderExecution() method is called up when an order is executed (filled).
The status of a strategy can be changed by a strategy-managed order. This status change can be initiated by the changing of a volume, price or the status of the exchange (from “working” to “filled”). It is guaranteed that this method will be called up in the correct order for all events.

OnOrderExecution() will always be executed AFTER [*OnOrderChanged()*](#onorderchanged).

More information can be found here: [*Events*](#events).

### Parameter
An execution object of the type *IExecution*

### Return Value
none

### Usage
```cs
protected override void OnOrderExecution(IExecution execution)
```

### Example
```cs
private IOrder entry = null;
protected override void OnCalculate()
{
	if (CrossAbove(EMA(14), SMA(50), 1) && IsSerieRising(ADX(20)))
        	entry = OpenLong("EMACrossesSMA");
}
protected override void OnOrderExecution(IExecution execution)
{
    // Example
    if (entry != null && execution.Order == entry)
    {
    	Print(execution.Price.ToString());
	Print(execution.Order.OrderState.ToString());
    }
}
```

## OnLevel1()
### Description
The OnLevel1() method is called up when a change in level 1 data has occurred, meaning whenever there is a change in the bid price, ask price, bid volume, or ask volume, and of course in the last price after a real turnover has occurred.
In a multibar indicator, the rocessingBarSeriesIndex property identifies the data series that was used for an information request for OnLevel1().
OnLevel1() will not be called up for historical data.
More information can be found here: [*Events*](#events).

**Notes regarding data from Yahoo (YFeed)**

The field "LastPrice" equals – as usual – either the bid price or the ask price, depending on the last revenue turnover.

The MarketDataType" field always equals the "last" value

The fields "Volume", "BidSize" and "AskSize" are always 0.

### Usage
```cs
protected override void OnLevel1(Level1Args e)
```

### Return Value
none

### Parameter
```cs
[*Level1Args*] e
```


### Example
```cs
protected override void OnLevel1(Level1Args e)
{
    Print("AskPrice "+e.AskPrice);
    Print("AskSize "+e.AskSize);
    Print("BidPrice "+e.BidPrice);
    Print("BidSize "+e.BidSize);
    Print("Instrument "+e.Instrument);
    Print("LastPrice "+e.LastPrice);
    Print("MarketDataType "+e.MarketDataType);
    Print("Price "+e.Price);
    Print("Time "+e.Time);
    Print("Volume "+e.Volume);
}
```

## OnLevel2()
### Description
The OnLevel2() method is called up whenever there is a change in the level 2 data (market depth).
In a multibar indicator, the ProcessingBarSeriesIndex property identifies the data series for which the OnLevel2() method is called up.
OnLevel2 is not called up for historical data.

More information can be found here: [*Events*](#events).

### Usage
```cs
protected override void OnLevel2(Level2Args e)
```

### Return Value
none

### Parameter
An object from *Level2Args*

### Example
```cs
protected override void OnLevel2(Level2Args e)
{
    // Current Bit-Price
    if (e.MarketDataType == MarketDataType.Bit)
    	Print("The current bit is " + e.Price );
}
```

## OnOrderChanged()
### Description
The OnOrderChanged() method is called up whenever the status is changed by a strategy-managed order.
A status change can therefore occur due to a change in the volume, price or status of the exchange (from “working” to “filled”). It is guaranteed that this method will be called up in the correct order for the relevant events.

**Important note:**
**If a strategy is to be controlled by order executions, we highly recommend that you use OnOrderExecution() instead of OnOrderChanged(). Otherwise there may be problems with partial executions.**

More information can be found here: [*Events*](#events).

### Parameter
An order object of the type IOrder

### Return Value
None

### Usage
```cs
protected override void OnOrderChanged(IOrder order)
```

### Example
```cs
private IOrder entry = null;
protected override void OnCalculate()
{
    if (CrossAbove(EMA(14), SMA(50), 1) && IsSerieRising(ADX(20)))
        entry = OpenLong("EMACrossesSMA");

    if (entry != null && entry == order)
    {
        if (order.OrderState == OrderState.Filled)
        {
		PlaySound("OrderFilled.wav");
		entryOrder = null;
        }
    }
}
protected override void OnOrderChanged(IOrder order)
{

}
```

## OnStart()
### Description
The OnStart() method can be overridden to initialize your own variables, perform license checks or call up user forms etc.
OnStart() is only called up once at the beginning of the script, after [*OnInit()*](#oninit) and before [*OnCalculate()*](#oncalculate) are called up.

See [*OnDispose()*](#ondispose).

More information can be found here: [*Events*](#events).

### Parameter
none

### Return Value
none

### Usage
```cs
protected override void OnStart()
```

### Example
```cs
private myForm Window;
protected override void OnStart()
{
    if (Chart != null)
    {
    Window = new myForm();
    Window.Show();
    }
}
```

## OnDispose()
### Description
The OnDispose() method can also be overridden in order to once again free up all the resources used in the script.

See [*OnInit()*](#oninit) and [*OnStart()*](#onstart).

More information can be found here: [*Events*](#events).

### Parameter
none

### Return Value
none

### Usage
```cs
protected override void OnDispose()
```

### More Information
**Caution:**
**Please do not override the Dispose() method since this can only be used much later within the script. This would lead to resources being used and held for an extended period and thus potentially causing unexpected consequences for the entire application.**

### Example
```cs
protected override void OnDispose()
{
    if (Window != null)
    {
        Window.Dispose();
        Window = null;
    }
}
```
