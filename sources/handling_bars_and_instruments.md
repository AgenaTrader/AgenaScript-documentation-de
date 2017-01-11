#Handling bars and instruments

Data is understood as information that is retrieved externally and uploaded to AgenaTrader, or as data series that are created by AgenaScripts.

Further detailed information can be found using the appropriate shortcuts:

[Bars (Candles)](#bars-candles)

[Data series](#data-series)

[Instruments](#instruments)

##Bars (Candles)
### Functionality
A classical indicator calculates one or multiple values using an existing data series.

Data series can be anything from closing prices to daily lows or values of an hourly period etc.

Every period (meaning all candles of one day, one hour etc.) is assigned one or more indicator values.
The following example is based on an indicator value, such as with a moving average, for example.
To calculate a smoothed moving average, AgenaTrader needs a data series. In this example we will use the closing prices. All closing prices of a bar (candle) that are represented in the chart will be saved in a list and indexed.

The current closing price, meaning the closing price of the bar that is on the right-hand side of the chart, will be assigned an index of 0. The bar to the left of that will have an index of 1 and so on. The oldest bar displayed will have an index value of 500.

Whenever a new bar is added within a session it will become the new index 0; the bar to the left of it, which previously had an index of 0, will become index 1 and so on. The oldest bar will become index 501.
Within a script (a self-created program/algorithm) the [*Close*](#close) will be representative for the array (list) of all closing prices.
The last closing price is thus *Close \[0\]*; the closing price previous to this will become *Close \[1\]*, the value before that will become *Close \[2\]* and the oldest bar will be *Close \[501\]*. The number within the squared brackets represents the index. AgenaTrader allows you to use the „bars ago" expression for this in general cases.

Obviously, every bar will not only have a closing value but also a [*High*](#high), [*Low*](#low), [*Open*](#open), [*Median*](#median), [*Typical*](#typical), [*Weighted*](#weighted), [*Time*](#time) and [*Volume*](#volume). Thus, the high of the candle that occurred 10 days ago will be *High \[10\]*, yesterday’s low *Low \[1\]*...

**Important tip:**

The previous examples all assume that the calculations will occur at the end of a period. The value of the currently running index is not being taken into consideration.

If you wish to use the values of the currently forming candle then you will need to set the value of

[*CalculateOnClosedBar*](#CalculateOnClosedBar) to „false".

In this case the currently running bar will have the value 0, the bar next to the current bar will have the value 1 and so on. The oldest bar (as in the example above) would now have the value 502.

With close \[0\] you would receive the most recent value of the last price that your data provider transmitted to AgenaTrader. All values of the bar (high \[0\], low \[0\]…) may still change as long as the bar is not yet finished/closed and a new bar has not yet started. Only the open \[0\] value will not change.

## Properties of Bars
### Properties of Bars
"Bars" represents a list of all bars (candles) within a chart (see [*Functionality*](#functionality)(#functionality)[*Bars*](#bars)).

Bars (**public** IBars Bars) can be used directly in a script and equates to BarsArray \[0\] (see Bars.GetNextSessionTimeSpan for more information).

The list of bars itself has many properties that can be used in AgenaScript. Properties are always indicated by a dot before the objects (in this case bars, list of candles).

[*BarsCountForSession*](#barscountforsession)

[*Bars.Count*](#barscount)

[*Bars.IsFirstBarInSession*](#barsfirstbarinsession)

[*Bars.GetBar*](#barsgetbar)

[*Bars.GetBarsAgo*](#barsgetbarsago)

[*Bars.GetByIndex*](#barsgetbyindex)

[*Bars.GetBarIndex*](#barsgetbarindex)

[*Bars.GetNextSessionTimeSpan*](#getnextsessiontimespan)

[*Bars.GetSessionBegin*](#getsessionbegin)

[*Bars.GetOpen*](barsgetopen)

[*Bars.GetHigh*](#barsgethigh)

[*Bars.GetLow*](#barsgetlow)

[*Bars.GetClose*](#barsgetclose)

[*Bars.GetTime*](#barsgettime)

[*Bars.GetVolume*](#barsgetvolume)

[*Bars.Instrument*](#barsinstrument)

[*Bars.IsEod*](#barsiseod)

[*Bars.IsIntraday*](#barsisintraday)

[*Bars.IsNtb*](#barsisntb)

[*Bars.LastBarCompleteness*](#barslastbarcompleteness)

[*Bars.CurrentSessionBeginTime*](#currentsessionbegintime)

[*Bars.SessionBreak*](#barssessionbreak)

[*Bars.CurrentSessionEndTime*](#currentsessionendtime)

[*Bars.NextSessionBeginTime*](#nextsessionbegintime)

[*Bars.NextSessionEndTime*](#nextsessionendtime)

[*Bars.TicksCountForLastBar*](#tickscountforlastbar)

[*Bars.TimeFrame*](#barstimeframe)

[*Bars.TicksCountInTotal*](#barstickscountintotal)

[*Bars.IsGrowing*](#barsisgrowing)

[*Bars.IsFalling*](#barsisfalling)

[*Bars.TailTop*](#barstailtop)

[*Bars.TailBottom*](#barstailbottom)

[*IsProcessingBarIndexLast*](#isprocessingbarindexlast)

With the **OnCalculate()** method you can use any properties you want without having to test for a null reference.
As soon as the function **OnCalculate()** is called up by AgenaScript, it is assumed that an object is also available. If you wish to use these properties outside of **OnCalculate()** then you should first perform a test for null references using **if** (Bars != **null**).

## BarsCountForSession
### Description
Bars.BarsCountForSession outputs the amount of bars that have occurred since the beginning of the current trading session.

See further [*Properties*](#properties) of bars.

### Return Value
Type int Amount of Bars

A value of -1 indicates a problem with referencing the correct session beginning.

### Usage
Bars.BarsCountForSession

### Further Information
Within *OnCalculate()* this property can be used without having to test for a null reference. As soon as the OnCalculate() method is called up by AgenaScript, the object will become available.

If this property is used outside of OnCalculate() then you should test for a null reference before executing it. You can test using *if* (Bars!= *null*) .

### Example
```cs
Print ("Since the start of the last trading session there have been" + Bars.BarsCountForSession + "bars.");
```

## Bars.Count
### Description
Bars.Count gives you the amount of bars in a data series.

See [*Properties*](#properties) for additional information.

### Return Value
Type int Amount of Bars

### Usage
Bars.Count

### More Information
The value of *ProcessingBarIndex* can only be lesser than or equal to Bars.Count - 1

When you specify how many bars are to be loaded within AgenaTrader, then the value of Bars.Count is equal to this setting. In the following example, Bars.Count would give back a value of 500.

![Bars.Count](./media/image1.png)

### Example
```cs
Print ("There are a total of" + Bars.Count + "bars available.");
```

## Bars.IsFirstBarInSession
### Description
With Bars.IsFirstBarInSession you can determine whether the current bar is the first bar of the trading session.

See [*Properties*](#properties) of bars for more information.

### Return Value
Type bool

**true**: The bar is the first bar of the current trading session
**false**: The bar is not the first bar of the current trading session

### Usage
Bars.IsFirstBarInSession

### More Information
With *OnCalculate()* this property can be used without having to test for a null reference. As soon as the OnCalculate() method is called up, an object will become available.
If this property is called up outside of OnCalculate() you should test for a null reference using if (Bars != null).

### Example
```cs
if (Bars.IsFirstBarInSession)
Print ("The current trading session started at" + Time [0]);
```

## Bars.GetBar
### Description
Bars.GetBar outputs the first bars (from oldest to newest) that correspond to the specified date/time.

See [*Bars.GetBarsAgo*](#barsgetbarsago), [*Bars.GetByIndex*](#barsgetbyindex), [*Bars.GetBarIndex*](#barsgetbarindex).

### Parameter
Type DateTime

### Return Value
Type IBar Bar Object, for the bars corresponding to the timestamp

For a timestamp older than the oldest bar: 0 (null)
For a timestamp younger than the newest bar: index of the last bar

### Usage
```cs
Bars.GetBar(DateTime time)
```

### More Information
For the indexing of bars please see [*Functionality*](#functionality), [*Bars*](#bars)

For more information about using DateTime see [http://msdn.microsoft.com/de-de/library/system.datetime.aspx](http://msdn.microsoft.com/de-de/library/system.datetime.aspx)

### Example
```cs
Print ("The closing price for 01.03.2012 at 18:00:00 was " + Bars.GetBar(new DateTime(2012, 01, 03, 18, 0, 0)).Close);
```

## Bars.GetBarsAgo
### Description
Bars.GetBarsAgo outputs the index of the first bars (from oldest to newest) that correspond to the specified date/time.

See: [*Bars.GetBar*](#barsgetbar), [*Bars.GetByIndex*](#barsgetbyindex), [*Bars.GetBarIndex*](#barsgetbarindex).

### Parameter
Type DateTime

### Return Value
Type int Index of the bar that corresponds to the timestamp

With a timestamp older than the oldest bar: 0 (null)
With a timestamp newer than the youngest bar: index of the last bar

### Usage
```cs
Bars.GetBarsAgo(DateTime time)
```

### More Information
For more information about indexing please see [*Functionality*](#functionality), [*Bars*](#bars)

For more information about using DateTime see [http://msdn.microsoft.com/de-de/library/system.datetime.aspx](http://msdn.microsoft.com/de-de/library/system.datetime.aspx)

### Example
```cs
Print("The bar for 01.03.2012 at 18:00:00 O’clock has an index of " + Bars.GetBarsAgo(new DateTime(2012, 01, 03, 18, 0, 0)));
```

## Bars.GetClose
Bars.GetClose(int index) – see [*Bars.GetOpen*](barsgetopen).

## Bars.GetHigh
Bars.GetHigh(int index) – see [*Bars.GetOpen*](barsgetopen).

## Bars.GetByIndex
### Description
Bars.GetByIndex outputs the index for the specified bar object

See [*Bars.GetBar*](#barsgetbar)(#barsgetbar), [*Bars.GetBarsAgo*](#barsgetbarsago)(#barsgetbarsago), [*Bars.GetBarIndex*](#barsgetbarindex)(#barsgetindex).

### Parameter
Type int Index

### Return Value
Type IBar Bar object for the specified index

### Usage
```cs
Bars.GetByIndex (int Index)
```

### More Information
For indexing of bars see [*Functionality*](#functionality), [*Bars*](#bars)

### Example
```cs
Print(Close[0] + " and " + Bars.GetByIndex(ProcessingBarIndex).Close + " are equal in this example.");
```

## Bars.GetBarIndex
### Description
Bars.GetBarIndex outputs the index of a bar – you can input either a bar object or a date-time object using this method.

See [*Bars.GetBar*](#barsgetbar)(#barsgetbar), [*Bars.GetBarsAgo*](#barsgetbarsago)(#barsgetbarsago), [*Bars.GetByIndex*](#barsgetbyindex)(#barsgetbyindex).

### Parameter
Type IBar bar
or
Type DateTime

### Return Value
Type int The bar index of the specified bar object or DateTime object

### Usage
```cs
Bars.GetBarIndex (IBar bar)
Bars.GetBarIndex (DateTime dt)
```

### More Information
For more information about indexing see [*Functionality*](#functionality), [*Bars*](#bars)

### Example
```cs
int barsAgo = 5;
IBar bar = Bars.GetBar(Time[barsAgo]);
Print(barsAgo + " and " + Bars.GetBarIndex(bar) + " are equal in this example.");
```

## Bars.GetLow
Bars.GetLow(int index) – see [*Bars.GetOpen*](barsgetopen).

## Bars.GetNextSessionTimeSpan
### Description
Bars.GetNextSessionTimeSpan outputs the date and time for the beginning and end of a trading session.

See [*Bars.CurrentSessionBeginTime*](#barssessionbegin), [*Bars.CurrentSessionEndTime*](#barssessionend), [*Bars.NextSessionBeginTime*](#barssessionnextbegin), [*Bars.NextSessionEndTime*](#barssessionnextend).

### Parameter
|          |         |                                                                                            |
|----------|---------|--------------------------------------------------------------------------------------------|
| DateTime | time    | Date or time for which the data of the following trading session will be scanned/searched. |
| iBars    | bars    | Bar object for which the data will be scanned/searched.                                    |
| int      | barsago | Number of days in the past for which the data will be searched/scanned.                    |

### Return Value
DateTime session begin
DateTime session end

**Note:**
The date for the beginning and the end of a trading session are connected components. If the specified date corresponds to the end date of the current trading session then the returned value for the beginning of a trading session may already be in the past. In this case the date for the following trading session cannot be returned.

### Usage
```cs
Bars.GetNextSessionTimeSpan(Bars bars, int barsAgo, out DateTime sessionBegin, out DateTime sessionEnd)
Bars.GetNextSessionTimeSpan(DateTime time, out DateTime sessionBegin, out DateTime sessionEnd)
```

### More Information
The two signatures will not necessarily output the same result.
When using the bar signature, the supplied bar will be inspected for its session template association. The beginning and end of the next session will be taken from this template.

When using the time signature, the date and time of the supplied bar will be used to calculate the data for the current and the following sessions.

When using the time signature, a timestamp is transmitted that corresponds exactly to the beginning or the end time of a session.

More information can be found here [*http://msdn.microsoft.com/de-de/library/system.datetime.aspx*](http://msdn.microsoft.com/de-de/library/system.datetime.aspx)

### Example
```cs
DateTime sessionBegin;
DateTime sessionEnd;
protected override void OnCalculate()
{
Bars.GetNextSessionTimeSpan(Bars, 0, out sessionBegin, out sessionEnd);
Print("Session Start: " + sessionBegin + " Session End: " + sessionEnd);
}
```

## Bars.GetSessionBegin
### Description
Bars.GetSessionBegin provides the date and time of the particular session start. The date and time for the start of the current trading session are also correctly indicated when the function is called from a bar in the past. See also other [*Properties*](#properties) of bars.

### Parameter
None

### Return value
Type DateTime

### Usage
Bars.GetSessionBegin(DateTime dt)

### Further Information
The time of the returned value corresponds to the start time of the trading session.  The relevant trading center which is specified in the MarketEscort. The trading place used for the value is set in the Instrumet Escort and can be determined in AgenaSript with the Instrument.Exchange function.

![Bars.CurrentSessionBeginTime](./media/image3.png)
### Example
```cs
Print("Die Handelssitzung am 25.03.2015 hat um "+ Bars.GetSessionBegin(new DateTime(2015, 03, 25)) + " begonnen.");
}
```
## Bars.GetOpen
### Description
For reasons of compatibility, the following methods are available.

-   Bars.GetOpen(int index) outputs the open for the bars referenced with &lt;index&gt;.
-   Bars.GetHigh(int index) outputs the high for the bars referenced with &lt;index&gt;.
-   Bars.GetLow(int index) outputs the low for the bars referenced with &lt;index&gt;.
-   Bars.GetClose(int index) outputs the close for the bars referenced with &lt;index&gt;.
-   Bars.GetTime(int index) outputs the timestamp for the bars referenced with &lt;index&gt;.
-   Bars.GetVolume(int index) outputs the volume for the bars referenced with &lt;index&gt;.

**Caution**: The indexing will deviate from the [*Indexing*](#indexing), [*Bars*](#bars) normally used.
Here, the indexing will begin with 0 for the oldest bar (on the left of the chart) and end with the newest bar on the right of the chart (=Bars.Count-1).

The indexing can easily be recalculated:
```cs
private int Convert(int idx)
{
return Math.Max(0,Bars.Count-idx-1-(CalculateOnClosedBar?1:0));
}
```

### Parameter
int index (0 .. Bars.Count-1)

### Return Value
Type double for GetOpen, GetHigh, GetLow, GetClose and GetVolume

Type DateTime for GetTime

## Bars.GetTime
Bars.GetTime(int index) – see [*Bars.GetOpen*](barsgetopen).

## Bars.GetVolume
Bars.GetVolume(int index) – see [*Bars.GetOpen*](barsgetopen).

## Bars.Instrument
### Description
Bars.Instrument outputs an instrument object for the trading instrument displayed within the chart.

See [*Properties*](#properties) for more information.

### Parameter
None

### Return Value
Type Instrument

### Usage
Bars.Instrument

### More Information
For more information regarding the trading instruments please see [*Instrument*](#instrument).

### Example
```cs
// both outputs will provide the same result
Print("The currently displayed trading instrument has the symbol: " + Bars.Instrument);
Instrument i = Bars.Instrument;
Print("The currently displayed trading instrument has the symbol " + i.Symbol);
```
## Bars.IsEod
### Description
Bars.IsEod can be used to check whether they are end-of-day bars.

See [*Properties*](#properties) for more information.

### Parameter
None

### Return Value
Type bool

### Usage
Bars.IsEod

### More Information
Within [*OnCalculate()*](#oncalculate), this property can be used without having to test for null reference. As soon as the method OnCalculate () is called by AgenaScript, there is always a bar object.

If this property  used outside of OnCalculate (), then a corresponding test should be set to zero reference, e.g. With if (bars! = Null).

### Example
```cs
Print("The bars are EOD: " + Bars.IsEod);
```
## Bars.IsIntraday
### Description
Bars.IsIntraday returns a boolean which indicates if the TimeFrame is intra-day.

### Return Value
**bool**

It returns "true" if TimeFrame is intra-day (e.g. 1 min, 15 min, 1 hour, etc.) and "false" in other cases.

### Usage
```cs
Bars.IsIntraday
```

### Example
```cs
if(Bars.IsIntraday) {
	Print("TimeFrame is Intraday.");
} else {
	Print("TimeFrame is not Intraday.");
}
```
## Bars.IsNtb
### Description
With Bars.IsNtb it can be checked whether it is not-time-based bars. For example Ntb bars are Point & Figure or Renko Charts.

See [*Properties*](#properties) for more information.

### Parameter
None

### Return Value
Type bool

### Usage
Bars.IsNtb

### More Information
[*OnCalculate()*](#oncalculate) property can be used without having to test for null reference first. As soon as the method OnCalculate() is called by AgenaScript, there is always a bar object. If this property is used outside of OnCalculate(), then a corresponding test should be set to zero reference, e.g. With if (bars! = Null).
### Example
```cs
Print("The bars are Ntb: " + Bars.IsNtb);
```


## Bars.LastBarCompleteness
### Description
Bars.LastBarCompleteness outputs the value that displays what percentage a bar has already completed. A bar with a period of 10 minutes has completed 50% after 5 minutes.

For non-time-based charts (Kagi, LineBreak, Renko, Range, P&F etc.) this will output 0 during backtesting.

### Return Value
**double**

A percentage value; 30% will be outputted as 0.3

### Usage
Bars.LastBarCompleteness

### More Information
With [*OnCalculate()*](#oncalculate) this property can be used without having to test for a null reference. As soon as the OnCalculate() method is called up by AgenaScript, the object will become available.

If this property is used outside of OnCalculate() you should test for a null reference before executing it. You can test using *if* (Bars != *null*)

### Example
```cs
// A 60 minute chart is looked at from an intraday perspective
// every 5 minutes before the current bar closes
// an acoustic signal shall be played
// 55 min. equals 92%
bool remind = false;
protected override void OnCalculate()
{
if (FirstTickOfBar) remind = true;
if (remind && Bars.LastBarCompleteness >= 0.92)
{
remind = false;
PlaySound("Alert1");
}
}
```

## Bars.CurrentSessionBeginTime
### Description
Bars.CurrentSessionBeginTime outputs the date and time for the beginning of the current trading session.

Date and time for the beginning of the current trading session will be displayed correctly when the function is used on a bar that has occurred in the past.

### Parameter
None

### Return Value
Type DateTime

### Usage
Bars.GetSessionBegin

### More Information
The time for the returned value will equal the starting time defined in the Market Escort for the specified exchange. The value itself is set within the Instrument Escort and can be called up in AgenaScript using the function [*Instrument.Exchange*](#instrumentexchange) .

![Bars.CurrentSessionBeginTime](./media/image3.png)

### Example
```cs
Print("The currently running trading session started at " + Bars.CurrentSessionBeginTime );
```

## Bars.IsSessionBreak
### Description
Bars.IsSessionBreak can be used to determine whether the bars are within the commercial trading session in the commercial breaks defined in the marketplace escort.

See [*Properties*](#properties) for more information.

### Parameter
None

### Return Value
Type bool

### Usage
Bars.IsSessionBreak

### More Information
![Bars.CurrentSessionEndTime](./media/image4.png)
### Example
```cs
if (Bars.IsSessionBreak)
{
Print("The stock exchange Xetra has just a trade pause");
}
```

## Bars.CurrentSessionEndTime
### Description
Bars.CurrentSessionEndTime outputs the time for the end of the currently running trading session.
Date and time for the end of the current trading session will, in this case, also be outputted correctly when the function is used on a previous bar.

### Parameter
None

### Return Value
Type DateTime

### Usage
Bars.GetSessionEnd

### More Information
The time for the returned value will correlate with the end time of the trading session defined in the Market Escort for the exchange. The value itself can be set within the Instrument Escort and can be called up with AgenaScript using the [*Instrument.Exchange*](#instrumentexchange) function.

![Bars.CurrentSessionEndTime](./media/image4.png)

### Example
```cs
Print("The current trading session will end at " + Bars.CurrentSessionEndTime);
```

## Bars.NextSessionBeginTime
### Description
Bars.NextSessionBeginTime outputs the date and time for the start of the next trading session.
Date and time for the next session will be correctly outputted when the function is used on a bar in the past.

### Parameter
None

### Return Value
Type DateTime

### Usage
Bars.GetSessionNextBegin

### More Information
The time for the returned value will correlate to the value displayed in the MarketEscort. The value can be set within the Instrument Escort and can be called up using the [*Instrument.Exchange*](#instrumentexchange) function.

![Bars.NextSessionBeginTime](./media/image3.png)

### Example
```cs
Print("The next trading session starts at " + Bars.NextSessionBeginTime);
```

## Bars.NextSessionEndTime
### Description
Bars.NextSessionEndTime outputs the date and time for the end of the next session.
See [*Properties*](#properties) for more information.

### Parameter
None

### Return Value
Type DateTime

### Usage
Bars.GetSessionNextEnd

### More Information
The time for the returned value will correlate with the value specified within the MarketEscort. The value itself can be set within the Instrument Escort and can be called up with AgenaScript using the [*Instrument.Exchange*](#instrumentexchange) function.

![Bars.NextSessionEndTime](./media/image4.png)

### Example
```cs
Print("The next trading session ends at " + Bars.NextSessionEndTime);
```

## Bars.TicksCountForLastBar
### Description
Bars.TicksCountForLastBar outputs the total numbers of ticks contained within a bar.

More information can be found in [*Properties*](#properties) of bars.

### Parameter
None

### Return Value
Type int

### Usage
Bars.TicksCountForLastBar

### More Information
With [*OnCalculate()*](#oncalculate) this property can be used without having to test for a null reference. As soon as the OnCalculate() method is called up by AgenaScript, the object will become available.

If this property is used outside of OnCalculate(), you should test for a null reference before executing it. You can test using *if* (Bars != *null*)

### Example
```cs
Print("The current bar consists of " + Bars.TicksCountForLastBar + " Ticks.");
```

## Bars.TimeFrame
### Description
Bars.TimeFrame outputs the timeframe object containing information regarding the currently used timeframe.

More information can be found here: [*Properties*](#properties)

### Parameter
None

### Return Value
Type ITimeFrame

### Usage
Bars.TimeFrame

### More Information
For more information about timeframe objects please see [*TimeFrame*](#timeframe).

With [*OnCalculate()*](#oncalculate) this property can be used without having to test for a null reference. As soon as the OnCalculate() method is called up by AgenaScript, the object will become available.

If this property is used outside of OnCalculate(),you should test for a null reference before executing it. You can test using *if* (Bars != *null*)

### Example
```cs
//Usage within a 30 minute chart
TimeFrame tf = (TimeFrame) Bars.TimeFrame;
Print(Bars.TimeFrame); // outputs "30 Min"
Print(tf.Periodicity); // outputs "Minute"
Print(tf.PeriodicityValue); // outputs "30"
```

## Bars.TicksCountInTotal
### Description
Bars.TicksCountInTotal outputs the total number of ticks from the moment the function is called up.

More information can be found here: [*Properties*](#properties).

### Parameter
None

### Return Value
Type int

### Usage
Bars.TicksCountInTotal

### More Information
The data type int has a positive value range of 2147483647. When you assume 10 ticks per second, there will be no overlaps within 2 trading months with a daily runtime of 24 hours.

With [*OnCalculate()*](#oncalculate) this property can be used without having to test for a null reference. As soon as the OnCalculate() method is called up by AgenaScript, the object will become available.

If this property is used outside of OnCalculate(), you should test for a null reference before executing it. You can test using *if* (Bars != *null*)

## Bars.isGrowing
### Description
Bar properties used when Bar is growing up.

### Parameter
None

### Return Value
None

### Usage
```cs
Bars[0].isGrowing;
```

## Bars.IsFalling
### Description
Bar properties used when Bar is falling down.

### Parameter
None

### Return Value
None

### Usage
```cs
Bars[0].IsFalling;
```

## Bars.TailTop
### Description
Bar properties used for candle tail top height

### Parameter
None

### Return Value
None

### Usage
```cs
Bars[0].TailTop;
```

## Bars.TailBottom
### Description
Bar properties used for candle tail bottom height
### Parameter
None

### Return Value
None

### Usage
```cs
//Usage within a 30 minute chart
Bars[0].TailBottom;
```


### Example
**Print**("The total amount of ticks is " + Bars.TicksCountInTotal);

## ProcessingBarSeriesIndex
### Description
Indicates if current bar is last in calculation.

### Parameter
none

### Return value
Type bool

### Usage
ProcessingBarSeriesIndex

### More Information
used for complicated calculation on a last bar

### Example
```cs
protected override void OnCalculate()
        {
            base.OnCalculate();
            if (!IsProcessingBarIndexLast)
                return;
            bool isUpdated;
}
```


## Data Series
### Description
Data series are interpreted as freely usable data storage containers for your programs. Additionally, they an integrated component of AgenaTrader that saves the price changes for individual bars. We will be focusing on the latter function here.
In the following section, the concept of data series will be explained in detail and understandably. All price data for the individual bars are organized and saved within data series.
The following are available:

[*Open*](#open) [*Opens*](#opens)

[*High*](#high) [*Highs*](#highs)

[*Low*](#low)(#low) [*Lows*](#lows)

[*Close*](#close) [*Closes*](#closes)

[*Median*](#median) [*Medians*](#medians)

[*Typical*](#typical)(#Typical) [*Typicals*](#typicals)

[*Weighted*](#weighted)(#weighted) [*Weighteds*](#weighteds)

[*Time*](#time) [*Times*](#times)

[*TimeFrame*](#timeframe) [*TimeFrames*](#timeframes)

[*Volume*](#volume) [*Volumes*](#volumes)

## Open
### Description
Open is a [*DataSeries*](#dataseries) of the type [*DataSeries*](#dataseries), in which the historical opening prices are saved.

### Parameter
BarsAgo Index Value (see [*Bars*](#bars))

### Usage
```cs
Open
Open[int barsAgo]
```

### More Information
The returned value is dependent upon the property of [*CalculateOnClosedBar*](#calculateonclosebar).

### Example
```cs
// Opening price for the current period
Print(Time[0] + " " + Open[0]);
// Opening price for the bars of 5 periods ago
Print(Time[5] + " " + Open[5]);
// Current value for the SMA 14 that is based on the opening prices (rounded)
Print("SMA(14) calculated using the opening prices: " + Instrument.Round2TickSize(SMA(Open, 14)[0]));
```

## Opens
### Description
Opens is an array of data series that contains all open data series.

This array is only useful or meaningful for indicators or strategies that use multiple data from multiple timeframes.
A new entry is entered into the array whenever a new timeframe is added to an indicator or strategy.

With **\[TimeFrameRequirements(("1 Day"), ("1 Week"))\]** the array will contain 3 entries:

Opens\[0\] The open data series of the chart timeframe
Opens\[1\] The open data series of all bars in a daily timeframe
Opens\[2\] The open data series of all bars in a weekly timeframe

Opens\[0\]\[0\] is equivalent to Open\[0\].

In addition, please see [*MultiBars*](#multibars) for more information.

### Parameter
barsAgo Index value for the individual bars within the data series (see [*Bars*](#bars))
barSeriesIndex Index value for the various timeframes

### Usage
```cs
Opens[int barSeriesIndex]
Opens[int barSeriesIndex][int barsAgo]
```

### More Information
The returned value is dependent upon the property of [*CalculateOnClosedBar*](#calculateonclosebar).

### Example
See example: [*Multibars*](#multibars).

## High
### Description
High is a [*DataSeries*](#dataseries) of the type [*DataSeries*](#dataseries), in which the historical high prices are saved.

### Parameter
barsAgo IndexValue (see [*Bars*](#bars))

### Usage
```cs
High
High[int barsAgo]
```

### More Information
The returned value is dependent upon the property of [*CalculateOnClosedBar*](#calculateonclosebar).

### Example
```cs
// High values of the current period
Print(Time[0] + " " + High[0]);
// High values of the bar from 5 periods ago
Print(Time[5] + " " + High[5]);
// the current value for the SMA 14 calculated on the basis of the high prices
Print("SMA(14) Calculated using the high prices: " + Instrument.Round2TickSize(SMA(High, 14)[0]));
```

## Highs
### Description
Highs is an array of \[*DataSeries*\]\[1\] that contains all high data series.

This array is only of value for indicators or strategies that use data from multiple timeframes.

A new entry is added to the array whenever a new time unit is added to an indicator or strategy.

With **\[TimeFrameRequirements(("1 Day"), ("1 Week"))\]** the array will contain 3 entries:

Highs\[0\] the high data series of the chart timeframe
Highs\[1\] the high data series of all bars in a daily timeframe
Highs\[2\] the high data series of all bars in a weekly timeframe

Highs\[0\]\[0\] is equivalent to High\[0\].

See [*MultiBars*](#multibars).

### Parameter
barsAgo Index value for the individual bars within the data series (see [*Bars*](#bars))
barSeriesIndex Index value for the various timeframes

### Usage
```cs
Highs[int barSeriesIndex]
Highs[int barSeriesIndex][int barsAgo]
```

### More Information
The returned value is dependent upon the property of [*CalculateOnClosedBar*](#calculateonclosebar).

### Example
Please see examples under [*Multibars*](#multibars).

## Low
### Description
Low is a [*DataSeries*](#dataseries) of the type [*DataSeries*](#dataseries), in which the historical low prices are saved.

### Parameter
barsAgo IndexValue (see [*Bars*](#bars))

### Usage
```cs
Low
Low[int barsAgo]
```

### More Information
The returned value is dependent upon the property of [*CalculateOnClosedBar*](#calculateonclosebar).

### Example
```cs
// Lowest value of the current period
Print(Time[0] + " " + Low[0]);
// Lowest value of the bar from 5 periods ago
Print(Time[5] + " " + Low[5]);
// The current value for the SMA 14 calculated on the basis of the low prices (smoothed)
Print("SMA(14) calculated using the high prices: " + Instrument.Round2TickSize(SMA(Low, 14)[0]));
```

## Lows
### Description
Lows is an array of \[*DataSeries*\]\[1\] that contains all [*Low*](#low) data series.

This array is only of value to indicators or strategies that use data from multiple time units.

A new entry is added whenever a new time unit is added to an indicator or strategy.

With **\[TimeFrameRequirements(("1 Day"), ("1 Week"))\]** the array will contain 3 entries:

Lows\[0\] the low data series for the chart timeframe
Lows\[1\] the low data series for all bars in a daily timeframe
Lows\[2\] the low data series for all bars in a weekly timeframe

Lows\[0\]\[0\] is equivalent to Low\[0\].

See [*MultiBars*](#multibars).

### Parameter
barsAgo Index value for the individual bars within the data series
barSeriesIndex Index value for the various timeframes

### Usage
```cs
Lows[int barSeriesIndex]
Lows[int barSeriesIndex][int barsAgo]
```

### More Information
The returned value is dependent upon the property [*CalculateOnClosedBar*](#calculateonclosebar).

### Example
See example [*Multibars*](#multibars).

## Close
### Description
Close is a [*DataSeries*](#dataseries) of the type [*DataSeries*](#dataseries), in which the historical closing prices are saved.

### Parameter
barsAgo Index value (see [*Bars*](#bars))

### Usage
```cs
Close
Close[int barsAgo]
```

### More Information
The returned value is dependent upon the property [*CalculateOnClosedBar*](#calculateonclosebar).

Indicators are usually calculated using the closing prices.

### Example
```cs
// Closing price of the current period
Print(Time[0] + " " + Close[0]);
// Closing price of the bar from 5 periods ago
Print(Time[5] + " " + Close[5]);
// Current value for the SMA 14 based on the closing prices
Print("SMA(14) calculated using the closing prices: " + Instrument.Round2TickSize(SMA(Close, 14)[0]));
// Close does not need to be mentioned since it is used by default
Print("SMA(14) calculated using the closing prices: " + Instrument.Round2TickSize(SMA(14)[0]));
```

## Closes
### Description
Closes is an array of \[*DataSeries*\]\[1\] that contains all [*Low*](#low) data series.

This array is only of importance to indicators or strategies that use data from multiple time units.

A new entry is added to the array whenever a timeframe is added to an indicator or strategy.

With **\[TimeFrameRequirements(("1 Day"), ("1 Week"))\]** the array will contain 3 entries:

Closes\[0\] the close data series of the chart timeframe
Closes\[1\] the close data series of all bars in a daily timeframe
Closes\[2\] the close data series of all bars in a weekly timeframe

Closes\[0\]\[0\] is equivalent to Close\[0\].

See [*MultiBars*](#multibars).

### Parameter
barsAgo Index value of the individual bars within the data series
barSeriesIndex Index value for the various timeframes

### Usage
```cs
Closes[int barSeriesIndex]
Closes[int barSeriesIndex][int barsAgo]
```

### More Information
The returned value is dependent upon the property [*CalculateOnClosedBar*](#calculateonclosebar).

### Example
See example [*Multibars*](#multibars).

## Median
### Description
Median is a [*DataSeries*](#dataseries) of the type [*DataSeries*](#dataseries), in which the historical median values are saved.

The median price of a bar is calculated using (high + low) / 2

See [*Typical*](#typical) & [*Weighted*](#weighted).

### Parameter
barsAgo Index value (see [*Bars*](#bars))

### Usage
```cs
Median
Median[int barsAgo]
```

### More Information
The returned value is dependent upon the property [*CalculateOnClosedBar*](#calculateonclosebar).

Further information about median, typical und weighted:
[*http://blog.nobletrading.com/2009/12/median-price-typical-price-weighted.html*](http://blog.nobletrading.com/2009/12/median-price-typical-price-weighted.html)

### Example
```cs
// Median price for the current period
Print(Time[0] + " " + Median[0]);
// Median price of the bar from 5 periods ago
Print(Time[5] + " " + Median[5]);
// Current value for the SMA 14 calculated using the median prices
Print("SMA(14) calculated using the median prices: " + Instrument.Round2TickSize(SMA(Median, 14)[0]));
```

## Medians
### Description
Medians is an array of \[*DataSeries*\]\[1\] that contains all [*Median*](#median) data series.

This array is only of value to indicators or strategies that use data from multiple timeframes.

A new entry is added to the array whenever a new time frame is added to an indicator or strategy.

With **\[TimeFrameRequirements(("1 Day"), ("1 Week"))\]** the array will contain 3 entries:

Medians\[0\] the median data series of the chart timeframe
Medians\[1\] the median data series of all bars in a daily timeframe
Medians\[2\] the median data series of all bars in a weekly timeframe

Medians\[0\]\[0\] is equivalent to Medians\[0\].

See [*MultiBars*](#multibars).

### Parameter
barsAgo Index value for the individual bars within a data series
barSeriesIndex Index value for the various timeframes

### Usage
```cs
Medians[int barSeriesIndex]
Medians[int barSeriesIndex][int barsAgo]
```

### More Information
The returned value is dependent upon the property [*CalculateOnClosedBar*](#calculateonclosebar).

Further information on median: [http://www.investopedia.com/terms/m/median.asp](http://www.investopedia.com/terms/m/median.asp)

### Example
See example in [*Multibars*](#multibars).

## Typical
### Description
Typical is a [*DataSeries*](#dataseries) of the type [*DataSeries*](#dataseries), in which the historical typical values are saved.

The typical price of a bar is calculated using (high + low + close) / 3.

See [*Median*](#median) and [*Weighted*](#weighted).

### Parameter
barsAgo Index value (see [*Bars*](#bars))

### Usage
```cs
Typical
Typical[int barsAgo]
```

### More Information
The returned value is dependent upon the property [*CalculateOnClosedBar*](#calculateonclosebar).

Further information on typical: [*https://technicianapp.com/resources/typical-price/*](https://technicianapp.com/resources/typical-price/)

### Example
```cs
// Typical price for the current period
Print(Time[0] + " " + Typical[0]);
// Typical price of the bar from 5 periods ago
Print(Time[5] + " " + Typical[5]);
// Current value for the SMA 14 calculated using the typical price
Print("SMA(14) calculated using the typical price: " + Instrument.Round2TickSize(SMA(Typical, 14)[0]));
```

## Typicals
### Description
Typicals is an array of *DataSeries* that contains all [*Typical*](#typical) data series.

This array is only of value to indicators and strategies that make use of multiple timeframes.

A new entry is added to the array whenever a new timeframe is added to an indicator or strategy.

With **\[TimeFrameRequirements(("1 Day"), ("1 Week"))\]** the array will contain 3 entries:

Typicals\[0\] the typical data series of the chart timeframe
Typicals\[1\] the typical data series of all bars in a daily timeframe
Typicals\[2\] the typical data series of all bars in a weekly timeframe

Typicals\[0\]\[0\] is equivalent to Typicals\[0\].

See [*MultiBars*](#multibars).

### Parameter
barsAgo Index value of the individual bars within a data series
barSeriesIndex Index value of the various timeframes

### Usage
```cs
Typicals[int barSeriesIndex]
Typicals[int barSeriesIndex][int barsAgo]
```

### More Information
The returned value is dependent upon the property [*CalculateOnClosedBar*](#calculateonclosebar).

### Example
See example [*Multibars*](#multibars).

## Weighted
### Description
Weighted is a [*DataSeries*](#dataseries) of the type [*DataSeries*](#dataseries), in which the historical weighted values are saved.

The weighted price of a bar is calculated using the formula (high + low + 2*close) / 4 and then weighted on the closing price.

See also [*Median*](#median) and [*Typical*](#typical).

### Parameter
barsAgo Index value (see [*Bars*](#bars))

### Usage
## Weighted
```cs
Weighted[int barsAgo]
```

### More Information
The returned value is dependent upon the property [*CalculateOnClosedBar*](#calculateonclosebar).

Information regarding weighted: [*http://www.stock-trading-infocentre.com/pivot-points.html*](http://www.stock-trading-infocentre.com/pivot-points.html)

### Example
```cs
// Weighted price for the current period
Print(Time[0] + " " + Weighted[0]);
// Weighted price of the bar from 5 periods ago
Print(Time[5] + " " + Weighted[5]);
// Current value for the SMA 14 using the weighted price
Print("SMA(14) calculated using the weighted price: " + Instrument.Round2TickSize(SMA(Weighted, 14)[0]));
```

## Weighteds
### Description
Weighteds is an array of \[*DataSeries*\]\[1\] that contains all [*Weighted*](#weighted) data series.

The array is only of value for indicators and strategies that use data from multiple timeframes.

A new entry is added to the array whenever a new timeframe is added to an indicator or strategy.

With **\[TimeFrameRequirements(("1 Day"), ("1 Week"))\]** the array will contain 3 entries:

Weighteds\[0\] the weighted data series of the chart timeframe
Weighteds\[1\] the weighted data series of all bars in a daily timeframe
Weighteds\[2\] the weighted data series of all bars in a weekly timeframe

Weighteds\[0\]\[0\] is equivalent to Weighteds\[0\].

See [*MultiBars*](#multibars).

### Parameter
barsAgo Index value of the individual bars within a data series
barSeriesIndex Index value for the various timeframes

### Usage
```cs
Weighteds[int barSeriesIndex]
Weighteds[int barSeriesIndex][int barsAgo]
```

### More Information
The returned value is dependent upon the property [*CalculateOnClosedBar*](#calculateonclosebar).

### Example
See example under [*Multibars*](#multibars).

## Time
### Description
Time is a [*DataSeries*](#dataseries) of the type [*DateTimeSeries*](#datatimeseries), in which the timestamps of the individual bars are saved.

### Parameter
barsAgo Index value (see [*Bars*](#bars))

### Usage
```cs
Time
Time[int barsAgo]
```

### More Information
The returned value is dependent upon the property [*CalculateOnClosedBar*](#calculateonclosebar).

### Example
```cs
// Timestamp of the current period
Print(Time[0]);
// Timestamp of the bar from 5 periods ago
Print(Time[5]);
```

## Times
### Description
Times is an array of [*DataSeries*](#dataseries) that contains all [*Time*](#time) data series.

This array is only of value to indicators and strategies that make use of multiple timeframes.
A new entry is added to the array whenever a new timeframe is added to an indicator or strategy.

With **\[TimeFrameRequirements(("1 Day"), ("1 Week"))\]** the array will contain 3 entries:

Times\[0\] the time data series of the chart timeframe
Times\[1\] the time data series of all bars in a daily timeframe
Times\[2\] the time data series of all bars in a weekly timeframe

Times\[0\]\[0\] is equivalent to Times\[0\].

See [*MultiBars*](#multibars).

### Parameter
barsAgo Index value for the individual bars within a data series
barSeriesIndex Index value for the various timeframes

### Usage
```cs
Times[int barSeriesIndex]
Times[int barSeriesIndex][int barsAgo]
```

### More Information
The returned value is dependent upon the property [*CalculateOnClosedBar*](#calculateonclosebar).

### Example
See example [*Multibars*](#multibars).

## Volume
### Description
Volume is a [*DataSeries*](#dataseries) of the type [*DataSeries*](#dataseries), in which the historical volume information is saved.

### Parameter
barsAgo Index value (see [*Bars*](#bars))

### Usage
Volume

Volume\[**int** barsAgo\]

### More Information
The returned value is dependent upon the property [*CalculateOnClosedBar*](#calculateonclosebar).

The value returned by the [*VOL()*](#vol) indicator is identical with the volume described here;
for example, Vol()\[3\] will have the same value as Volume\[3\].

### Example
```cs
// Volume for the current period
Print(Time[0] + " " + Volume[0]);
// Volume of the bar from 5 periods ago
Print(Time[5] + " " + Volume[5]);
// Current value for the SMA 14 calculated using the volume
Print("SMA(14) calculated using the volume: " + Instrument.Round2TickSize(SMA(Volume, 14)[0]));
```

## Volumes
### Description
Volumes is an array of [*DataSeries*](#dataseries) that contains all [*Volume*](#volume) data series.

This array is only of value for indicators or strategies that use data from multiple timeframes.

A new entry is added to the array whenever a new timeframe is added to an indicator or strategy.

With **\[TimeFrameRequirements(("1 Day"), ("1 Week"))\]** the array will contain 3 entries:

Volumes\[0\] the volume data series of the chart timeframe
Volumes\[1\] the volume data series of all bars in the daily timeframe
Volumes\[2\] the volume data series of all bars in the weekly timeframe

Volumes\[0\]\[0\] is equivalent to Volumes\[0\].

See [*MultiBars*](#multibars).

### Parameter
barsAgo Index value of the individual bars within a data series

barSeriesIndex Index value of the various timeframes

### Usage
```cs
Volumes[int barSeriesIndex]
Volumes[int barSeriesIndex][int barsAgo]
```

### More Information
The returned value is dependent upon the property [*CalculateOnClosedBar*](#calculateonclosebar).

### Example
See example [*Multibars*](#multibars).

## TimeFrame
### Description
TimeFrame is a timeframe object.

### Usage
```cs
TimeFrame
```

## TimeFrames
### Beschreibung
TimeFrames ist ein Array von TimeFrame-Objekten, welches für jedes Bar-Objekt ein separates TimeFrame-Objekt  enthält.

Dieses Array ist nur in Indikatoren bzw. Strategien von Bedeutung, die Daten aus mehreren Zeiteinheiten verarbeiten.

Ein neuer Eintrag wird dem Array immer dann hinzugefügt, wenn dem Indikator bzw. der Strategie eine neue Zeiteinheit hinzugefügt wird.

Mit **\[TimeFrameRequirements(("1 Day"), ("1 Week"))\]** enthält das Array 3 Einträge:

TimeFrames \[0\] TimeFrame der primären Datenserie (Chart-Zeiteinheit)
TimeFrames \[1\] **Print**(TimeFrames\[1\]);  // liefert "1 Day"
TimeFrames \[2\] **Print**(TimeFrames\[2\]); // liefert "1 Week"

TimeFrames \[0\] entspricht [*TimeFrame*](#timeframe).

Siehe auch [*MultiBars*](#multibars).

### Parameter
barSeriesIndex Indexwert der unterschiedlichen Zeiteinheiten

### Verwendung
```cs
TimeFrames [int barSeriesIndex]
```

### Beispiel
```cs
if (ProcessingBarSeriesIndex == 0 && ProcessingBarIndex == 0)
for (int i = BarsArray.Count-1; i >= 0; i--)
Print("The Indicator " + this.Name + " uses Bars of the Timeframe " + TimeFrames[i]);
```

##Instruments
"Instrument" bezeichnet einen handelbaren Wert, wie z.B. eine Aktie, einen ETF, einen Future, einen CFD usw.

Ein Instrument hat viele Eigenschaften, die in einem selbst erstellten AgenaScript verwendet werden können.

[*Instrument.Compare*](#instrumentcompare)

[*Instrument.Currency*](#instrumentcurrency)

[*Instrument.Digits*](#instrumentdigits)

[*Instrument.ETF*](#instrumentetf)

[*Instrument.Exchange*](#instrumentexchange)

[*Instrument.Expiry*](#instrumentexpiry)

[*Instrument.GetCurrencyFactor*](#instrumentgetcurrencyfactor)

[*Instrument.InstrumentType*](#instrumentinstrumenttype)

[*Instrument.MainSector*](#instrumentmainsector)

[*Instrument.Margin*](#instrumentmargin)

[*Instrument.Name*](#instrumentname)

[*Instrument.PointValue*](#instrumentpointvalue)

[*Instrument.Round2TickSize*](#instrumentround2ticksize)

[*Instrument.Symbol*](#instrumentsymbol)

[*Instrument.TickSize*](#instrumentticksize)

Innerhalb von  **OnCalculate()** können diese Eigenschaften verwendet werden, ohne vorher auf Null-Reference testen zu müssen. 
Sobald die Funktion  **OnCalculate()**  von AgenaScript aufgerufen wird, ist immer auch ein Instrument-Objekt vorhanden. Falls diese Eigenschafte ausserhalb von **OnCalculate()**, verwendet werden, sollte vorher ein entsprechender Test auf Null-Reference z.B. mit **if** (Bars != **null**)

## Instrument.Compare
### Beschreibung
Die Funktion Instrument.Compare vergleicht 2 Kursdaten unter Berücksichtigung der richtigen Anzahl Nachkommastellen. Die kleinstmögliche Preisänderung wird durch den Wert TickSize angegeben. Diese Funktion vereinfacht den sonst etwas aufwändigeren Vergleich mit Hilfe von Floating-Point-Operationen.

### Parameter
double value1
double value2

### Rückgabewert
Typ int

 1 - Kurs1 ist größer als Kurs2
-1 - Kurs1 ist kleiner als Kurs2
 0 - Kurs1 und Kurs2 sind gleich

### Verwendung
```cs
Instrument.Compare(double Value1, double Value2)
```

### Weitere Informationen
**Be aware this function compares prices based on TickSize.** If the ticksize of your instrument is 0.01 these prices will be rounded and compared on 2 decimal digits. If you want a regular comparation of two numbers, you should use the operator "greater than" (>) or the operator "smaller than" (<).

More infomation about [math.round()](https://msdn.microsoft.com/en-us//library/75ks3aby(v=vs.110).aspx)

Wenn TickSize z.B. 0,00001 ist, wie bei FX-Werten üblich, dann liefert

Compare(2, 1.99999)	eine 1, d.h. 2 ist größer als 1.99999
Compare(2, 2.000001)	eine 0, d.h. die Kurse sind gleich
Compare(2, 1.999999)	eine 0, d.h. die Kurse sind gleich
Compare(2, 2.00001)	eine -1, d.h. 2 ist kleiner als 2.00001.

### Beispiel
```cs
Print(Instrument.Compare(2, 1.999999));
```

## Instrument.Currency
### Beschreibung
Instrument.Currency liefert ein Currencies-Objekt zurück, das die jeweilige Währung beinhaltet, in der das Instrument gehandelt wird.

### Parameter
keine

### Rückgabewert
eine Konstante vom Typ public enum Currencies

### Verwendung
Instrument.Currency

### Weitere Informationen
Übliche Währungen sind z.B. AUD, CAD, EUR, GBP, JPY oder USD.

### Beispiel
```cs
Print(Instrument.Name + "wird in  " + Instrument.Currency + " gehandelt.);
```

## Instrument.Digits
### Beschreibung
Instrument.Digits liefert die Anzahl der Nachkommastellen, mit denen der Kurs des Instrument notiert wird.

### Parameter
keine

### Rückgabewert
int Digits

### Verwendung
Instrument.Digits

### Weitere Informationen
Aktie werden üblicherweise mit 2 Stellen nach dem Komma gehandelt. Bei Forex sind es je nach Datenanbieter 4 oder 5 Stellen.

Die Funktion findet u.a. Verwendung für das Formatieren von Ausgaben oder zur Rundung von Kursdaten. Siehe auch [*TickSize*](#ticksize) und [*Instrument.Round2Ticks*](instrumentround2ticks), [*Instrument.Round2TickSize*](#instrumentround2ticksize).

Ausführliche Anleitung zum: *Formatieren von Zahlen.*.

### Beispiel
```cs
Print("Der Kurs von  " +Instrument.Name + " wird mit einer Genauigkeit von" + Instrument.Digits +" Nachkommastellen angegeben.");
```

## Instrument.ETF
### Beschreibung
Instrument.ETF dient der Unterscheidung zwischen einer Aktie und einem ETF. Dies ist notwendig, da ETF's von den Börsen auch als "Stock" (dt. Aktie) angesehen werden..

### Parameter
keine

### Rückgabewert
Typ bool

### Verwendung
Instrument.ETF

### Weitere Informationen
Was ist ein ETF?

Wikipedia: [*http://de.wikipedia.org/wiki/Exchange-traded\_fund*](http://de.wikipedia.org/wiki/Exchange-traded_fund*)

### Beispiel
```cs
if (Instrument.InstrumentType == InstrumentType.Stock)
if (Instrument.ETF)
Print("Der Wert ist ein Exchange-traded Fund.");
else
Print("Der Wert ist eine Aktie.");
```

## Instrument.Exchange
### Beschreibung
Instrument.Exchange (Exchange = dt. Börse) liefert die Bezeichnung des Börsenhandelsplatzes für das aktuelle Instrument.

### Parameter
keine

### Rückgabewert
ein Exchange-Objekt vom Typ public enum Exchanges

### Verwendung
Instrument.Exchange

### Weitere Informationen
Übersicht Börsenhandelsplätze: *http://www.boersen-links.de/boersen.htm*

### Beispiel
```cs
Print("Das Instrument " + Instrument.Name +"  wird an der Börse " + Instrument.Exchange + " gehandelt.");
```

## Instrument.Expiry
### Beschreibung
Instrument.Expiry gibt das Datum (Monat und Jahr) des Ablauf eines Finanzinstrumentes an. Nur derivative Handelsinstrumente, wie Optionen oder Futures besitzen ein Ablaufdatum, das sog. Verfallsdatum.

### Parameter
keine

### Rückgabewert
Typ DateTime

Für Instrumente ohne Verfallsdatum wird Instrument.Expiry auf DateTime.MaxValue (= 31.12.9999 23.59:59) gesetzt.

### Verwendung
Instrument.Expiry

### Weitere Informationen
Das Verfallsdatum (Expiry) ist auch im Instrument Escort ersichtlich:

![Instrument.Expiry](./media/image5.png)

### Beispiel
```cs
Print("Das Instrument " + Instrument.Name +" verfällt am " + Instrument.Expiry);
```

## Instrument.GetCurrencyFactor
### Beschreibung
Instrument.GetCurrencyFactor liefert einen Umrechnungsfaktor zurück, mit dessen Hilfe man den Kurs eines Instruments in die Währung des Accounts umrechnen kann.

### Parameter
Typ Currencies

### Rückgabewert
ein double

### Verwendung
Instrument.GetCurrencyFactor(Currencies)

### Weitere Informationen
Übliche Währungen sind z.B. AUD, CAD, EUR, GBP, JPY oder USD.

### Beispiel
```cs
Protected override void OnCalculate()
{
   double currFactor = Instrument.GetCurrencyFactor(Account.Currency);
   Print(Close[0] + " in " + Instrument.Currency.ToString() + " = " + (Close[0] * currFactor) + " in " + Account.Currency.ToString());
}
```

## Instrument.InstrumentType
### Beschreibung
Instrument.InstrumentType liefert ein Typ-Objekt des Handelsinstrumentes.

### Parameter
keine

### Rückgabewert
Objekt vom Typ public enum InstrumentType

### Verwendung
Instrument.InstrumentType

### Weitere Informationen

Mögliche Werte sind: Future, Stock, Index, Currency, Option, CFD und Unknown.
Einen Typ ETF gibt es nicht. ETF's sind vom Typ Stock, siehe[*Instrument.ETF*](#instrumentetf).

Der Instrument-Typ ist auch im Instrument Escort ersichtlich:

![Instrument.InstrumentType](./media/image6.png)

### Beispiel
```cs
Print("Das Instrument  " + Instrument.Name + "  ist vom Typ " + Instrument.InstrumentType);
```
## Instrument.MainSector
### Beschreibung
Instrument.MainSector liefert den Hauptsektor des Handelsinstrumentes zurück.

### Parameter
keine

### Rückgabewert
String

### Verwendung
Instrument.MainSector

### Weitere Informationen
Der  Hauptsektor ist auch im Instrument Escort ersichtlich:
![Instrument.InstrumentType](./media/image6.png)
### Beispiel
```cs
Print("Das Instrument " + Instrument.Name + " ist im Sektor " + Instrument.MainSector + " tätig.");
```

## Instrument.Margin
### Beschreibung
Instrument.Margin liefert die erforderliche Margin des Handelsinstrumentes zurück.

### Parameter
keine

### Rückgabewert
int

### Verwendung
Instrument.Margin

### Weitere Informationen
Margin ist auch im Instrument Escort ersichtlich:
![Instrument.InstrumentType](./media/image6.png)
### Beispiel
```cs
Print("Das Instrument" + Instrument.Name + " hat eine Margin von  " + Instrument.Margin);
```
## Instrument.Name
### Beschreibung
Instrument.Name liefert die Bezeichnung des Handelsinstrumentes.

### Parameter
keine

### Rückgabewert
Typ string

### Verwendung
Instrument.Name

### Weitere Informationen
Der Instrument Name ist auch im Instrument Escort ersichtlich:

![Instrument.Name](./media/image7.png)

### Beispiel
```cs
Print("Das aktuell im Chart geladene Instrument heißt " + Instrument.Name);
```

## Instrument.PointValue
### Beschreibung
Instrument.PointValue liefert den Geldwert für die Bewegung eines Instrumentes von einem vollen Punkt.

### Parameter
keine

### Rückgabewert
Typ double - Punktwert

### Verwendung
Instrument.PointValue

### Weitere Informationen
**Beispiele verschieder Punktwerte**  (je Stück, CDF, Futurekontrakt, Lot usw.)

Aktie: im .allg. 1,00 Euro bzw. 1,00 USD.
EUR/USD: 100,000 USD
Dax-Future:	25,00 Euro

**Tickwert**

Der Tickwert ergibt sich, wenn man den Punktwert mit der TickGröße (TickSize) multipliziert.

z.B. hat der E-mini S&P 500 einen Punktwert von $ 50. Die TickSize beträgt 0,25. Es braucht also eine Bewegung von 4 Ticks für einen vollen Punkt.
Aus 50 * 0,25 = 50 / 4 ergibt sich ein Tickwert von 12,50 $/ je Tick.

Der Punktwert ist auch im Instrument Escort ersichtlich:

![Instrument.PointValue](./media/image8.png)

### Beispiel
```cs
Print("Wenn " + Instrument.Name + " einen vollen Punkt steigt, entspricht dies dem Gegenwert von  " + Instrument.PointValue + " " + Instrument.Currency);
```

## Instrument.Round2TickSize
### Beschreibung
Die Funktion Instrument.Round2TickSize rundet einen übergebenen Kurswert auf den kleinstmöglichen Wert, der durch die Tickgröße (TickSize) des Instrumentes teilbar ist.

### Parameter
double - Kurswert

### Rückgabewert
double

### Verwendung
```cs
Instrument.Round2TickSize(double MarketPrice)
```

### Weitere Informationen
Die Anzahl der Nachkommastellen, auf die gerundet wird, ist je nach Instrument unterschiedlich.
Ist das Instrument eine Aktie, wird auf 2 Nachkommastellen gerundet, bei einem Forex-Wert auf 4 bzw. 5 Nachkommastellen.

Siehe auch  [*TickSize*](#ticksize) und [*Instrument.Digits*](#instrumentdigits).

Beispiele für professionelle  [*Formatting*](#formatting), *Formatting of Numbers*.

### Beispiel
```cs
double Price = 12.3456789;
Print(Price + "  gerundet auf einen für " + Instrument.Name + " gültigen Kurs ist " + Instrument.Round2TickSize(Price));
```

## Instrument.Symbol
### Beschreibung
Instrument.Symbol liefert das Symbol, unter welchem das Handelsinstrument in AgenaTrader eindeutig identifizierbar ist. Anhand des Symbols werden die Mappings zu den verschiedenen Datenanbietern und Brokern verwaltet.

### Parameter
keine

### Rückgabewert
Typ string

### Verwendung
Instrument.Symbol

### Weitere Informationen
Mit dem Symbol werden gleiche Aktion an verschiedenen Börsenplätzen unterschieden. Das Symbol BMW.DE ist z.B. die BMW-Aktie an der Xetra, BMW.CFD ist der CFD auf die BMW-Aktie.

Das Instrument Symbol ist auch im Instrument Escort ersichtlich:

![Instrument.Symbol](./media/image9.png)

### Beispiel
```cs
Print("Das aktuell im Chart geladene Instrument hat das Symbol  " + Instrument.Symbol);
```

## Instrument.TickSize
### Beschreibung
Die Tickgröße oder TickSize ist die kleinste mögliche Einheit um die sich ein Finanzinstrument bewegen kann. Dies ist umgangssprachlich 1 Tick.

### Parameter
keine

### Rückgabewert
double

### Verwendung
Instrument.TickSize oder vereinfacht TickSize

### Weitere Informationen
Das Schlüsselwort [*TickSize*](#ticksize) entspricht Instrument.TickSize. Beide Aufrufe liefern identische Werte und sind gegeneinander austauschbar.

### Beispiele
Aktie:	0,01
ES-Future: 0,25
EUR/USD: 0,00001

Siehe auch [*Instrument.PointValue*](instrumentpointvalue) und [*Instrument.Digits*](#instrumentdigits).

Beispiele für professionelle  [*Formatting*](#formatting), *Formatting of Numbers*.

### Beispiel
```cs
Print("Der Kurs von " + Instrument.Name + "  kann sich minimal um  " + Instrument.TickSize + " Punkt(e) verändern.");
```

## Collections
## ChartDrawings
### Beschreibung
ChartDrawings  ist eine Collection, die alle Zeichenobjekte im Chart enthält. In ChartDrawings werden sowohl dem Chart manuell hinzugefügte Zeichenobjekte, als auch von einem Script gezeichnete Objekte aufgenommen.

Der Index für ChartDrawings ist der eindeutige Name der Zeichenobjekte (string tag).

### Verwendung
ChartDrawings \[string tag\]

### Beispiele
**Hinweis:**  Um die Interface-Definitionen nutzen zu können, muß in den Using-Anweisungen
```cs
using AgenaTrader.Plugins;
// Anzahl der Zeichenobjekte auf dem Chart und deren Tags ausgeben
Print("Auf dem Chart befinden sich  " + ChartDrawings.Count + " Zeichenobjekte");
foreach (IDrawObject draw in ChartDrawings) Print(draw.Tag);
//Eine schwarze Trendlinie zeichnen ...
AddChartLine("MyLine", true, 10, Close[10], 0, Close[0], Color.Black, DashStyle.Solid, 3);
/ ... und die Farbe auf Rot ändern
ITrendLine line = (ITrendLine) ChartDrawings["MyLine"];
if (line != null) line.Pen.Color = Color.Red;
// alle vertikalen Linien in Chart auf Linienstärke 3 setzen,
// und nicht verschiebbar und nicht editierbar machen
foreach (IDrawObject draw in ChartDrawings)
if (draw is IVerticalLine)
{
IVerticalLine vline = (IVerticalLine) draw;
vline.IsLocked = true;
vline.Editable = false;
vline.Pen.Width = 3;
}
```

## InSeries
### Beschreibung
InSeries ist ein  [*DatenSerien*](#datenserien) Objekt, in dem die Eingangsdaten für einen Indikator bzw. eine Strategie enthalten sind.

Wird ein Indikator ohne explizite Angabe von Eingangsdaten aufgerufen, wird immer der Schlusskurs (Close) der aktuell im Chart geladenen Kursdaten verwendet.

Bei einem Aufruf von SMA(20) wird der gl. Durchschnitt auf die Schlusskurse der aktuellen Chart-Kursdaten berechnet (dies entspricht SMA(Close, 20).

InSeries\[0\] = Close\[0\].

Bei dem Aufruf von SMA(High, 20) werden die Höchstkurse der geladenen Daten für die Berechnung des gl. Durchschnitts verwendet.

InSeries\[0\] = High\[0\].

So kann jede beliebige Datenreihe als Input für einen Indikator verwendet werden.

**double** d = **RSI**(**SMA**(20), 14, 3)\[0\]; berechnet beispielsweise den 14-Perioden-RSI über die SMA(20) Werte als Eingangsdatenreihe.
InSeries\[0\] = SMA(20)\[0\].

### Verwendung
```cs
InSeries
InSeries[int barsAgo]
```

### Beispiele
```cs
Print("Die Eingangsdaten für den Indikator sind " + InSeries[0]);
```

## Lines
### Beschreibung
Lines ist eine Collection, die die  [*LevelLine*](#levelline) Objekte eines Indikators enthält.

Wenn einem Indikator mit der [*Add()*](#add) Methode ein Line-Objekt hinzugefügt wird, wird dieses automatisch der Collection Lines hinzugefügt.

Die Reihenfolge der Add-Befehle bestimmt dabei auch die Sortierung in Lines. Der erste Aufruf von Add() erzeugt Lines[0], der nächste Lines[1] usw.

Siehe auch [*Plots*](#plots).

### Verwendung
```cs
Lines[int index]
```

### Beispiele
```cs
// Add "using System.Drawing.Drawing2D;" for DashStyle
protected override void OnInit()
{
Add(new LevelLine(Color.Blue, 70, "Upper")); // gespeichert in Lines[0]
Add(new LevelLine(Color.Blue, 30, "Lower")); // gespeichert in Lines[1]
}
protected override void OnCalculate()
{
// Wenn RSI über 70, Eigenschaften der Linie ändern 
if (RSI(14 ,3) >= 70)
{
Lines[0].Width = 3;
Lines[0].Color = Color.Red;
Lines[0].DashStyle = DashStyle.Dot;
}
else
{
Lines[0].Width = 1;
Lines[0].Color = Color.Blue;
Lines[0].DashStyle = DashStyle.Solid;
}
}
```

## PlotColors
### Beschreibung
PlotColors ist eine Collection, die die ColorSeries aller Plot-Objekte enthält.

Wenn einem Indikator mit der [*Add()*](#add) Methode ein Plot hinzugefügt wird, wird automatisch auch ein ColorSeries-Objekt erzeugt und der Collection PlotColors hinzugefügt.

Die Reihenfolge der Add-Befehle bestimmt dabei auch die Sortierung in PlotColors. Der erste Aufruf von Add() erzeugt PlotColors[0], der nächste PlotColors[1] usw.

### Verwendung
```cs
PlotColors[int PlotIndex][int barsAgo]
```

### Weitere Informationen
Informationen zur Klasse Collection:
[*http://msdn.microsoft.com/en-us/library/ybcx56wz%28v=vs.80%29.aspx*](http://msdn.microsoft.com/en-us/library/ybcx56wz%28v=vs.80%29.aspx)

### Beispiel
```cs
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using AgenaTrader.API;
namespace AgenaTrader.UserCode
{
[Description("PlotColor Demo")]
public class PlotColorsDemo : UserIndicator
{
public DataSeries SMA20 { get {return Outputs[0];} }
public DataSeries SMA50 { get {return Outputs[1];} }
public DataSeries SMA100 { get {return Outputs[2];} }
private Pen pen;
protected override void OnInit()
{
// Linienstärke (Width) auf 4 einstellen
pen = new Pen(Color.Empty, 4);
 // Dem Chart drei Plots mit der def. Linienstärke hinzufügen
Add(new OnPaint(pen, PlotStyle.LevelLine, "SMA20" )); //attached to PlotColors[0]
Add(new OnPaint(pen, PlotStyle.LevelLine, "SMA50" )); //attached to PlotColors[1]
Add(new OnPaint(pen, PlotStyle.LevelLine, "SMA100")); //attached to PlotColors[2]
IsOverlay = true;
}
protected override void OnCalculate()
{
 // Den drei Plots Werte zuweisen
SMA20.Set (SMA(20) [0]);
SMA50.Set (SMA(50) [0]);
SMA100.Set(SMA(100)[0]);
// Farben je nach Kursverlauf ändern
if (IsSerieRising(Close))
{
PlotColors[0][0] = Color.LightGreen;
PlotColors[1][0] = Color.Green;
PlotColors[2][0] = Color.DarkGreen;
}
else if (IsSerieFalling(Close))
{
PlotColors[0][0] = Color.LightSalmon;
PlotColors[1][0] = Color.Red;
PlotColors[2][0] = Color.DarkRed;
}
else
{
PlotColors[0][0] = Color.LightGray;
PlotColors[1][0] = Color.Gray;
PlotColors[2][0] = Color.DarkGray;
}
}
}
}
```

## Plots
### Beschreibung
Plots ist eine Collection, die die Plot-Objekte eines Indikators enthält.

Wenn einem Indikator mit der Add()-Methode ein Plot-Objekt hinzugefügt wird, wird dieses automatisch der Collection Plots hinzugefügt.

Die Reihenfolge der Add-Befehle bestimmt dabei auch die Sortierung in Plots. Der erste Aufruf von Add() erzeugt Plots[0], der nächste Plots[1] usw.

Siehe auch [*Lines*](#lines).

### Verwendung
```cs
Plots[int index]
```

### Beispiele
```cs
protected override void OnInit()
{
Add(new OnPaint(Color.Blue, "MySMA 20")); // saved to Plots[0]
}
protected override void OnCalculate()
{
Value.Set(SMA(20)[0]);
// Wenn Kurs über SMA, Plot grün färben, sonst rot
if (Close[0] > SMA(20)[0])
	Plots[0].PlotColor = Color.Green;
else
	Plots[0].PlotColor = Color.Red;
}
```

## Values
### Beschreibung
Values ist eine Collection, die die DataSeries-Objekte eines Indikators enthält.

Wenn einem Indikator mit der Add()-Methode ein Plot hinzugefügt wird, wird automatisch auch ein Value-Objekt erzeugt und der Collection Values hinzugefügt.

Die Reihenfolge der Add-Befehle bestimmt dabei auch die Sortierung in Values. Der erste Aufruf von Add() erzeugt Values[0], der nächste Values[1] usw.

**Value** ist immer identisch mit Values[0].

### Verwendung
```cs
Outputs[int index]
Outputs[int index][int barsAgo]
```

### Weitere Informationen
Die für eine Collection bekannten Methoden Set(), Reset() und Count() sind auf Value bzw. Values anwendbar.

Informationen zur Klasse Collection:
[*http://msdn.microsoft.com/en-us/library/ybcx56wz%28v=vs.80%29.aspx*](http://msdn.microsoft.com/en-us/library/ybcx56wz%28v=vs.80%29.aspx)

### Beispiel
```cs
// Überpüfung des zweiten Indikatorwertes (d.h. der sekundären DatenSerie)
// von vor einem Bar
// und in Abhängigkeit davon Setzen des aktuellen Indikatorwertes
if (Outputs[1][1] < High[0] - Low[0])
Value.Set(High[0] - Low[0]);
else
Value.Set(High[0] - Close[0]);
```

## Multibars
### Beschreibung
Einem Indikator bzw. eine Strategie liegt immer die gleiche Zeiteinheit zugrunde, wie diejenige, in der der Chart angezeigt wird. Wird z.B. ein SMA(14) in einem 5-Minuten-Chart dargestellt, wird der gleitende Durchschnitt über die 14 letzten 5-Minuten-Bars berechnet. Auf einem Tageschart würden entsprechend die Schlusskurse der letzten 14 Tage zur Berechnung herangezogen werden.

Das gleiche Prinzip gilt für selbst entwickelte Indikatoren. In einem 5-Minuten-Chart würde die Methode [*OnCalculate()*](#oncalculate)  für jeden 5-Minuten-Bar aufgerufen werden.
Mit Multibars ist es außerdem möglich, Daten eines anderen Instrumentes zu laden. 

### Beispiel
```cs
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Linq;
using System.Xml;
using System.Xml.Serialization;
using AgenaTrader.API;
using AgenaTrader.Custom;
using AgenaTrader.Plugins;
using AgenaTrader.Helper;
namespace AgenaTrader.UserCode
{
    [Description("Multibar Demo")]
    // Der Indikator benötigt Tages- und Wochendaten
    [TimeFrameRequirements("1 Day", "1 Week")]
    public class MultiBarDemo : UserIndicator
    {
        private static readonly TimeFrame TF_Day = new TimeFrame(DatafeedHistoryPeriodicity.Day, 1);
        private static readonly TimeFrame TF_Week = new TimeFrame(DatafeedHistoryPeriodicity.Week, 1);

        protected override void OnBarsRequirements()
        {
            Add(TF_Day);
            Add(TF_Week);
        }

        protected override void OnInit()
        {
            CalculateOnClosedBar = true;
        }
        protected override void OnCalculate()
        {
            // aktueller Wert für den SMA 14 auf Tagesbasis
            Print("TF0: " + SMA(Closes[0], 14)[0]);
            // The current value for the SMA 14 in a daily timeframe
            Print("TF1: " + SMA(Closes[1], 14)[0]);
             // aktueller Wert für den SMA 14 auf Wochenbasis
            Print("TF2: " + SMA(Closes[2], 14)[0]);
        }
    }
}
```

### Weitere Hinweise
Bei Verwendung weiterer Zeiteinheiten wird den Arrays [*Opens*](#opens), [*Highs*](#highs), [*Lows*](#lows), [*Closes*](#closes), [*Medians*](#medians), [*Typicals*](#typicals), [*Weighteds*](#weighteds), [*Times*](#times) und [*Volumes*](#volumes)  ein weiterer Eintrag mit den jeweiligen Datenserien der Bars der neuen Zeiteinheit hinzugefügt. Die Indizierung erfolgt in der Reihenfolge des Hinzufügens der Zeiteinheiten.
Closes\[0\]\[0\] entspricht Close\[0\].
Closes\[1\]\[0\] entspricht dem aktuellen Schlusskurs der Tagesdatenreihe.
Closes\[2\]\[0\] entspricht dem aktuellen Schlusskurs der Wochendatenreihe.

"Closes"kann in den Beispielen selbstverständlich auch durch Opens, Highs, Lows usw. ersetzt werden.

Siehe auch [*ProcessingBarIndexes*](#processingbarindexes), [*ProcessingBarSeriesIndex*](#processingbarseriesindex), [*TimeFrames*](#timeframes), [*TimeFrameRequirements*](timeframerequirements).

Es gibt noch eine weitere Schreibweise für Multbars:
```cs
// unter Variablendeklaration wird die Variable TF_Day definiert
private static readonly TimeFrame TF_Day = new TimeFrame(DatafeedHistoryPeriodicity.Day, 1);
private static readonly TimeFrame TF_Week = new TimeFrame(DatafeedHistoryPeriodicity.Week, 1);
// Die folgende Anweisung ist identisch mit double d = Closes[1][0];
double d = MultiBars.GetBarsItem(TF_Day).Close[0];
//  Die folgende Anweisung ist identisch mit double w = Closes[2][0];
double w = MultiBars.GetBarsItem(TF_Week).Close[0];
```

## ProcessingBarIndexes
### Beschreibung
CurrentBars ist ein Array von int-Werten, welches für jedes Bar-Objekt die Nummer von [*ProcessingBarIndex*](#processingbarindex) enthält.

Dieses Array ist nur in Indikatoren bzw. Strategien von Bedeutung, die Daten aus mehreren Zeiteinheiten verarbeiten.

Ein neuer Eintrag wird dem Array immer dann hinzugefügt, wenn dem Indikator bzw. der Strategie eine neue Zeiteinheit hinzugefügt wird.

Mit **\[TimeFrameRequirements(("1 Day"), ("1 Week"))\]** enthält das Array 3 Einträge:

ProcessingBarIndexes\[0\] ProcessingBarIndexes der primären Datenserie (Chart-Zeiteinheit)
ProcessingBarIndexes\[1\] ProcessingBarIndexes für die Tagesbars
ProcessingBarIndexes\[2\] ProcessingBarIndexes für die Wochenbars.

ProcessingBarIndexes\[0\] entspricht [*ProcessingBarIndex*](#processingbarindex).

Siehe auch [*MultiBars*](#multibars).

### Parameter
barSeriesIndex	Indexwert der unterschiedlichen Zeiteinheiten

### Verwendung
```cs
ProcessingBarIndexes[int barSeriesIndex]
```

### Beispiel
```cs
//Sicherstellen, dass mind. 20 Bars geladen sind
for (int i=0; i<ProcessingBarIndexes.Count; i++)
if (ProcessingBarIndexes[i] < 20) return;
```

## ProcessingBarSeriesIndex
### Description
In einem Multibar-Script, d.h. in einem Indikator (bzw. einer Strategie), der mit mehreren Zeiteinheiten arbeitet, sind mehrere Bars-Objekte vorhanden. Die Methode OnCalculate() wird für jeden Bar im Script aufgerufen. Um Ereignisse bestimmter Datenreihen in die Berechnung einzubeziehen bzw. auszublenden ist BarsInProgress zu verwenden.

ProcessingBarSeriesIndex ist nur in Indikatoren bzw. Strategien von Bedeutung, die Daten aus mehreren Zeiteinheiten verarbeiten.
Mit **\[TimeFrameRequirements("1 Day", "1 Week")\]** werden 2 weitere Zeiteinheiten zur primären Chart-Zeiteinheit hinzugefügt.

Wenn OnCalculate() von der primären Datenreihe aufgerufen wird, ist ProcessingBarSeriesIndex=0. Wird OnCalculate() von den Tagesbars aufgerufen, ist ProcessingBarSeriesIndex=1, bei den Wochendaten hat BarsInProgress den Wert 2.

Siehe auch [*Multibars*](#multibars) and [*ProcessingBarIndexes*](#processingbarindexes).

### Parameter
keine

### Verwendung
ProcessingBarSeriesIndex

### Weitere Informationen
In einem Script, welches nur auf der primären Zeiteinheit arbeitet, hat BarsInProgress immer den Wert 0.

### Beispiel
```cs
// Arbeitsweise veranschaulichen
// ggf. CalculateOnBarClose=false setzen
Print(Time[0] + " " + ProcessingBarSeriesIndex);
// Berechnungen nur für die Chart-Zeiteinheit
protected override void OnCalculate()
{
if (ProcessingBarSeriesIndex > 0) return;
// Logik für primäre Datenreihe
}
```
