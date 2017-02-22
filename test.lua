local mergesort = require('mergesort')

local array1, array2 = {}, {}
local N = 10000
for i = 1, N do
	array1[i] = math.random()
	array2[i] = array1[i]
end

table.sort( array1 )
mergesort( array2 )

for i = 1, N do
	assert( array1[i] == array2[i] )
end

local gt = function( a, b )
	return a > b
end

table.sort( array1, gt )
mergesort( array2, gt )

for i = 1, N do
	assert( array1[i] == array2[i] )
end

local array1, array2, array3, array4 = {}, {}, {}, {}
local M = 100
local sub1, sub2, sub3 = {}, {}
for i = 1, N do
	array1[i] = math.random()
	array2[i], array3[i], array4[i] = array1[i], array1[i], array1[i]
end
for i = 1, M do
	sub1[i] = array1[i]
	sub2[i] = array1[i+900]
end

mergesort( array3, nil, nil, 100 )
mergesort( array3, nil, nil, 100, 901 )
table.sort( sub1 )
table.sort( sub2 )
for i = 1, M do
	assert( array3[i] == sub1[i] )
	assert( array3[i+900] == sub2[i] ) 
end
for i = M+1, 900 do
	assert( array3[i] == array4[i] )
end

local ok, ffi = pcall( require,  'ffi' )
if ok then
	local a = ffi.new( 'double[?]', 6, 1, 2, 3, 1, 2, 3 )
	local b = ffi.new( 'double[?]', 6 )
	b = mergesort( a, nil, b, 6, 0 ) -- we need to pass length(6) and starting index(0)
	for i, v in ipairs{ 1, 1, 2, 2, 3, 3 } do
		assert( v == b[i-1] )
	end
end
