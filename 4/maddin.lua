sortedStr = function(strIn)
  retArray = { }
  for i = 1, #strIn do
    local c = strIn:sub(i,i)
    retArray[i] = c
  end
  table.sort(retArray)
  return retArray
end

eq = function (e1,e2) return (e1==e2) end
isAnagram = function (e1,e2)
  if(string.len(e1)~=string.len(e2)) then
    return false
  end
  sortedE1 = sortedStr(e1)
  sortedE2 = sortedStr(e2)
  for i = 1,table.getn(sortedE1),1 do
    if(sortedE1[i] ~= sortedE2[i]) then
      return false
    end
  end
  return true
end

containsMatch = function (func,pass)
  local list = string.gmatch(pass, "%S+")

  array = {}
  for e in list do
    array[#array + 1] = e
  end

  length = table.getn(array)
  for i=1,length,1 do
    for j=1,length,1 do
      if (j ~= i) and func(array[i],array[j]) then
        return 0
      end
    end
  end
  return 1
end

function map(func, array)
  local new_array = {}
  for i,v in ipairs(array) do
    new_array[i] = func(v)
  end
  return new_array
end

function curry(f)
  return function (x) return function (y) return f(x,y) end end
end

local inStr = {"abc cba","acb acbd"}
local result = map(curry(containsMatch) (isAnagram),inStr)

-- TODO replace this with a reduce
local sum = 0
for i = 1,table.getn(result),1 do
  sum = sum + result[i]
end
--

print(sum)
