local function readonly(t)
    return setmetatable({}, {
        __index = t,
        __newindex = function(_, k, _)
            error("Attempt to modify read-only field: " .. tostring(k))
        end
    })
end

return readonly