f = function (pass)
  local list = string.gmatch(pass, "%S+")

  array = {}
  for e in list do
    array[#array + 1] = e
  end

  length = table.getn(array)
  for i=1,length,1 do
    for j=1,length,1 do
      if (j ~= i) and (array[i] == array[j]) then
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

local inStr = {
    "beispiel valider passphrase",
    "beispiel invalid , da invalid"}
local result = map(f,inStr)
local sum = 0
for i = 1,table.getn(result),1 do
  sum = sum + result[i]
end

print(sum)
