package.path = "../src/?.lua;" .. package.path

local stl = require("stl")

local triangle = stl.create_solid("trig")

triangle = stl.add_facet(
    triangle,
    {0,0,1},
    {0,0,0},
    {1,0,0},
    {1,1,0}
)

triangle = stl.add_facet(
    triangle,
    {0,0,1},
    {0,0,0},
    {0,1,0},
    {1,1,0}
)

print(stl.encode_solid(triangle))