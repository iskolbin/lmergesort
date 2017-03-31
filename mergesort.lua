--[[

 mergesort -- v1.1.2 Lua non-recursive merge sort implementation
 no warranty implied; use at your own risk

 Based on code snipplet taken from StackOverflow
 http://stackoverflow.com/questions/1557894/non-recursive-merge-sort

 author: Ilya Kolbin (iskolbin@gmail.com)
 url: github.com/iskolbin/lmergesort

 COMPATIBILITY

 Lua 5.1, 5.2, 5.3, LuaJIT 1, 2 (including FFI arrays)

 LICENSE
 
 See end of file for license information

--]]

local function lt( x, y )
	return x < y
end

return function( a, cmp, b, num, pad )
	cmp, b, num, pad = cmp or lt, b or {}, num or #a, pad or 1
	
	local k = 1
	while k < num do
		for left = 0, num-k-1, k+k do
			local rght = left + k
			local rend = rght + k

			if rend > num then
				rend = num
			end

			local m, i, j = left, left, rght

			while i < rght and j < rend do
				if cmp( a[i+pad], a[j+pad] ) then
					b[m+pad] = a[i+pad]
					i = i + 1
				else
					b[m+pad] = a[j+pad]
					j = j + 1
				end
				m = m + 1
			end

			while i < rght do
				b[m+pad] = a[i+pad]
				i, m = i + 1, m + 1
			end

			while j < rend do
				b[m+pad] = a[j+pad]
				j, m = j + 1, m + 1
			end

			for l = left, rend-1 do
				a[l+pad] = b[l+pad]
			end
		end

		k = k + k
	end
	return a
end

--[[

-------------------------------------------------------------------------------
This software is available under 2 licenses -- choose whichever you prefer.
-------------------------------------------------------------------------------
ALTERNATIVE A - MIT License
Copyright (c) 2017 Ilya Kolbin
Permission is hereby granted, free of charge, to any person obtaining a copy of 
this software and associated documentation files (the "Software"), to deal in 
the Software without restriction, including without limitation the rights to 
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
of the Software, and to permit persons to whom the Software is furnished to do 
so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all 
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE 
SOFTWARE.
------------------------------------------------------------------------------
ALTERNATIVE B - Public Domain (www.unlicense.org)
This is free and unencumbered software released into the public domain.
Anyone is free to copy, modify, publish, use, compile, sell, or distribute this 
software, either in source code form or as a compiled binary, for any purpose, 
commercial or non-commercial, and by any means.
In jurisdictions that recognize copyright laws, the author or authors of this 
software dedicate any and all copyright interest in the software to the public 
domain. We make this dedication for the benefit of the public at large and to 
the detriment of our heirs and successors. We intend this dedication to be an 
overt act of relinquishment in perpetuity of all present and future rights to 
this software under copyright law.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN 
ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION 
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

--]]
