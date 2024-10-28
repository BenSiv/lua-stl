package.path = "src/?.lua;" .. package.path

local stl = require("stl")

local function test_basic_solid()

    local solid = stl.create_solid("trig")

    solid = stl.add_facet(
        solid,
        {0,0,1},
        {0,0,0},
        {1,0,0},
        {1,1,0}
    )
    
    solid = stl.add_facet(
        solid,
        {0,0,1},
        {0,0,0},
        {0,1,0},
        {1,1,0}
    )
    
    local stl_results = stl.encode_solid(solid)
    print(stl_results)
end

-- test_basic_solid()

local function test_polygon()

    -- local solid = stl.polygon({{0,0,0},{0,0,1}}) -- only 2 points
    -- local solid = stl.polygon({{0,0,0},{0,0,"1"},{0,1,1}}) -- incorrect type
    -- local solid = stl.polygon({{0,0,0},{0,0,1},{0,0,1}}) -- duplicate points
    local solid = stl.polygon({{0,0,0},{0,0,1},{0,1,1},{1,1,1}})
    
    local stl_results = stl.encode_solid(solid)
    print(stl_results)
end

-- test_polygon()

local function test_square()

    -- local solid = stl.square(5)
    local solid = stl.square(5, true)
    
    local stl_results = stl.encode_solid(solid)
    print(stl_results)
end

-- test_square()

local function test_rectangle()

    -- local solid = stl.square(5, 7)
    local solid = stl.rectangle(5, 7, true)
    
    local stl_results = stl.encode_solid(solid)
    print(stl_results)
end

-- test_rectangle()

local function test_circle()

    local solid = stl.circle(5, 20)
    
    local stl_results = stl.encode_solid(solid)
    print(stl_results)
end

-- test_circle()