
# Ereignisse
AgenaTrader ist nach der Definition der Softwaretechnik eine ereignisorientierte Applikation.

Die Programmierung in AgenaTrader mit Methoden des Application Programming Interface (*API*) beruht initial auf dem *Überschreiben* von vordefinierten Routinen zur Ereignisbehandlung.

Folgende Methoden können verwendet, d.h. überschrieben werden:

-   [*OnBrokerConnect()*](#onbrokerconnect)
-   [*OnBrokerDisconnect()*](#onbrokerdisconnect)
-   [*OnCalculate()*](#oncalculate)
-   [*OnChartPanelMouseDown()*](#onchartpanelmousedown)
-   [*OnChartPanelMouseMove()*](#onchartpanelmousemove)
-   [*OnDispose()*](#ondispose)
-   [*OnLevel1()*](#onlevel1)
-   [*OnLevel2()*](#onlevel2)
-   [*OnOrderChanged()*](#onorderupdate)
-   [*OnOrderExecution()*](#onorderexecution)
-   [*OnStart()*](#onstartop)


## OnBrokerConnect()
### Beschreibung
Die Methode OnBrokerConnect() wird jedesmal dann aufgerufen, wenn die Verbindung zum Broker hergestellt wurde.

Mit Hilfe von OnBrokerConnect() besteht die Möglichkeit, bei einem Verbindungsabbruch mit dem Broker, die bestehenden bzw. noch offenen Orders wieder der Strategie zuzuordnen und somit von dieser wieder verwalten zu lassen

Siehe auch weitere Methoden zur Ereignisbehandlung unter [*Ereignisse*](#ereignisse).

### Parameter
keine

### Rückgabewert
keiner

### Verwendung
```cs
protected override void OnBrokerConnect()
```

### Beispiel
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
### Beschreibung
Die Methode OnBrokerDisconnect() wird jedesmal dann aufgerufen, wenn die Verbindung zum Broker unterbrochen wurde.

Siehe auch weitere Methoden zur Ereignisbehandlung unter [*Ereignisse*](#ereignisse).

### Parameter
Ein Objekt vom Typ  *TradingDatafeedChangedEventArgs*

### Rückgabewert
keiner

### Verwendung
```cs
protected override void OnBrokerDisconnect(TradingDatafeedChangedEventArgs e)
```

### Beispiel
```cs
protected override void OnBrokerDisconnect(TradingDatafeedChangedEventArgs e)
{
   if (e.Connected)
       Print("Die Verbindung zum Broker wird getrennt.");
   else
       Print("Die Verbindung zum Broker wurde getrennt.");
}
```

## OnCalculate()
### Beschreibung
Die Methode OnCalculate() wird immer dann aufgerufen, wenn sich ein Bar ändert. Abhängig von der Variablen  [*CalculateOnClosedBar*](#CalculateOnClosedBar),wird sie entweder bei jedem hereinkommenden Tick oder erst nach Fertigstellung eines Bars aufgerufen.
OnCalculate ist die wichtigste Methode, die im Normalfall auch den größten Teil des Codes selbsterstellter Indikatoren bzw. Strategien enthält.
Die Bearbeitung beginnt mit dem ältesten Bar und läuft bis zum jüngsten Bar im Chart. Der älteste Bar erhält dabei die Nummer 0. Es wird fortlaufend weiter nummeriert. Auf diese Nummerierung kann über die Variable ProcessingBarIndex zugegriffen werden, siehe Beispiel unten.

**Achtung:**
**Diese Nummerierung unterscheidet sich vom BarIndex, siehe [*Bars*](#Bars).**

More information can be found here: [*Events*](#events).

### Parameter
keiner

### Rückgabewert
keiner

### Verwendung
```cs
protected override void OnCalculate()
```

### Beispiel
```cs
protected override void OnCalculate()
{
    Print("Aufruf von OnBarUpdate für Bar Nr. " + ProcessingBarIndex + " von " +Time[0]);
}
```
## OnChartPanelMouseDown()
### Beschreibung
In einem Indikator, oder einer Strategie, kann die aktuelle Position der Maus ausgewertet und verarbeitet werden. Dafür ist es notwendig, dass man einen EventHandler als Methode programmiert und diese Methode anschließend dem Event ChartControl.ChartPanelMouseDown hinzufügt.

### Achtung!
Es ist wichtig, den EventHandler innerhalb der OnDispose() Methode wieder aus dem Event zu entfernen, da sonst der EventHandler selbst dann noch ausgeführt wird, wenn der Indikator aus dem Chart entfernt wurde!

### Beispiel
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

## OnChartPanelMouseMove()
### Beschreibung
In einem Indikator, oder einer Strategie, kann die aktuelle Position der Maus ausgewertet und verarbeitet werden. Dafür ist es notwendig, dass man einen EventHandler als Methode programmiert und diese Methode anschließend dem Event  Chart.ChartPanelMouseMove hinzufügt.

### Achtung!
Es ist wichtig, den EventHandler innerhalb der OnDispose() Methode wieder aus dem Event zu entfernen, da sonst der EventHandler selbst dann noch ausgeführt wird, wenn der Indikator aus dem Chart entfernt wurde!

### Beispiel
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

## OnDispose()
### Beschreibung
Die Methode  OnDispose() kann überschrieben werden, um alle im Script verwendeten Ressourcen wieder freizugeben.

Siehe auch [*OnInit()*](#oninit) und [*OnStart()*](#onstart).

Siehe auch weitere Methoden zur Ereignisbehandlung unter [*Ereignisse*](#ereignisse).

### Parameter
keiner

### Rückgabewert
keiner

### Verwendung
```cs
protected override void OnDispose()
```

### Weitere Informationen
**Achtung:**
**Bitte überschreiben Sie nicht die Dispose() Methode, da diese erst sehr viel später aufgerufen werden kann. Ressourcen bleiben zu lange erhalten und können zu unerwartetem und unvorhersehbarem Verhalten der gesamten Anwendung führen.**

### Beispiel
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
## OnLevel1()
### Beschreibung
Die Methode OnLevel1() wird bei jeder Änderung in den Level-I-Daten aufgerufen, d.h. bei einer Änderung des Bid-Preises, Ask-Preises, des Bid-Volumens, des Ask-Volumens und natürlich des Last-Preises nachdem ein realer Umsatz stattfand.
In a multibar indicator, the ProcessingBarSeriesIndex die jeweilige Datenreihe ermittelt werden, für die OnLevel1() aufgerufen wurde.

OnLevel1() wird nicht für historische Daten aufgerufen
Siehe auch weitere Methoden zur Ereignisbehandlung unter [*Ereignisse*](#ereignisse).

**Hinweis zu Daten von Yahoo (YFeed)**

Das Feld "LastPrice" entspricht - wie gewohnt - je nach letztem Handelsumsatz entweder dem "BidPrice" oder dem "AskPrice".

Das Feld "MarketDataType" ist immer "Last".

Die Felder "Volumen", "BidSize" und "AskSize" sind immer 0.

### Verwendung
```cs
protected override void OnLevel1(Level1Args e)
```

### Rückgabewert
keiner

### Parameter
```cs
[*Level1Args*] e
```


### Beispiel
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
### Beschreibung
Die Methode OnLevel2() wird bei jeder Änderung in den Level-II-Daten (Markttiefe) aufgerufen.
In einem Multibar-Indikator kann mit  ProcessingBarSeriesIndex die jeweilige Datenreihe ermittelt werden, für die OnMarketDepth() aufgerufen wurde.
OnLevel2 wird nicht für historische Daten aufgerufen.

Siehe auch weitere Methoden zur Ereignisbehandlung unter [*Ereignisse*](#ereignisse).

### Verwendung
```cs
protected override void OnLevel2(Level2Args e)
```

### Rückgabewert
keiner

### Parameter
Ein Objekt von *Level2Args*

### Beispiel
```cs
protected override void OnLevel2(Level2Args e)
{
    // Ausgabe des jeweils aktuellen Ask-Kurses
    if (e.MarketDataType == MarketDataType.Bit)
    	Print("The current bit is " + e.Price );
}
```
## OnOrderChanged()
### Beschreibung
Die Methode OnOrderChanged()  wird jedesmal dann aufgerufen, wenn sich der Status einer durch eine Strategie verwaltete Order ändert. Ene Statusänderung kann dabei durch die Änderung des Volumens, des Preises oder des Status an der Börse (von working zu filled) ausgelöst werden. Es ist sichergestellt, dass diese Methode für alle Ereignisse in der korrekten Reihenfolge aufgerufen wird.

**Wichtiger Hinweis:**
**Wenn eine Strategie durch Orderausführungen gesteuert werden soll, ist es ratsamer,  OnOrderExecution() anstelle von OnOrderChanged() zu verwenden.  Es kann sonst zu Problemen bei Teilausführungen kommen..**

Siehe auch weitere Methoden zur Ereignisbehandlung unter [*Ereignisse*](#ereignisse).

### Parameter
Ein Order-Objekt vom Type IOrder

### Rückgabewert
keiner

### Verwendung
```cs
protected override void OnOrderChanged(IOrder order)
```

### Beispiel
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

## OnOrderExecution()
### Beschreibung
Die Methode OnOrderExecution() wird jedesmal dann aufgerufen, wenn eine Order ausgeführt (filled) wurde oder sich der Status einer durch eine Strategie verwaltete Order ändert. Ene Statusänderung kann dabei durch die Änderung des Volumens, des Preises oder des Status an der Börse (von working zu filled) ausgelöst werden. Es ist sichergestellt, dass diese Methode für alle Ereignisse in der korrekten Reihenfolge aufgerufen wird.

OnOrderExecution() wird immer nach [*OnOrderChanged()*](#onorderchanged) aufgerufen.

Siehe auch weitere Methoden zur Ereignisbehandlung unter [*Ereignisse*](#ereignisse).

### Parameter
Ein execution-Objekt vom Type  *IExecution*

### Rückgabewert
keiner

### Verwendung
```cs
protected override void OnOrderExecution(IExecution execution)
```

### Beispiel
```cs
private IOrder entry = null;
protected override void OnCalculate()
{
	if (CrossAbove(EMA(14), SMA(50), 1) && IsSerieRising(ADX(20)))
        	entry = OpenLong("EMACrossesSMA");
}
protected override void OnOrderExecution(IExecution execution)
{
    // Beispiel
    if (entry != null && execution.Order == entry)
    {
    	Print(execution.Price.ToString());
	Print(execution.Order.OrderState.ToString());
    }
}
```

## OnStart()
### Beschreibung
Die Methode OnStart() kann überschrieben werden, um eigene Variablen zu initialisieren, Lizenzchecks auszuführen, UserForms aufzurufen usw.
OnStart() wird nur einmal am Beginn des Scrips nach [*OnInit()*](#oninit) und vor [*OnCalculate()*](#oncalculate) aufgerufen.

Siehe auch [*OnDispose()*](#ondispose).

Siehe auch weitere Methoden zur Ereignisbehandlung unter [*Ereignisse*](#ereignisse).

### Parameter
keiner

### Rückgabewert
keiner

### Verwendung
```cs
protected override void OnStart()
```

### Beispiel
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
