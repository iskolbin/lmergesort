![Build Status](https://travis-ci.org/iskolbin/lmergesort.svg?branch=master)
[![license](https://img.shields.io/badge/license-public%20domain-blue.svg)]()

Mergesort
=========

Non recursive Lua merge sort implementation ported from
[snipplet taken from StackOverflow](http://stackoverflow.com/a/17957133).
It's nobrainer port, for example indexing could be optimized to increase
performance a bit.

Useage
------

Requiring library yields sorting function which accepts up to 5 arguments.
When called with 1 or 2 argument it behaves like `table.sort`, i.e. sort
array in ascending order if comparator(second argument) is not provided.

`sort( src )`
`sort( src, comparator )`

If third argument provided it's used as resulting buffer:

`sort( src, comparator, buffer )`

Note, you cannot use `src` as `buffer`! Also It's possible to
pass length of sorting array and offset from where to start.

`sort( src, comparator, buffer, length )`
`sort( src, comparator, buffer, length, offset )`

```lua
local sort = require('mergesort')
local a = sort{1,2,3,1,2,3} -- sort returns it's result, creating new table
local b = sort({1,2,3,1,2,3}, function(a,b) return a > b end ) -- using custum comparator
local c = sort({1,2,3,1,2,3}, nil, {0,0,0,0,0,0,0}) -- use preallocated buffer (which returned to c variable)
```

Because it's plain Lua you can actually use it to sort LuaJIT FFI-created arrays
of any type. Note that they are indexed from zero, not one like Lua tables,
you need to pass more parameters to function.

```lua
local ffi = require( 'ffi' )
local a = ffi.new( 'double[?]', 6, 1, 2, 3, 1, 2, 3 )
local b = ffi.new( 'double[?]', 6 )
b = sort( a, nil, b, 6, 0 ) -- we need to pass length(6) and starting index(0)
```

Benchmark
---------

Simple test and benchmark included, see `bench.lua`. The results are quite
interesting. While vanilla Lua 5.2.4 `table.sort` is about 10 times faster
than this implementation, on LuaJIT 2.1 I had approx. __30% speed gain__.
Sorting FFI arrays is slower than sorting tables. Yep, sometimes pure Lua
code just faster than super optimized built-in functions :).

Results of sorting uniform distributed arrays of 10 000 000 elements in seconds:

case               | time(seconds)
-------------------|--------------
table.sort         | 4.953
mergesort          | 3.972
mergesort prealloc | 3.831
mergesort doubles  | 4.524
mergesort floats   | 5.453

Tested on iMac Core i5 2.9 GHz, 32 Gb RAM, LuaJIT 2.1.0-beta1 (torch7).
