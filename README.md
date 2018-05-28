# Stream data parsing test assessment

input data has the following format
```
--targetboundary
Content-Type: 'text/plain'
Content-Length: 2048

Events[0].Some.Nested.Field=value
Events[0].Some.Nested.Array[0]=value
Events[0].Some.Nested.Array[1]=value
...

---targetboundary
Content-Type: 'image/jpeg'
Content-Length: 20480

binary data ...
```

The goal is to convert text data within the target boundary into the form that can allow to extract random data
easily i.e Hash. `piperator` gem here is just for fun. It has some drawbacks and not quite usefull.
Got to find a better alternative or just give up using Ruby in favour of `Elixir` :)

While `Payload` class seems to be overkill it's actually quite handy in parsing data like in the example above.
Going to find a better application for it.
