local ok, ffi = pcall( require, 'ffi' )

ffi = ok and ffi or nil

local function asserteq( x, y )
	assert( type(x) == type(y) and type(x) == 'table', 'wrong types')
	assert( #x == #y, 'length mismatch')
	for i = 1, #x do
		assert( x[i] == y[i], ('%d: %s ~= %s'):format( i, tostring(x[i]), tostring(y[i])))
	end
end

local sort = require'mergesort'

asserteq( sort{1,2,3,1,2,3,1,2}, {1,1,1,2,2,2,3,3} )
asserteq( sort{8,7,6,5,4,3,2,1}, {1,2,3,4,5,6,7,8} )
asserteq( sort{1,2,3,4,5,1,2,3}, {1,1,2,2,3,3,4,5} )

local N = 1e4
local a, b, c = {}, {}, {}
for i = 1, N do
	a[i] = math.random()
	b[i] = a[i]
end

table.sort( a )
sort( b )

for i = 1, N do
	if a[i] ~= b[i] then
		print( a[i], 'not equals to', b[i] )
		error()
	end
end

for _, n in ipairs{100,1000,10000,100000,1000000,10000000} do
	collectgarbage()
	local a, b, c, buffer = {}, {}, {}, {}
	for i = 1, n do
		a[i] = math.random()
		b[i] = a[i]
		c[i] = a[i]
		buffer[i] = 0
	end

	local d, db, f, fb
	if ffi then
		d, db, f, fb = ffi.new( 'double[?]', n ), ffi.new( 'double[?]', n), ffi.new( 'float[?]', n), ffi.new( 'float[?]',n)
		for i = 0, n-1 do
			d[i] = a[i+1]
			f[i] = a[i+1]
		end
	end

	-- table.sort
	collectgarbage()
	local t1 = os.clock()
	table.sort(a)
	local t2 = os.clock()

	-- mergesort
	collectgarbage()
	local t3 = os.clock()
	sort(b)
	local t4 = os.clock()
	
	-- mergesort prealloc
	collectgarbage()
	local t5 = os.clock()
	sort(c, nil, buffer)
	local t6 = os.clock()

	collectgarbage()
	local t7 = os.clock()
	table.sort(a)
	local t8 = os.clock()

	collectgarbage()
	local t9 = os.clock()
	sort(b)
	local t10 = os.clock()
	
	collectgarbage()
	local t11 = os.clock()
	sort(c, nil, buffer)
	local t12 = os.clock()


	print( 'N', n )
	print( 'table.sort uniform', t2 - t1 )
	print( 'table.sort sorted', t8 - t7 )
	print( 'mergesort uniform', t4 - t3 )
	print( 'mergesort sorted', t10 - t9 )
	print( 'mergesort prealloc uniform', t6 - t5 ) 
	print( 'mergesort prealloc sorted', t12 - t11 ) 
	
	if ffi then
		collectgarbage()
		local t13 = os.clock()
		sort(d, nil, db, n, 0)
		local t14 = os.clock()

		collectgarbage()
		local t15 = os.clock()
		sort(f, nil, fb, n, 0)
		local t16 = os.clock()
	
		print( 'ffi' )
		print( 'mergesort doubles', t14-t13 )
		print( 'mergesort floats', t16-t15 )
	end

	for i = 1, n do
		if a[i] ~= b[i] then
			error()	
		end
	end
end


