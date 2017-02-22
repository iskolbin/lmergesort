--[[

 mergesort -- v1.1.0 public domain Lua merge sort implementation
 no warranty implied; use at your own risk

 Based on code snipplet taken from StackOverflow
 http://stackoverflow.com/questions/1557894/non-recursive-merge-sort

 author: Ilya Kolbin (iskolbin@gmail.com)
 url: github.com/iskolbin/lmergesort

 COMPATIBILITY

 Lua 5.1, 5.2, 5.3, LuaJIT 1, 2

 LICENSE

 This software is dual-licensed to the public domain and under the following
 license: you are granted a perpetual, irrevocable license to copy, modify,
 publish, and distribute this file as you see fit.

--]]

local function lt( x, y )
	return x < y
end

return function( a, cmp, b, num, pad )
	cmp, b, num, pad = cmp or lt, b or {}, num or #a, pad or 1
	
	local rght, wid, rend
	local i, j, m, t
	local k = 1

	while k < num do
		for left = 0, num-k-1, k+k do
			rght = left + k
			rend = rght + k

			if rend > num then
				rend = num
			end

			m, i, j = left, left, rght

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
