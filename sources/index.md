![AgenaTrader](./images/logo_100.png)

**The following API documentation requires AgenaTrader in version 1.9.0.563**

AgenaScript ist eine in die Handelsplattform AgenaTrader integrierte Programmiersprache. Die Syntax von AgenaScript ist von der Programmiersprache C# abgeleitet.
Mit AgenaScript können alle Anliegen umgesetzt werden, die z.B. für den Condition Escort zu komplex sind. Das Spektrum reicht von der Programmierung eines einfachen Indikators bis hin zu eigenen Applikationen, bei denen AgenaTrader sozusagen nur noch im Hintergrund benötigt wird. Generell sind alle Dinge umsetzbar, die auch in DotNet realisierbar sind: Indikatoren fast beliebiger Komplexität, Signalanzeige, Excel-Export, Auswertungen, Chartanzeigen, Sound, Farben uvm.


Information contained in this help document:

[Ereignisse](./Ereignisse.md#Ereignisse)

AgenaScript arbeitet ereignisorientiert. Wenn z.B. eine Kerze in einer Zeiteinheit abgeschlossen ist und eine neue Kerze beginnt, ist dies ein Ereignis. Wenn neue Kurse vom Datenanbieter geliefert werden oder eine Order vom Broker ausgeführt wird, immer handelt es sich um Ereignisse.
Mit AgenaScript können Sie auf alle diese Ereignisse reagieren. Wie dies genau funktioniert und welche Ereignisse es gibt, ist Gegenstand dieses Abschnitts.

[Schlüsselworte](./Schlüsselworte.md#Schlüsselworte)

Wie jede Programmiersprache besitzt auch AgenaTrader einen Satz von Befehlen, die Sie in eigenen Scripts verwenden können. Mit diesen sog. Schlüsselworten sollten Sie gut vertraut sein, wenn Sie Ihre eignenen Indikatoren bzw. Handelssysteme erstellen möchten.

[Strategieprogrammierung](./Strategieprogrammierung.md#Strategieprogrammierung)

Mit AgenaScript ist es möglich, eigene Handelsstrategien zu erstellen um diese live im Markt handeln zu lassen.
Welche Voraussetzungen dazu notwendig sind und wie Orders an den Broker übergeben und intern verwaltet werden, erfahren Sie hier.

[Tipps und Tricks](./Tipps und Tricks.md#Tipps und Tricks)

In diesem Bereich werden Lösungen für nicht ganz alltägliche Probleme gezeigt. Um diese Beispiele nachvollziehen zu können, ist allerdings einiges an Erfahrung in der Programmierung Voraussetzung. Der fortgeschrittene Anwender wird hier einige Dinge finden, die er in seine eigenen Programmierungen übernehmen kann.

[Umgang mit Bars und Instrumenten](./Umgang mit Bars und Instrumenten.md#Umgang mit Bars und Instrumenten)

Hier wird im Detail gezeigt, wie mit AgenaScript auf die einzelnen Bars bzw. Kerzen und auf verschiedene Handelsinstrumente zugegriffen werden kann.

[Zeichenobjekte](./Zeichenobjekte.md#Zeichenobjekte)

Alle Zeichenobjekte, die Sie im Chart verwenden können, sind auh über AgenaScript erreichbar. So können Sie z.B. Linien, Pfeile, Rechtecke, Kreise usw. an bestimmten Stellen im Chart automatisch anzeigen und wieder entfernen lassen. Die Möglichkeiten sind nahezu unüberschaubar.

