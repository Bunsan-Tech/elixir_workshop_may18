Problem 1 - Pragmatic Bookshelf
-------------------------------

Pragmatic Bookshelf has offices in Texas (TX) and North Carolina (NC),
so we have to charge sales tax on orders shipped to these states. The
rates can be expressed as a keyword list

```elxir
tax_rates = [ NC: 0.075, TX: 0.08 ]
```

Here’s a list of orders:

```elixir
orders = [
  [ id: 123, ship_to: :NC, net_amount: 100.00 ],
  [ id: 124, ship_to: :OK, net_amount:  35.50 ],
  [ id: 125, ship_to: :TX, net_amount:  24.00 ],
  [ id: 126, ship_to: :TX, net_amount:  44.80 ],
  [ id: 127, ship_to: :NC, net_amount:  25.00 ],
  [ id: 128, ship_to: :MA, net_amount:  10.00 ],
  [ id: 129, ship_to: :CA, net_amount: 102.00 ],
  [ id: 120, ship_to: :NC, net_amount:  50.00 ] ]
```

Write a function that takes both lists and returns a copy of the orders,
but with an extra field, total_amount which is the net plus sales tax. If a
shipment is not to NC or TX, there’s no tax applied

Problem 2 - Word Count
----------------------

You'll be given a text and yout task is count the frequency of every word in the text,
and then print these frequencies on the console.

Problem 3 - Scape from Zurg
---------------------------

Buzz, Woody, Rex, and Hamm have to escape from Zurg. They merely have to cross one last bridge before they are free. However, the bridge is fragile and can hold at most two of them at the same time. Moreover, to cross the bridge a flashlight is needed to avoid traps and broken parts. The problem is that our friends have only one flashlight with one battery that lasts for only 60 minutes. The toys need different times to cross the bridge (in either direction):

|Toy   | Time |
-------|------|
|Buzz  | 5    |
|Woody | 10   |
|Rex   | 20   |
|Hamm  | 25   |


Since there can be only two toys on the bridge at the same time, they cannot cross the bridge all at once. Since they need the flashlight to cross the bridge, whenever two have crossed the bridge, somebody has to go back and bring the flashlight to those toys on the other side that still have to cross the bridge. The problem now is: In which order can the four toys cross the bridge in time (that is, within 60 minutes) to be saved from Zurg?
