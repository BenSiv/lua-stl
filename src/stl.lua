require("utils").using("utils")

local stl = {}

local function create_solid(name)
    local solid = {
        name = name,
        facets = {}
    }
    return solid
end

local function add_facet(solid, orientation, v1, v2, v3)
    local facet = {
        orientation = {
            x = orientation[1],
            y = orientation[2],
            z = orientation[3]
        },
        vertices = {
            [1] = {
                x = v1[1],
                y = v1[2],
                z = v1[3]
            },
            [2] = {
                x = v2[1],
                y = v2[2],
                z = v2[3]
            },
            [3] = {
                x = v3[1],
                y = v3[2],
                z = v3[3]
            }
        }

    }
    table.insert(solid.facets, facet)
    return solid
end

local function encode_solid(solid)
    local encoded_tbl = {}
    
    local facet_orientation
    local vertex_position

    table.insert(encoded_tbl, "solid " .. solid.name)
    for _, fct in pairs(solid.facets) do
        facet_orientation = {"\tfacet", "normal", fct.orientation.x, fct.orientation.y, fct.orientation.z}
        table.insert(encoded_tbl, table.concat(facet_orientation, " "))
        table.insert(encoded_tbl, "\t\touter loop")
        for _, vtx in pairs(fct.vertices) do
            vertex_position = {"\t\t\tvertex", vtx.x, vtx.y, vtx.z}
            table.insert(encoded_tbl, table.concat(vertex_position, " "))
        end
        table.insert(encoded_tbl, "\t\tendloop")
        table.insert(encoded_tbl, "\tendfacet")
    end
    table.insert(encoded_tbl, "endsolid")

    local encoded_str = table.concat(encoded_tbl, "\n")
    return encoded_str
end

function point_to_string(point)
    return table.concat(point, ",")
end

function validate_points(points)
    if length(points) < 3 then
        print("The points table must contain at least 3 points.")
        return false
    end

    local seen_points = {}

    for i, point in ipairs(points) do
        if type(point) ~= "table" or length(point )~= 3 then
            print("Point at index " .. i .. " must be a table with exactly 3 numerical values.")
            return false
        end

        for j, coord in ipairs(point) do
            if type(coord) ~= "number" then
                print("Coordinate in point " .. i .. " at index " .. j .. " must be a number.")
                return false
            end
        end
    
        local point_str = point_to_string(point)
        if seen_points[point_str] then
            print("Duplicate point found at index " .. i .. ": " .. point_str)
            return false
        end
        seen_points[point_str] = true

    end

    return true
end

local function polygon(points)
    local solid = create_solid("polygon")
    
    if not validate_points(points) then
        return nil
    end

    facet_num = length(points) - 2

    for fct = 1, facet_num do
        solid = stl.add_facet(
            solid,
            {0,0,1},
            points[0+fct],
            points[1+fct],
            points[2+fct]
        )
    end

    return solid
end

local function square(size, centered)
    centered = centered or false
    local points

    if centered then
        local hs = size/2 -- half size
        points = {
            {-hs,-hs,0},
            {-hs,hs,0},
            {hs,-hs,0},
            {hs,hs,0}
        }
    else
        points = {
            {0,0,0},
            {size,0,0},
            {0,size,0},
            {size,size,0}
        }
    end

    local solid = polygon(points)
    return solid
end

local function rectangle(width, height, centered)
    centered = centered or false
    local points

    if centered then
        local hw = width / 2  -- half width
        local hh = height / 2 -- half height
        points = {
            {-hw, -hh, 0},
            {-hw, hh, 0},
            {hw, -hh, 0},
            {hw, hh, 0}
        }
    else
        points = {
            {0, 0, 0},
            {width, 0, 0},
            {0, height, 0},
            {width, height, 0}
        }
    end

    local solid = polygon(points)
    return solid
end


stl.create_solid = create_solid
stl.add_facet = add_facet
stl.encode_solid = encode_solid
stl.polygon = polygon
stl.square = square
stl.rectangle = rectangle

return stl