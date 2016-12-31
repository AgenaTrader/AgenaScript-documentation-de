![AgenaTrader](./images/logo_100.png)

**The following API documentation requires AgenaTrader in version 1.9.0.563**

#Welcome to the official AgenaScript documentation!

Want to learn more about the AgenaTrader scripting language? We've got the resources to help you get started. Start by browsing the documentation on the list below.

##Introductory Words
AgenaScript is AgenaTrader’s integrated programming language. The syntax is derived from C\# and thus closely resembles it.

AgenaScript allows you to execute any ideas/methods that are too complex for the ConditionEscort. From simple indicators to entire applications where AgenaTrader is only required to run in the background, anything that can be written in .NET can be implemented.

Information contained in this help document:

[Handling bars and instruments](./handling_bars_and_instruments.md#handling-bars-and-instruments)

You will find a detailed explanation of how AgenaScript reacts and interacts with individual bars or candles as well as various trading instruments.

[Events](./events.md#events)

AgenaScript is event-based and -driven. When (for example) a candle closes or a new candle opens, then an event has occurred. When a new price value is delivered by your data provider or a new order is executed by your broker, then these too are considered events. AgenaScript allows you to react to these events. You can read about the exact methodology in this and the following chapters.

[Strategy programming](./strategy_programming.md#strategy-programming)

AgenaScript allows you to create your own trading strategies and execute them live within the market. Information pertaining to prerequisites and how orders are sent to the broker and managed internally can be found here.

[Keywords](./keywords.md#keywords)

Like every other programming language, AgenaTrader has a set of commands that can be converted and used via Scripts. You should be relatively well versed in these if you wish to create your own indicators or trading systems.

[Drawing objects](./drawing_objects.md#drawing-objects)

All drawing objects that can be used within the chart can also be accessed using AgenaScript. In this way, you can turn on/off certain lines, arrows, rectangles and other objects with specified conditions.

[Hints and advice](./hints_and_advice.md#hints-and-advice)

This section provides solutions to problems of an unusual nature. To solve such problems, you need to be able to trace and understand source code and programming. More advanced programmers and users may find solutions and suggestions that could help them in their own programming.
