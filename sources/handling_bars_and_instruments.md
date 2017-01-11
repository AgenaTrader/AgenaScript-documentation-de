#Handling bars und instrumente

Data is understood as information that is retrieved externally and uploaded to AgenaTrader, or as data series that are created by AgenaScripts.

Further detailed information can be found using the appropriate shortcuts:

[Bars (Candles)](#bars-candles)

[Data series](#data-series)

[Instruments](#instruments)

##Bars (Candles)
### Funktionsweise
Ein klassischer Indikator berechnet üblicherweise aus einer vorliegenden Datenreihe einen oder mehrere Werte.

Datenreihen können dabei z.B. alle Schlusskurse oder auch alle Tiefkurse eines Tages, einer Stunde oder einer 10 Min. Periode sein.

Jeder Periode (also jeder Kerze eines Tages, einer Stunde usw.) wird/werden folglich ein oder mehrere Indikatorwert(e) zugeordnet.
Im Folgenden gehen wir von einem Indikatorwert, wie z.B. bei einem gleitenden Durchschnitt aus.
Zur Berechnung eines gleitenden Durchschnitts benötigt AgenaTrader eine Datenreihe. Im Beispiel nehmen wir die Schlusskurse. Alle Schlusskurse der Bars (Kerzen), die in einem Chart dargestellt sind, sind in einer Liste gespeichert und sozusagen durchnummeriert.

Der aktuelle Schlusskurs, also der Schlusskurs des Bars, der am rechten Rand des Charts dargestellt wird, bekommt die Nummer 0. Der Bar links davon die Nummer 1 usw. Der älteste dargestellte Bar hat dann z.B. die Nummer 500.

Kommt im Laufe der Handelssitzung ein neuer Bar hinzu, erhält dieser nun die Nummer 0, der links von ihm, der gerade noch die Nummer 0 hatte, wird zu Nummer 1 usw. Der letzte dargestellte Bar wird zu Nummer 501.

In einem Script (einem selbsterstellten Programm) steht [*Close*](#close) für die Liste (Array) aller Schlusskurse.
Der letzte Schlusskurs ist dann *Close \[0\]*; , der Schlusskurs davor (bei Tagesdaten ist das z.B. der Schlusskurs von gestern) ist *Close \[1\]*,, der davor *Close \[2\]* bis zum ersten Bar im Chart (ganz links) mit *Close \[501\]*. Die Zahl in den eckigen Klammern ist ein Index. In AgenaTrader steht hierfür im allgemeinen Fall der Ausdruck "barsAgo

Für jeden Bar gibt es nicht nur Close, sondern zudem auch [*High*](#high), [*Low*](#low), [*Open*](#open), [*Median*](#median), [*Typical*](#typical), [*Weighted*](#weighted), [*Time*](#time) and [*Volume*](#volume). Das Hoch der Kerze, von vor 10 Tagen ist also z.B. *High \[10\]*, Das Tief von gestern *Low \[1\]*...

**wichtiger Hinweis:**

Die o.g. Beispiele gelten, wenn die Berechnung am Ende einer Periode erfolgt. Die Werte der aktuell laufenden (noch nicht fertigen Kerze) sind nicht berücksichtigt.

Möchte man bereits auf die Werte der sich gerade ausbildenden Kerze zurückgreifen, muß man dies AgenaTrader im Script mit

[*CalculateOnClosedBar*](#CalculateOnClosedBar) = false mitteilen..

In diesem Fall bekommt der aktuell laufende Bar die Nummer 0, der Bar links neben dem aktuell laufenden die Nummer 1 usw. Der letzte Bar (im Beispiel oben) hätte jetzt die Nummer 502.

Mit close \[0\]  bekommt man nun den jeweils letzten Kurs, der gerade vom Datenanbieter an AgenaTrader übermittelt wurde. Alle Werte des Bars (high \[0\], low \[0\]…) können sich solange verändern, bis der Bar fertig ausgebildet ist und ein neuer Bar begonnen hat. Nur Open[0] ändert sich auch in diesem Fall nicht mehr.

## Eigenschaften von Bars
### Eigenschaften von Bars
"Bars" steht für eine Liste aller Bars (Kerzen) in einem Chart (siehe [*Funktionsweise*](#funktionsweise)(#funktionsweise)[*Bars*](#bars)).

Bars (**public** IBars Bars) kann direkt in einem Script verwendet werden und entspricht in diesem Fall \[0\] (siehe Bars.GetNextSessionTimeSpan for more information).

Die Liste der Bars selbst hat viele Eigenschaften, die in einem selbst erstellten AgenaScript verwendet werden können. Eigenschaften werden immer mit einem Punkt hinter dem Objekt (in diesem Falle Bars, der Liste der Kerzen) angegeben.

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

[*ProcessingBarSeriesIndex*](#processingbarseriesindex)

With the **OnCalculate()** method you can use any properties you want without having to test for a null reference.
As soon as the function **OnCalculate()** is called up by AgenaScript, it is assumed that an object is also available. If you wish to use these properties outside of **OnCalculate()** then you should first perform a test for null references using **if** (Bars != **null**).

## BarsCountForSession
### Beschreibung
Bars.BarsCountForSession  liefert die Anzahl der Bars, die seit dem Beginn der aktuellen Handelssitzung entstanden sind.

Siehe auch weitere [*Eigenschaften*](#eigenschaften) von Bars.

### Rückgabewert
Typ int		Anzahl der Bars
Ein Wert von -1 deutet auf ein Problem bei der Ermittlung des Sessionbeginns hin.

### Usage
Bars.BarsCountForSession

### Weitere Informationen
Innerhalb von  *OnBarUpdate()* kann diese Eigenschaft verwendet werden, ohne vorher auf Null-Reference testen zu müssen. Sobald die Methode  OnCalculate() von AgenaScript aufgerufen wird, ist immer auch ein Bars Objekt vorhanden.

Falls diese Eigenschaft ausserhalb von  OnCalculate()  verwendet wird, sollte vorher ein entsprechender Test auf Null-Reference z.B. mit *if* (Bars!= *null*) ausgeführt werden. .

### Beispiel
```cs
Print ("Seit dem Start der letzten Handelssitzung sind" + Bars.BarsCountForSession + "Bars entstanden.");
```

## Bars.Count
### Beschreibung
Bars.Count liefert die Anzahl der Bars in einer Datenreihe.

Siehe auch weitere [*Eigenschaften*](#eigenschaften) von Bars.

### Rückgabewert
Typ int		Anzahl der Bars

### Verwendung
Bars.Count

### Weitere Informationen
Der Wert von *ProcessingBarIndex* kann immer nur kleiner oder gleich Bars.Count - 1 sein.

Wenn in AgenaTrader angegeben wurde, wieviel Bars in einen Chart geladen werden sollen, entspricht der Wert von Bars.Count genau dieser Einstellung. Im Beispiel unten würde Bars.Count 500 liefern.

![Bars.Count](./media/image1.png)

### Beispiel
```cs
Print ("Es stehen insgesamt " + Bars.Count + "Bars zur Verfügung.");
```

## Bars.IsFirstBarInSession
### Beschreibung
Mit Bars.IsFirstBarInSession kann festgestellt werden, ob der aktuelle Bar der erste Bar einer Handelssitzung ist.

Siehe auch weitere [*Eigenschaften*](#eigenschaften) von Bars.

### Rückgabewert
Typ bool

**true**: Der Bar ist der erste Bar einer Handelssitzung
**false**: Der Bar ist nicht der erste Bar einer Handelssitzung

### Verwendung
Bars.IsFirstBarInSession

### Weitere Informationen
Innerhalb von *OnCalculate()* kann diese Eigenschaft verwendet werden, ohne vorher auf Null-Reference testen zu müssen. Sobald die Methode OnCalculate() von AgenaScript aufgerufen wird, ist immer auch ein Bars Objekt vorhanden.
Falls diese Eigenschaft ausserhalb von OnCalculate() verwendet wird, sollte vorher ein entsprechender Test auf Null-Reference z.B. mit if (Bars != null) ausgeführt werden..

### Beispiel
```cs
if (Bars.IsFirstBarInSession)
Print ("Die aktuelle Handelsitzung hat um" + Time [0]);
```

## Bars.GetBar
### Beschreibung
Bars.GetBar liefert den ersten Bars (vom ältesten zum jüngsten), der dem übergebenen Datum bzw. der Uhrzeit entspricht.

Siehe auch [*Bars.GetBarsAgo*](#barsgetbarsago), [*Bars.GetByIndex*](#barsgetbyindex), [*Bars.GetBarIndex*](#barsgetbarindex).

### Parameter
Typ DateTime

### Rückgabewert
Typ IBar Bar-Objekt, des dem Zeitstempel entsprichenden Bars

bei Zeitstempel älter als der älteste Bar: 0 (null)
bei Zeitstempel jünger als der letzte Bar: Index des letzten Bars

### Usage
```cs
Bars.GetBar(DateTime time)
```

### Verwendung
zur Indizierung von Bars siehe [*Funktionsweise*](#funktionsweise), [*Bars*](#bars)

 Benutzung von DateTime siehe [http://msdn.microsoft.com/de-de/library/system.datetime.aspx](http://msdn.microsoft.com/de-de/library/system.datetime.aspx)

### Beispiel
```cs
Print ("Der Schlusskurs für den 01.03.2012 um 18:00:00 Uhr war " + Bars.GetBar(new DateTime(2012, 01, 03, 18, 0, 0)).Close);
```

## Bars.GetBarsAgo
### Beschreibung
Bars.GetBarsAgo liefert den Index des ersten Bars (vom ältesten zum jüngsten), der dem übergebenen Datum bzw. der Uhrzeit entspricht.

Siehe auch: [*Bars.GetBar*](#barsgetbar), [*Bars.GetByIndex*](#barsgetbyindex), [*Bars.GetBarIndex*](#barsgetbarindex).

### Parameter
Typ DateTime

### Rückgabewert
Typ int Index des Bars, der dem Zeitstempel als erstes entspricht.
bei Zeitstempel älter als der älteste Bar: 0 (null)
bei Zeitstempel jünger als der letzte Bar: Index des letzten Bars

### Verwendung
```cs
Bars.GetBarsAgo(DateTime time)
```

### Weitere Informationen
zur Indizierung von Bars siehe [*Funktionsweise*](#funktionsweise), [*Bars*](#bars)

zur Benutzung von DateTime siehe  [http://msdn.microsoft.com/de-de/library/system.datetime.aspx](http://msdn.microsoft.com/de-de/library/system.datetime.aspx)

### Beispiel
```cs
Print("Der Bar für den 01.03.2012 um 18:00:00 Uhr hat den Index " + Bars.GetBarsAgo(new DateTime(2012, 01, 03, 18, 0, 0)));
```

## Bars.GetClose
Bars.GetClose(int index) – siehe [*Bars.GetOpen*](barsgetopen).

## Bars.GetHigh
Bars.GetHigh(int index) – siehe [*Bars.GetOpen*](barsgetopen).

## Bars.GetByIndex
### Beschreibung
Bars.GetByIndex liefert das zu einem übergebenen Index gehörende Bar-Objekt.

Siehe auch [*Bars.GetBar*](#barsgetbar)(#barsgetbar), [*Bars.GetBarsAgo*](#barsgetbarsago)(#barsgetbarsago), [*Bars.GetBarIndex*](#barsgetbarindex)(#barsgetindex).

### Parameter
Typ int Index

### Rückgabewert
Typ IBar Bar-Objekt zu dem übergebenen Index

### Verwendung
```cs
Bars.GetByIndex (int Index)
```

### Weitere Informationen
zur Indizierung von Bars siehe [*Funktionsweise*](#funktionsweise), [*Bars*](#bars)

### Beispiel
```cs
Print(Close[0] + " und " + Bars.GetByIndex(ProcessingBarIndex).Close + "sind in diesem Beispiel gleich.");
```

## Bars.GetBarIndex
### Beschreibung
Bars.GetBarIndex  liefert den Index eines Bars you can input either a bar object or a date-time object using this method.

See [*Bars.GetBar*](#barsgetbar)(#barsgetbar), [*Bars.GetBarsAgo*](#barsgetbarsago)(#barsgetbarsago), [*Bars.GetByIndex*](#barsgetbyindex)(#barsgetbyindex).

### Parameter
Typ IBar bar
oder
Typ DateTime

### Rückgabewert
Type int der zu dem übergebenen Bar-Objekt bzw. dem übergebenen DateTime-Objekt gehörende Bar-Index

### Usage
```cs
Bars.GetBarIndex (IBar bar)
Bars.GetBarIndex (DateTime dt)
```

### Weitere Informationen
zur Indizierung von Bars siehe[*Funktionsweise*](#funktionsweise), [*Bars*](#bars)

### Beispiel
```cs
int barsAgo = 5;
IBar bar = Bars.GetBar(Time[barsAgo]);
Print(barsAgo + " und " + Bars.GetBarIndex(bar) + "sind in diesem Beispiel gleich.");
```

## Bars.GetLow
Bars.GetLow(int index) – siehe [*Bars.GetOpen*](barsgetopen).

## Bars.GetNextSessionTimeSpan
### Description
Bars.GetNextSessionTimeSpan liefert jeweils Datum und Uhrzeit von Beginn und Ende der nächsten Handelssitzung.

Siehe auch [*Bars.CurrentSessionBeginTime*](#barssessionbegin), [*Bars.CurrentSessionEndTime*](#barssessionend), [*Bars.NextSessionBeginTime*](#barssessionnextbegin), [*Bars.NextSessionEndTime*](#barssessionnextend).

### Parameter
|          |         |                                                                                            |
|----------|---------|--------------------------------------------------------------------------------------------|
| DateTime | time    | Datum bzw. Uhrzeit, für die die Daten der folgenden Handelssitzung gesucht werden          |
| iBars    | bars    | Barobjekt, für das die Daten der folgenden Handelssitzung gesucht werden.                  |                    
| int      | barsago | Anzahl der Tage in der Vergangenheit, für die die Daten der folgenden Handelssitzung gesucht werden   |

### Rückgabewert
DateTime session begin
DateTime session end

**Hinweis:**
Das Datum von Beginn und Ende sind jeweils für eine Handelssitzung zusammengehörend. Wenn das übergebene Datum dem Ende-Datum der aktuellen Handelssitzung entspricht, kann das zurückgegebene Datum für den Beginn der Handelssitzung bereits in der Vergangenheit liegen.
Es wird in diesem Fall nicht das Datum der nächstfolgenden Handelssitzung zurückgegeben.

### Verwendung
```cs
Bars.GetNextSessionTimeSpan(Bars bars, int barsAgo, out DateTime sessionBegin, out DateTime sessionEnd)
Bars.GetNextSessionTimeSpan(DateTime time, out DateTime sessionBegin, out DateTime sessionEnd)
```

### Weitere Informationen
Die beiden Signaturen liefern nicht notwendigerweise auch die gleichen Ergebnisse.
Bei Verwendung der Bar-Signatur wird der ubergebene Bar daraufhin untersucht, zu welchem Session-Template er gehört. Beginn und Ende der nächsten Session werden dann diesem Template entnommen.

Bei Verwendung der Zeit-Signatur wierden Datum und Uhrzeit des übergebenen Bars genutzt, um die Daten der aktuellen und damit der folgenden Session zu berechnen.

Wenn bei Verwendung der Zeit-Signatur ein Zeitstempel übergeben wird, der exakt einer Beginn bzw. Endezeit einer Session entspricht, werden Beginn und Ende der davorliegenden Session zurückgegeben, d.h. der Zeitstempel wird als "in der Session enthalten" angesehen, selbst wenn der fragliche Bar bereits in einer neuen Session enthalten ist. Um dieses Verhaten sicher auszuschließen, ist die Verwendung der Bar-Signatur empfohlen.

zur Benutzung von DateTime siehe  [*http://msdn.microsoft.com/de-de/library/system.datetime.aspx*](http://msdn.microsoft.com/de-de/library/system.datetime.aspx)

### Beispiel
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
### Beschreibung
Bars.GetSessionBegin  liefert das Datum und die Uhrzeit des Beginns einer bestimmten Handelssitzung.
Datum und Uhrzeit für den Beginn der aktuellen Handelssitzung werden auch dann korrekt angegeben, wenn die Funktion von einem Bar in der Vergangenheit aufgerufen wird. Siehe auch weitere [*Eigenschaften*](#eigenschaften) von Bars.

### Parameter
keine

### Rückgabewert
Typ DateTime

### Verwendung
Bars.GetSessionBegin(DateTime dt)

### Weitere Informationen
Die Uhrzeit des zurückgegebenen Wertes entspricht der im MarketEscort angegebenen Startzeit der Handelssitzung des jeweiligen Handelsplatzes. Der für den Wert verwendete Handelsplatz wird im Instrumet Escort eingestellt und kann in AgenaSript mit der Funktion Instrument.Exchange ermittelt werden.

![Bars.CurrentSessionBeginTime](./media/image3.png)
### Beispiel
```cs
Print("Die Handelssitzung am 25.03.2015 hat um "+ Bars.GetSessionBegin(new DateTime(2015, 03, 25)) + " begonnen.");
}
```
## Bars.GetOpen
### Beschreibung
Die folgenden Methoden sind aus Gründen der Kompatibilität vorhanden.

-   Bars.GetOpen(int index) liefert das Open des mit  &lt;index&gt referenzierten Bars;.
-   Bars.GetHigh(int index) liefert das High des mit  &lt;index&gt referenzierten Bars;.
-   Bars.GetLow(int index) liefert das Low des mit  &lt;index&gt referenzierten Bars;.
-   Bars.GetClose(int index) liefert das Close des mit  &lt;index&gt referenzierten Bars;.
-   Bars.GetTime(int index) liefert das Zeitstempel des mit  &lt;index&gt referenzierten Bars;.
-   Bars.GetVolume(int index) liefert das Volumen des mit  &lt;index&gt referenzierten Bars;.

**Achtung:**: Die Indizierung weicht von der sonst verwendeten [*Indizierung *](#indexing), [*Bars*](#bars) ab.
Hier beginnt die Indizierung mit 0 am ältesten Bar (links im Chart) und endet mit dem jüngsten Bar rechts im Chart  (=Bars.Count-1)..

Die Indizierungen können leicht (in beiden Richtungen!) wie folgt umgerechnet werden:
```cs
private int Convert(int idx)
{
return Math.Max(0,Bars.Count-idx-1-(CalculateOnClosedBar?1:0));
}
```

### Parameter
int index (0 .. Bars.Count-1)

### Rückgabewert
Typ double für GetOpen, GetHigh, GetLow, GetClose und GetVolume

Type DateTime für GetTime

## Bars.GetTime
Bars.GetTime(int index) – siehe [*Bars.GetOpen*](barsgetopen).

## Bars.GetVolume
Bars.GetVolume(int index) – siehe [*Bars.GetOpen*](barsgetopen).

## Bars.Instrument
### Beschreibung
Bars.Instrument liefert ein Instrument-Objekt, für das im Chart dargestellte Handelsinstrument.

Siehe auch weitere [*Eigenschaften *](#eigenschaften ) von Bars.

### Parameter
keine

### Rückgabewert
Typ Instrument

### Verwendung
Bars.Instrument

### Weitere Informationen
Für weitere Informationen zu Handelsinstrumenten siehe unter [*Instrument*](#instrument).

### Beispiel
```cs
// beide Ausgaben liefern das gleiche Ergebnis
Print("Das aktuell dargestellte Handelsinstrument hat das Symbol" + Bars.Instrument);
Instrument i = Bars.Instrument;
Print("Das aktuell dargestellte Handelsinstrument hat das Symbol" + i.Symbol);
```
## Bars.IsEod
### Beschreibung
Mit Bars.IsEod kann überprüft werden, ob es sich um End-of-Day-Bars handelt.

Siehe auch weitere [*Eigenschaften *](#eigenschaften ) von Bars.

### Parameter
keine

### Rückgabewert
Typ bool

### Verwendung
Bars.IsEod

### Weitere Informationen
Innerhalb von [*OnCalculate()*](#oncalculate), kann diese Eigenschaft verwendet werden, ohne vorher auf Null-Reference testen zu müssen. Sobald die Methode  OnCalculate () von AgenaScript aufgerufen wird, ist immer auch ein Bars Objekt vorhanden.

IFalls diese Eigenschaft ausserhalb von OnCalculate (),  verwendet wird, sollte vorher ein entsprechender Test auf Null-Reference z.B. mit if (bars! = Null) ausgeführt werden.

### Beispiel
```cs
Print("Die Bars sind Eod: " + Bars.IsEod);
```
## Bars.IsIntraday
### Beschreibung
Bars.IsIntraday liefert eine boolesche Variable die weist darauf hin, ob die Zeitspanne (TimeFrame) intraday ist. 

### Rückgabewert
Typ bool

Es sendet „true“ zurück wenn die Zeitspanne (TimeFrame) intraday ist (z.B. 1 Min., 15 Min., 1 Std. etc.) und "false" in den anderen Fällen.

### Verwendung
```cs
Bars.IsIntraday
```

### Beispiel
```cs
if(Bars.IsIntraday) {
	Print("TimeFrame ist Intraday.");
} else {
	Print("TimeFrame ist nicht Intraday.");
}
```
## Bars.IsNtb
### Beschreibung
Mit Bars.IsNtb kann überprüft werden, ob es sich um Not-Time-Based-Bars handelt. Bei Ntb-Bars handelt es sich beispielsweise um Point & Figure oder Renko Charts.

Siehe auch weitere  [* Eigenschaften*](#eigenschaften) von Bars.

### Parameter
keine

### Rückgabewert
Typ bool

### Verwendung
Bars.IsNtb

### Weitere Informationen
Innerhalb von [*OnCalculate()*](#oncalculate) kann diese Eigenschaft verwendet werden, ohne vorher auf Null-Reference testen zu müssen. Sobald die Methode OnCalculate()  von AgenaScript aufgerufen wird, ist immer auch ein Bars Objekt vorhanden. Falls diese Eigenschaft ausserhalb von OnCalculate(), verwendet wird, sollte vorher ein entsprechender Test auf Null-Reference z.B. mit if (Bars != null) ausgeführt werden.

### Beispiel
```cs
Print("Die angezeigten Bars sind Ntb: " + Bars.IsNtb);
```


## Bars.LastBarCompleteness
### Beschreibung
Bars.LastBarCompletenessliefert einen Wert, der angibt, zu wieviel Prozent ein Bar bereits fertiggestellt ist.  Ein Bar in der Zeiteinheit 10 Minuten ist z.B. nach 5 Minuten genau zu 50% fertig.

Für nicht-zeitbasierte Chartarten (Kagi, LineBreak, Renko, Range, P&F usw.) und während eines Backtests liefert die Eigenschaft immer eine 0.

Siehe auch weitere  [* Eigenschaften*](#eigenschaften) von Bars.

### Rückgabewert
**double**

als Prozentwert, d.h. für 30% wird 0.3 zurückgegeben-

### Verwendung
Bars.LastBarCompleteness

### Weitere Informationen
Innerhalb von  [*OnCalculate()*](#oncalculate) kann diese Eigenschaft verwendet werden, ohne vorher auf Null-Reference testen zu müssen. Sobald die Methode  OnCalculate() von AgenaScript aufgerufen wird, ist immer auch ein Bars Objekt vorhanden.

Falls diese Eigenschaft ausserhalb von OnCalculate()  verwendet wird, sollte vorher ein entsprechender Test auf Null-Reference z.B. mit *if* (Bars != *null*) ausgeführt werden.

### Beispiel
```cs
// Ein 60 Min. Chart wird intraday beobachtet.
// Jeweils 5 Min. bevor der aktuelle Bar schließt,
// soll ein akustisches Signal ausgegeben werden.
// 55 Min. entsprechen 92%
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
Bars.CurrentSessionBeginTime liefert das Datum und die Uhrzeit des Beginns der aktuell laufenden Handelssitzung.

Datum und Uhrzeit für den Beginn der aktuellen Handelssitzung werden auch dann korrekt angegeben, wenn die Funktion von einem Bar in der Vergangenheit aufgerufen wird.

### Parameter
keine

### Rückgabewert
Typ DateTime

### Verwendung
Bars.CurrentSessionBeginTime

### Weitere Informationen
Die Uhrzeit des zurückgegebenen Wertes entspricht der im MarketEscort angegebenen Startzeit der Handelssitzung des jeweiligen Handelsplatzes. Der für den Wert verwendete Handelsplatz wird im Instrumet Escort eingestellt und kann in AgenaSript mit der Funktion [*Instrument.Exchange*](#instrumentexchange) ermittelt werden.

![Bars.CurrentSessionBeginTime](./media/image3.png)

### Example
```cs
Print("Die laufende Handelssitzung hat um " + Bars.CurrentSessionBeginTime );
```

## Bars.IsSessionBreak
### Beschreibung
Mit Bars.IsSessionBreak  kann ermittelt werden, ob die Bars innerhalb der laufenden Handelssitzung in den im Marktplatz-Escort definierten Handelspausen liegen.

Siehe auch weitere  [*Eigenschaften*](#eigenschaften) von Bars.

### Parameter
keine

### Rückgabewert
Typ bool

### Verwendung
Bars.IsSessionBreak

### Weitere Informationen
![Bars.CurrentSessionEndTime](./media/image4.png)
### Example
```cs
if (Bars.IsSessionBreak)
{
Print("Die Börse Xetra hat gerade eine Handelspause");
}
```

## Bars.CurrentSessionEndTime
### Beschreibung
Bars.CurrentSessionEndTime liefert das Datum und die Uhrzeit für das Ende der aktuell laufenden Handelssitzung.
Datum und Uhrzeit für das Ende der aktuellen Handelssitzung werden auch dann korrekt angegeben, wenn die Funktion von einem Bar in der Vergangenheit aufgerufen wird.

### Parameter
keine

### Rückgabewert
Typ DateTime

### Verwendung
Bars.CurrentSessionEndTime

### Weitere Informationen
Die Uhrzeit des zurückgegebenen Wertes entspricht der im MarketEscort angegebenen Endezeit der Handelssitzung des jeweiligen Handelsplatzes. Der für den Wert verwendete Handelsplatz wird im Instrumet Escort eingestellt und kann in AgenaSript mit der Funktion [*Instrument.Exchange*](#instrumentexchange) ermittelt werden.

![Bars.CurrentSessionEndTime](./media/image4.png)

### Beispiel
```cs
Print("Die laufende Handelssitzung endet um" + Bars.CurrentSessionEndTime);
```

## Bars.NextSessionBeginTime
### Beschreibung
Bars.NextSessionBeginTime liefert das Datum und die Uhrzeit des Beginns der auf die aktuell laufende Handelssitzung folgenden Sitzung.
Datum und Uhrzeit für den Beginn der nächsten Handelssitzung werden auch dann korrekt angegeben, wenn die Funktion von einem Bar in der Vergangenheit aufgerufen wird.

### Parameter
keine

### Rückgabewert
Typ DateTime

### Verwendung
Bars.GetSessionNextBegin

### Weitere Informationen
Die Uhrzeit des zurückgegebenen Wertes entspricht der im MarketEscort angegebenen Startzeit der Handelssitzung des jeweiligen Handelsplatzes. Der für den Wert verwendete Handelsplatz wird im Instrumet Escort eingestellt und kann in AgenaSript mit der Funktion [*Instrument.Exchange*](#instrumentexchange) ermittelt werden.

![Bars.NextSessionBeginTime](./media/image3.png)

### Beispiel
```cs
Print("Die nächste Handelssitzung beginnt um" + Bars.NextSessionBeginTime);
```

## Bars.NextSessionEndTime
### Beschreibung
Bars.NextSessionEndTime liefert das Datum und die Uhrzeit für das Ende der auf die aktuell laufende Handelssitzung folgenden Sitzung.
Siehe auch weitere [*Eigenschaften*](#eigenschaften) von Bars.

### Parameter
keine

### Rückgabewert
Typ DateTime

### Verwendung
Bars.GetSessionNextEnd

### Weitere Informationen
Die Uhrzeit des zurückgegebenen Wertes entspricht der im MarketEscort angegebenen Endezeit der Handelssitzung des jeweiligen Handelsplatzes. Der für den Wert verwendete Handelsplatz wird im Instrumet Escort eingestellt und kann in AgenaSript mit der Funktion [*Instrument.Exchange*](#instrumentexchange) ermittelt werden.

![Bars.NextSessionEndTime](./media/image4.png)

### Beispiel
```cs
Print("Die nächste Handelssitzung endet um " + Bars.NextSessionEndTime);
```

## Bars.TicksCountForLastBar
### Beschreibung
Bars.TicksCountForLastBar  liefert die Gesamtanzahl der in einem Bar enthaltenen Ticks.

Siehe auch weitere [*Eigenschaften*](#eigenschaften) von Bars.

### Parameter
keine

### Rückgabewert
Typ int

### Verwendung
Bars.TicksCountForLastBar

### Weitere Informationen
Innerhalb von [*OnCalculate()*](#oncalculate) kann diese Eigenschaft verwendet werden, ohne vorher auf Null-Reference testen zu müssen. Sobald die Methode OnCalculate() von AgenaScript aufgerufen wird, ist immer auch ein Bars Objekt vorhanden.

Falls diese Eigenschaft ausserhalb von OnCalculate(),verwendet wird, sollte vorher ein entsprechender Test auf Null-Reference z.B. mit  *if* (Bars != *null*) ausgeführt werden.

### Beispiel
```cs
Print("Der aktuelle Bar besteht aus " + Bars.TicksCountForLastBar + " Ticks.");
```

## Bars.TimeFrame
### Beschreibung
Bars.TimeFrame liefert ein TimeFrame-Objekt, das Informationen zum aktuell verwendeten Zeiteinheit enthält.

Siehe auch weitere [*Eigenschaften*](#eigenschaften) von Bars.

### Parameter
keine

### Rückgabewert
Typ ITimeFrame

### Verwendung
Bars.TimeFrame

### More Information
Für weitere Informationen zum TimeFrame-Objekt siehe unter [*TimeFrame*](#timeframe).

Innerhalb von [*OnCalculate()*](#oncalculate) kann diese Eigenschaft verwendet werden, ohne vorher auf Null-Reference testen zu müssen. Sobald die Methode OnCalculate() von AgenaScript aufgerufen wird, ist immer auch ein Bars Objekt vorhanden.

Falls diese Eigenschaft ausserhalb von OnCalculate() verwendet wird, sollte vorher ein entsprechender Test auf Null-Reference z.B. mit *if* (Bars != *null*) ausgeführt werden.

### Beispiel
```cs
//Anwendung in einem 30 Minuten Chart
TimeFrame tf = (TimeFrame) Bars.TimeFrame;
Print(Bars.TimeFrame); // liefert "30 Min"
Print(tf.Periodicity); // liefert "Minute"
Print(tf.PeriodicityValue); // liefert "30"
```

## Bars.TicksCountInTotal
### Beschreibung
Bars.TicksCountInTotal liefert die Gesamtzahl aller Ticks von dem Moment an, von dem die Funktion aufgerufen wird.

Siehe auch weitere [*Eigenschaften*](#eigenschaften) von Bars.

### Parameter
keine

### Rückgabewert
Typ int

### Verwendung
Bars.TicksCountInTotal

### Weitere Informationen
Der Datentyp int hat einen positiven Wertebereich von 2147483647.Wenn 10 Ticks je Sekunde angenommen werden, gibt es auch nach 2 Handelsmonaten bei einem 24h-Handel noch kein Überlauf.

Innerhalb von  [*OnCalculate()*](#oncalculate) kann diese Eigenschaft verwendet werden, ohne vorher auf Null-Reference testen zu müssen. Sobald die Methode OnCalculate() von AgenaScript aufgerufen wird, ist immer auch ein Bars Objekt vorhanden.

Falls diese Eigenschaft ausserhalb von  OnCalculate(),  verwendet wird, sollte vorher ein entsprechender Test auf Null-Reference z.B. mit *if* (Bars != *null*) ausgeführt werden.

### Beispiel
```cs
Print("Die Gesamtanzahl der gelieferten Ticks in diesem Wert beträgt " + Bars.TicksCountInTotal);
```

## Bars.isGrowing
### Beschreibung
Bar-Eigenschaften verwendet, wenn Bar aufwächst.

### Parameter
keine

### Rückgabewert
keine

### Beispiel
```cs
Bars[0].isGrowing;
```

## Bars.IsFalling
### Beschreibung
Bar Eigenschaften verwendet, wenn Bar fällt herunter.

### Parameter
keine

### Rückgabewert
keine

### Beispiel
```cs
Bars[0].IsFalling;
```

## Bars.TailTop
### Beschreibung
Mit dieser Eigenschaft kann man die Höhe des oberen Dochtes auslesen.

### Parameter
keine

### Rückgabewert
keine

### Beispiel
```cs
Bars[0].TailTop;
```

## Bars.TailBottom
### Beschreibung
Mit dieser Eigenschaft kann man die Höhe des oberen Dochtes auslesen

### Parameter
keine

### Rückgabewert
keine

### Verwendung
```cs
//Verwendung innerhalb eines 30-Minuten-Chart
Bars[0].TailBottom;
```

### Beispiel
**Print**("Die Gesamtmenge der Zecken ist" + Bars.TicksCountInTotal);

## ProcessingBarSeriesIndex
### Beschreibung
Gibt an, ob der aktuelle Balken zuletzt berechnet wurde.

### Parameter
keine

### Rückgabewert
Typ bool

### Verwendung
ProcessingBarSeriesIndex

### Weitere Informationen
Verwendet für komplizierte Berechnung auf einem letzten Stab

### Beispiel
```cs
protected override void OnCalculate()
        {
            base.OnCalculate();
            if (!IsProcessingBarIndexLast)
                return;
            bool isUpdated;
}
```


## Datenserien
### Beschreibung
Datenserien werden in AgenaTrader zum einen unterschieden in die frei für die eigene Programmierung verwendbaren Datenserien zum Speichern von Werten unterschiedlicher Datentypen und zum anderen in die in AgenaTrader fest integrierten Datenserien, die die Kursdaten der einzelnen Bars enthalten. Die letzteren werden hier vorgestellt.
Das Konzept von Datenserien wird sehr konsequent und durchgängig verfolgt. Alle Kursdaten der einzelnen Bars sind in Datenserien organisiert.
Folgende Datenserien sind verfügbar:

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
### Description
TimeFrames is an array of timeframe objects that contains a timeframe object for each individual bar object.

This array is only of value for indicators or strategies that use data from multiple timeframes.

A new entry is added to the array whenever a new timeframe is added to an indicator or strategy.

With **\[TimeFrameRequirements(("1 Day"), ("1 Week"))\]** the array will contain 3 entries:

TimeFrames \[0\] Timeframe of the primary data series (chart timeframe)
TimeFrames \[1\] **Print**(TimeFrames\[1\]); // returns "1 Day"
TimeFrames \[2\] **Print**(TimeFrames\[2\]); // returns "1 Week"

TimeFrames \[0\] is equivalent to [*TimeFrame*](#timeframe).

See [*MultiBars*](#multibars).

### Parameter
barSeriesIndex Index value for the various timeframes

### Usage
```cs
TimeFrames [int barSeriesIndex]
```

### Example
```cs
if (ProcessingBarSeriesIndex == 0 && ProcessingBarIndex == 0)
for (int i = BarsArray.Count-1; i >= 0; i--)
Print("The Indicator " + this.Name + " uses Bars of the Timeframe " + TimeFrames[i]);
```

##Instruments
The term "instrument" denotes a tradable value such as a stock, ETF, future etc.

An instrument has various properties that can be used in AgenaScripts created by the user:

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

With the **OnCalculate()** method you can use any properties you wish without having to test for a null reference.
As soon as the **OnCalculate()** function is called up by AgenaScript, an object will become available. If you wish to use these properties outside of **OnCalculate()**, you should first perform a test for null references using **if** (Bars != **null**)

## Instrument.Compare
### Description
The Instrument.Compare function compares two market prices whilst taking into account the correct number of decimal points. The smallest possible price change is displayed by the value TickSize. This function simplifies the otherwise time-consuming comparison using floating-point operations.

### Parameter
double value1
double value2

### Return value
Type int

1 - value1 is bigger than value2
-1 - value1 is smaller than value2
0 - value1 and value2 are equal

### Usage
```cs
Instrument.Compare(double Value1, double Value2)
```

### More Information
**Be aware this function compares prices based on TickSize.** If the ticksize of your instrument is 0.01 these prices will be rounded and compared on 2 decimal digits. If you want a regular comparation of two numbers, you should use the operator "greater than" (>) or the operator "smaller than" (<).

More infomation about [math.round()](https://msdn.microsoft.com/en-us//library/75ks3aby(v=vs.110).aspx)

If the tick size is 0,00001 – as it usually is with FX values – then the following will be displayed:

Compare(2, 1.99999) a 1, meaning 2 is bigger than 1.99999
Compare(2, 2.000001) a 0, meaning the values are equal
Compare(2, 1.999999) a 0, meaning the values are equal
Compare(2, 2.00001) a -1, meaning 2 is smaller than 2.00001

### Example
```cs
Print(Instrument.Compare(2, 1.999999));
```

## Instrument.Currency
### Description
Instrument.Currency outputs a currency object that contains the corresponding currency in which the instrument is traded.

### Parameter
None

### Return Value
A constant of the type "public enum currencies"

### Usage
Instrument.Currency

### More Information
The common currencies are: AUD, CAD, EUR, GBP, JPY or USD.

### Example
```cs
Print(Instrument.Name + " is traded in " + Instrument.Currency);
```

## Instrument.Digits
### Description
Instrument.Digits outputs the number of decimal points in which the market price of the instrument is traded.

### Parameter
none

### Return Value
int Digits

### Usage
Instrument.Digits

### More Information
Stocks are usually traded to two decimal points. Forex can be traded (depending on the data provider) with 4 or 5 decimal places.

This function is especially useful when formatting the output of various instruments that need rounding. Also see [*TickSize*](#ticksize) and [*Instrument.Round2Ticks*](instrumentround2ticks), [*Instrument.Round2TickSize*](#instrumentround2ticksize).

More information can be found here: *Formatting of Numbers*.

### Example
```cs
Print("The value of " +Instrument.Name + " is noted with a precision of " + Instrument.Digits +" Decimal points.");
```

## Instrument.ETF
### Description
Instrument.ETF is used to differentiate between a stock and an ETF. This is necessary since ETFs are considered to be „stocks" by some exchanges.

### Parameter
none

### Return Value
Type bool

### Usage
Instrument.ETF

### More Information
What is an ETF?

Wikipedia: [*http://de.wikipedia.org/wiki/Exchange-traded\_fund*](http://de.wikipedia.org/wiki/Exchange-traded_fund*)

### Example
```cs
if (Instrument.InstrumentType == InstrumentType.Stock)
if (Instrument.ETF)
Print("The value is an ETF.");
else
Print("The value is a stock.");
```

## Instrument.Exchange
### Description
Instrument.Exchange outputs the description/definition of the current exchange for the current instrument.

### Parameter
none

### Return Value
An exchange object of the type "public enum exchanges"

### Usage
Instrument.Exchange

### More Information
An overview of various exchange: *https://en.wikipedia.org/wiki/List\_of\_stock\_exchanges*

### Example
```cs
Print("The instrument " + Instrument.Name +" is traded on the " + Instrument.Exchange + " exchange.");
```

## Instrument.Expiry
### Description
Instrument.Expiry outputs the date (month and year) of the expiry of a financial instrument. Only derivative instruments such as options or futures will have an expiry date.

### Parameter
None

### Return Value
Type DateTime

For instruments without an expiry date the returned value is set to DateTime.MaxValue(= 31.12.9999 23.59:59)

### Usage
Instrument.Expiry

### More Information
The expiry date (expiry) can also be seen within the Instrument Escort:

![Instrument.Expiry](./media/image5.png)

### Example
```cs
Print("The instrument " + Instrument.Name +" will expire on " + Instrument.Expiry);
```

## Instrument.GetCurrencyFactor
### Description
Instrument.GetCurrencyFactor returns a conversion factor that can be used to convert an instrument's currency to the account's currency.

### Parameter
Type Currencies

### Return Value
Type double

### Usage
Instrument.GetCurrencyFactor(Currencies)

### More Information
Common currencies are.B. AUD, CAD, EUR, GBP, JPY oder USD.

### Example
```cs
Protected override void OnCalculate()
{
   double currFactor = Instrument.GetCurrencyFactor(Account.Currency);
   Print(Close[0] + " in " + Instrument.Currency.ToString() + " = " + (Close[0] * currFactor) + " in " + Account.Currency.ToString());
}
```

## Instrument.InstrumentType
### Description
Instrument.InstrumentType outputs a type object of the trading instrument.

### Parameter
none

### Return Value
Object of the type "public enum instrument"

### Usage
Instrument.InstrumentType

### More Information
Potential values are: future, stock, index, currency, option, CFD and unknown.

There is no ETF type. ETFs are considered to be of the type "stock" – see [*Instrument.ETF*](#instrumentetf).

The instrument type can also be viewed within the Instrument Escort:

![Instrument.InstrumentType](./media/image6.png)

### Example
```cs
Print("The instrument " + Instrument.Name + " is of the type " + Instrument.InstrumentType);
```
## Instrument.MainSector
### Description
Instrument.MainSector returns the main sector of the trading instrument.

### Parameter
none

### Return Value
String

### Usage
Instrument.MainSector

### More Information
The main sector is also visible in the instrument escort:
![Instrument.InstrumentType](./media/image6.png)
### Example
```cs
Print("Das Instrument " + Instrument.Name + " ist im Sektor " + Instrument.MainSector + " tätig.");
```

## Instrument.Margin
### Description
Instrument.MainSector returns the required margin of the trading instrument.

### Parameter
none

### Return Value
int

### Usage
Instrument.Margin

### More Information
Margin is also visible in the instrument escort:
![Instrument.InstrumentType](./media/image6.png)
### Example
```cs
Print("Das Instrument " + Instrument.Name + " has a margin of " + Instrument.Margin);
```
## Instrument.Name
### Description
Instrument.Name outputs the name/description of the trading instrument.

### Parameter
none

### Return Value
Type string

### Usage
Instrument.Name

### More Information
The instrument name can also be seen within the Instrument Escort:

![Instrument.Name](./media/image7.png)

### Example
```cs
Print("The currently loaded instrument inside the chart is named " + Instrument.Name);
```

## Instrument.PointValue
### Description
Instrument.PointValue outputs the monetary value for a full point movement of the instrument.

### Parameter
none

### Return Value
double – point value

### Usage
Instrument.PointValue

### More Information
**Example for various point values** (per amount, CFD, futures contract, lot etc.)

Stock: generally 1.00 Euro or 1.00 USD.
EUR/USD: 100,000 USD
DAX future: 25.00 Euro

**Tick Value**

The tick value can be calculated by multiplying the point value with the tick size.

For example, the E-mini S&P 500 has a point value of $50. The tick size equals 0.25. This means that there are 4 ticks in one full point for the E-mini S&P 500.
Since 50 * 0.25 = 50/4 this means that the tick value is $12.50.

The point value can also be viewed within the Instrument Escort:

![Instrument.PointValue](./media/image8.png)

### Example
```cs
Print("When " + Instrument.Name + " rises for one full point then this is equal to " + Instrument.PointValue + " " + Instrument.Currency);
```

## Instrument.Round2TickSize
### Description
The function Instrument.Round2TickSize rounds the supplied market price to the smallest value divisible by the tick size of the instrument.

### Parameter
double – market value

### Return value
double

### Usage
```cs
Instrument.Round2TickSize(double MarketPrice)
```

### More Information
The number of decimal places to which the price is rounded depends on the instrument.
If, for example, an instrument is a stock, then the rounding will be performed to 2 decimal places. For a Forex instrument, it may be carried out to 4 or 5 decimal places.

See [*TickSize*](#ticksize) and [*Instrument.Digits*](#instrumentdigits).

Example of professional [*Formatting*](#formatting), *Formatting of Numbers*.

### Example
```cs
double Price = 12.3456789;
Print(Price + " rounded for a " + Instrument.Name + " valid value is " + Instrument.Round2TickSize(Price));
```

## Instrument.Symbol
### Description
Instrument.Symbol outputs the symbol that identifies the trading instrument within AgenaTrader. Depending on the symbol, the mappings for the various data feed providers and brokers will be managed in different ways.

### Parameter
none

### Return value
Type string

### Usage
Instrument.Symbol

### More Information
By using symbols, identical stocks being traded on different exchanges can be identified and separated from each other. The symbol BMW.DE is the BMW stock on the XETRA exchange. BMW.CFG is the CFD for the BMW stock.

The instrument symbol can also be viewed within the Instrument Escort:

![Instrument.Symbol](./media/image9.png)

### Example
```cs
Print("The instrument currently loaded within the chart has the symbol: " + Instrument.Symbol);
```

## Instrument.TickSize
### Description
The tick size is the smallest measurable unit that a financial instrument can move. This is usually called 1 tick.

### Parameter
none

### Return Value
double

### Usage
Instrument.TickSize or simply TickSize

### More Information
The keyword [*TickSize*](#ticksize) is equivalent to Instrument.TickSize. Both information requests will produce the same value and are thus interchangeable.

### Example
Stock: 0.01
ES future: 0.25
EUR/USD: 0.00001

See [*Instrument.PointValue*](instrumentpointvalue) and [*Instrument.Digits*](#instrumentdigits).

Examples of professional [*Formatting*](#formatting), *Formatting of Numbers*.

### Example
```cs
Print("The value of " + Instrument.Name + " can change for a minimum of " + Instrument.TickSize + " Tick(s).");
```

## Collections
## ChartDrawings
### Description
ChartDrawings is a collection containing all drawing objects within the chart. The property hold all drawings which were generated by the script.
The index for ChartDrawings is the explicit name for the drawing object (string tag).

### Usage
ChartDrawings \[string tag\]

### Example
**Note:** To be able to use the interface definitions you must use the using method.
```cs
using AgenaTrader.Plugins;
// Output number of drawing objects within the chart and their tags
Print("The chart contains " + ChartDrawings.Count + " drawing objects.");
for each (IDrawObject draw in ChartDrawings) Print(draw.Tag);
//Draw a black trend line...
AddChartLine("MyLine", true, 10, Close[10], 0, Close[0], Color.Black, DashStyle.Solid, 3);
// ... and change the color to red
ITrendLine line = (ITrendLine) ChartDrawings["MyLine"];
if (line != null) line.Pen.Color = Color.Red;
// Set all lines within the chart to a line strength of 3,
// and lock it so that it cannot be edited or moved
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
### Description
InSeries is a [*DataSeries*](#dataseries) object in which the input data for an indicator or strategy is stored.

If the indicator is used without any explicit instructions for the input data, then the closing price for the current market prices will be used.

When calling up the SMA(20) the smoothing average is calculated on the basis of the closing prices for the current chart price data (this is equivalent to SMA(close,20).

InSeries\[0\] = Close\[0\].

When calling up the SMA(high, 20) the high price values are loaded and used for the calculation of the smoothing average.

InSeries\[0\] = High\[0\].

This way you can select which data series should be used for the calculation of the indicator.

**double** d = **RSI**(**SMA**(20), 14, 3)\[0\]; calculates the 14 period RSI using the SMA(20) as the input data series.
InSeries\[0\] = SMA(20)\[0\].

### Usage
```cs
InSeries
InSeries[int barsAgo]
```

### Example
```cs
Print("The input data for the indicators are " + Input[0]);
```

## Lines
### Description
Lines is a collection that contains all [*LevelLine*](#levelline) objects of an indicator.

When a line object is added to the indicator using the [*Add()*](#add) method, this line is automatically added to the "lines" collection.

The order of the add commands determines how these lines are sorted. The first information request of Add() will create Lines\[0\], the next information request will be Lines\[1\] etc.

See [*Plots*](#plots).

### Usage
```cs
Lines[int index]
```

### Example
```cs
// Add "using System.Drawing.Drawing2D;" for DashStyle
protected override void OnInit()
{
Add(new LevelLine(Color.Blue, 70, "Upper")); // saves into Lines[0]
Add(new LevelLine(Color.Blue, 30, "Lower")); // saves into Lines[1]
}
protected override void OnCalculate()
{
// When the RSI is above 70, properties of the lines will be changed
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
### Description
PlotColors is a collection that contains all color series of all plot objects.

When a plot is added using the [*Add()*](#add) method it automatically creates a color series object and is added to the PlotColors collection.

The order of the add commands determines how the plot colors are sorted. The first information request of Add() will create PlotColors\[0\], the following information request will create PlotColors\[1\] etc.

### Usage
```cs
PlotColors[int PlotIndex][int barsAgo]
```

### More Information
More information regarding the collection class:
[*http://msdn.microsoft.com/en-us/library/ybcx56wz%28v=vs.80%29.aspx*](http://msdn.microsoft.com/en-us/library/ybcx56wz%28v=vs.80%29.aspx)

### Example
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
// Set line strength (width) to 4
pen = new Pen(Color.Empty, 4);
// Add three plots with the defined line strength to the chart
Add(new OnPaint(pen, PlotStyle.LevelLine, "SMA20" )); //attached to PlotColors[0]
Add(new OnPaint(pen, PlotStyle.LevelLine, "SMA50" )); //attached to PlotColors[1]
Add(new OnPaint(pen, PlotStyle.LevelLine, "SMA100")); //attached to PlotColors[2]
IsOverlay = true;
}
protected override void OnCalculate()
{
// Add values to the three plots
SMA20.Set (SMA(20) [0]);
SMA50.Set (SMA(50) [0]);
SMA100.Set(SMA(100)[0]);
// Change colors depending on the trend
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
### Description
Plots is a collection that contains the plot objects of an indicator.

When a plot object is added to an indicator using the Add() method, it is also automatically added to the "plots" collection.

The order of the add commands determines how the plots are sorted. The first Add() information request will create Plots\[0\], the following information request will create Plots\[1\] etc.

See [*Lines*](#lines).

### Usage
```cs
Plots[int index]
```

### Example
```cs
protected override void OnInit()
{
Add(new OnPaint(Color.Blue, "MySMA 20")); // saved to Plots[0]
}
protected override void OnCalculate()
{
Value.Set(SMA(20)[0]);
// If the market price is above the SMA colorize it green, otherwise red
if (Close[0] > SMA(20)[0])
	Plots[0].PlotColor = Color.Green;
else
	Plots[0].PlotColor = Color.Red;
}
```

## Values
### Description
Values is a collection that contains the data series objects of an indicator.

When a plot is added to an indicator using the Add() method, a value object is automatically created and added to the "values" collection.

The order of the add commands determines how the values are sorted. The first information request will create Values\[0\], the next information request will create Values\[1\] etc.

**Value** is always identical to Values\[0\].

### Usage
```cs
Outputs[int index]
Outputs[int index][int barsAgo]
```

### More Information
The methods known for a collection, Set() Reset() and Count(), are applicable for values.

Information on the class collection:
[*http://msdn.microsoft.com/en-us/library/ybcx56wz%28v=vs.80%29.aspx*](http://msdn.microsoft.com/en-us/library/ybcx56wz%28v=vs.80%29.aspx)

### Example
```cs
// Check the second indicator value of one bar ago and set the value of the current indicator value based on it.
if (Outputs[1][1] < High[0] - Low[0])
Value.Set(High[0] - Low[0]);
else
Value.Set(High[0] - Close[0]);
```

## Multibars
### Description
An indicator or a strategy will always have the same underlying timeframe-units as those units being displayed within the chart. The values of an SMA(14) indicator displayed in a 5 minute chart will be calculated based on the last fourteen 5 minute bars. A daily chart, on the other hand, would use the closing prices of the past 14 days in order to calculate this value.
The same method applies for your self-programmed indicators. A 5 minute chart will call up the [*OnCalculate()*](#oncalculate) for each 5 minute bar.
If you want your self-created indicator to use a different timeframe, this is possible using multibars.

### Example
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
    // The indicator requires daily and weekly data
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
            // The current value for the SMA 14 in the timeframe of the chart
            Print("TF0: " + SMA(Closes[0], 14)[0]);
            // The current value for the SMA 14 in a daily timeframe
            Print("TF1: " + SMA(Closes[1], 14)[0]);
            // Current value for the SMA 14 in a weekly timeframe
            Print("TF2: " + SMA(Closes[2], 14)[0]);
        }
    }
}
```

### Additional Notes
When using additional timeframes, a further entry with the respective data series for the bars of the new timeframe will be added to the arrays [*Opens*](#opens), [*Highs*](#highs), [*Lows*](#lows), [*Closes*](#closes), [*Medians*](#medians), [*Typicals*](#typicals), [*Weighteds*](#weighteds), [*Times*](#times) and [*Volumes*](#volumes). The indexing will occur in the order of the addition of the new timeframes.
Closes\[0\]\[0\] is equivalent to Close\[0\].
Closes\[1\]\[0\] equals the current closing price for the daily data series
Closes\[2\]\[0\] equals the current closing price for the weekly data series

"Closes" is, of course, interchangeable with Opens, Highs, Lows etc.

See [*ProcessingBarIndexes*](#processingbarindexes), [*ProcessingBarSeriesIndex*](#processingbarseriesindex), [*TimeFrames*](#timeframes), [*TimeFrameRequirements*](timeframerequirements).

Additional syntax methods are available for multibars:
```cs
// Declare the variable TF_DAY and define it
private static readonly TimeFrame TF_Day = new TimeFrame(DatafeedHistoryPeriodicity.Day, 1);
private static readonly TimeFrame TF_Week = new TimeFrame(DatafeedHistoryPeriodicity.Week, 1);
// The following instruction is identical to double d = Closes[1][0];
double d = MultiBars.GetBarsItem(TF_Day).Close[0];
// The following instruction is identical to double w = Closes[2][0];
double w = MultiBars.GetBarsItem(TF_Week).Close[0];
```

## ProcessingBarIndexes
### Description
ProcessingBarIndexes is an array of int values that contains the number of [*ProcessingBarIndex*](#processingbarindex) for each bar.

This array is only of value for indicators or strategies that use data from multiple timeframes.

A new entry is added to the array whenever a new timeframe is added to an indicator or strategy.

With **\[TimeFrameRequirements(("1 Day"), ("1 Week"))\]** the array will contain 3 entries:

ProcessingBarIndexes\[0\] Current bar for the primary data series (chart timeframe)
ProcessingBarIndexes\[1\] Current bar for the daily bars
ProcessingBarIndexes\[2\] Current bar for the weekly bars

ProcessingBarIndexes\[0\] is equivalent to [*ProcessingBarIndex*](#processingbarindex).

Also see [*MultiBars*](#multibars).

### Parameter
barSeriesIndex Index value for the various timeframes

### Usage
```cs
ProcessingBarIndexes[int barSeriesIndex]
```

### Example
```cs
//Ensure that a minimum of 20 bars is loaded
for (int i=0; i<ProcessingBarIndexes.Count; i++)
if (ProcessingBarIndexes[i] < 20) return;
```

## ProcessingBarSeriesIndex
### Description
Within a multibars script, multiple bars objects are available. The OnCalculate() method
will therefore also be called up for every bar within your script. In order to include/exclude events of specific data series, you can use the ProcessingBarSeriesIndex property.

ProcessingBarSeriesIndex is only of value for indicators or strategies that use data from multiple timeframes.
With **\[TimeFrameRequirements("1 Day", "1 Week")\]** two timeframes will be added to the primary chart timeframe.

If OnCalculate() is called up by the primary data series, then ProcessingBarSeriesIndex will equal zero. If OnCalculate() is called up by the daily bars, then ProcessingBarSeriesIndex will equal 1. Weekly bars will have a value of 2.

See [*Multibars*](#multibars) and [*ProcessingBarIndexes*](#processingbarindexes).

### Parameter
none

### Usage
ProcessingBarSeriesIndex

### More Information
Within a script that only works with primary timeframes, the value will always equal zero.

### Example
```cs
// To demonstrate the methodology
// set CalculateOnClosedBar=false
Print(Time[0] + " " + ProcessingBarSeriesIndex);
// Calculate only for the chart timeframe
protected override void OnCalculate()
{
if (ProcessingBarSeriesIndex > 0) return;
// Logic for the primary data series
}
```
