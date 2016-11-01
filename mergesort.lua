-- http://stackoverflow.com/questions/1557894/non-recursive-merge-sort
local function lt( x, y )
	return x < y
end

return function( a, cmp, b )
	cmp, b = cmp or lt, b or {}
	
	local rght, wid, rend
	local i, j, m, t
	local num = #a
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
				if cmp( a[i+1], a[j+1] ) then
					b[m+1] = a[i+1]
					i = i + 1
				else
					b[m+1] = a[j+1]
					j = j + 1
				end
				m = m + 1
			end

			while i < rght do
				b[m+1] = a[i+1]
				i, m = i + 1, m + 1
			end

			while j < rend do
				b[m+1] = a[j+1]
				j, m = j + 1, m + 1
			end

			for l = left, rend-1 do
				a[l+1] = b[l+1]
			end
		end

		k = k + k
	end
	return b
end
