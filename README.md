Lua mergesort
=============

Non recursive Lua merge sort implementation ported from [snipplet taken from StackOverflow](http://stackoverflow.com/a/17957133). It's nobraininer port, for example indexing should be optimized to increase performance a bit. 

Usage
-----

```lua
local sort = require('mergesort')
local a = sort{1,2,3,1,2,3} -- sort returns it's result
local b = sort({1,2,3,1,2,3}, function(a,b) return a > b )
local c = sort({1,2,3,1,2,3}, nil, {0,0,0,0,0,0,0}) -- use preallocated buffer
```

Simple test and benchmark included, the results are quite interesting. While vanilla Lua 5.2.4 table.sort is about 10 times faster than this implementation, on LuaJIT 2.1 I had approx. 30% speed gain. Yep, sometimes __pure Lua code faster than built-in functions__ :).
