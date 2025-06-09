--!Type(Module)

EVENTS ={
  showGemRequest = Event.new("showGemRequest"),
  showGemResponse = Event.new("showGemResponse")
}

function pickTwoRandomDistinct(tbl)
    -- Make a shallow copy to avoid modifying original table
    local copy = {}
    for i, v in ipairs(tbl) do
        copy[i] = v
    end

    -- Fisher-Yates shuffle
    for i = #copy, 2, -1 do
        local j = math.random(1, i)
        copy[i], copy[j] = copy[j], copy[i]
    end

    -- Return first two elements}
    return {copy[1], copy[2]}
end

function is_in_table(t, value)
  for _, v in t do
    if v == value then
      return true
    end
  end
  return false
end

function is_in_inventory_table(tbl, item)
  for _, v in tbl do
    if v.id == item then
      return true
    end
  end
  return false
end

function find_inventory_index(tbl, item)
  -- Iterate over the table using ipairs for ordered tables
  for index, value in ipairs(tbl) do
      -- Check if the current element is equal to the item we are searching for
      if value.id == item then
          return index -- Return the index if item is found
      end
  end
  return nil -- Return nil if item is not found in the table
end

function PrintTable(t, indent)
  indent = indent or ''
  for k, v in pairs(t) do
    if type(v) == 'table' then
      print(indent .. k .. ' :')
      PrintTable(v, indent .. '  ')
    else
      print(indent .. k .. ' : ' .. tostring(v))
    end
  end
end

function is_table_equal(t1,t2,ignore_mt)
  local ty1 = type(t1)
  local ty2 = type(t2)
  if ty1 ~= ty2 then return false end
  -- non-table types can be directly compared
  if ty1 ~= 'table' and ty2 ~= 'table' then return t1 == t2 end
  -- as well as tables which have the metamethod __eq
  local mt = getmetatable(t1)
  if not ignore_mt and mt and mt.__eq then return t1 == t2 end
  for k1,v1 in pairs(t1) do
     local v2 = t2[k1]
     if v2 == nil or not is_table_equal(v1,v2) then return false end
  end
  for k2,v2 in pairs(t2) do
     local v1 = t1[k2]
     if v1 == nil or not is_table_equal(v1,v2) then return false end
  end
  return true
end
  
function GetPositionSuffix(position: number): string
  if position == 1 then
    return "1st"
  elseif position == 2 then
    return "2nd"
  elseif position == 3 then
    return "3rd"
  else
    return tostring(position) .. "th"
  end
end

-- Function to deep copy a table (testing)
function DeepCopy(original)
  local copy = {}
  for k, v in pairs(original) do
    if type(v) == "table" then
      copy[k] = DeepCopy(v)
    else
      copy[k] = v
    end
  end
  return copy
end

-- Function to add or remove a class from an element
function AddRemoveClass(element, class: string, add: boolean)
  if add then
    element:AddToClassList(class)
  else
    element:RemoveFromClassList(class)
  end
end

-- Activate the object if it is not active
function ActivateObject(object)
  if not object.activeSelf then
    object:SetActive(true)
  end
end

-- Deactivate the object if it is active
function DeactivateObject(object)
  if object.activeSelf then
    object:SetActive(false)
  end
end

-- Activate all objects in the list
function ActivateObjects(objects)
  for _, object in ipairs(objects) do
    ActivateObject(object)
  end
end

-- Deactivate all objects in the list
function DeactivateObjects(objects)
  for _, object in ipairs(objects) do
    DeactivateObject(object)
  end
end

-- Function to print a table
function PrintTable(t, indent)
  indent = indent or ''
  for k, v in pairs(t) do
    if type(v) == 'table' then
      print(indent .. k .. ' :')
      PrintTable(v, indent .. '  ')
    else
      print(indent .. k .. ' : ' .. tostring(v))
    end
  end
end

-- Function to get the count of a table
function GetCount(t)
  local count = 0
  for _ in pairs(t) do count = count + 1 end
  return count
end

function FormatNumberWithCommas(amount: number)
  local formattedNumber = tostring(amount)
  local reverseFormatted = formattedNumber:reverse():gsub("(%d%d%d)", "%1,"):reverse()

  -- Remove any leading commas if the number is less than 1,000
  if reverseFormatted:sub(1, 1) == "," then
      reverseFormatted = reverseFormatted:sub(2)
  end

  return reverseFormatted
end

function CombineTables(tableOfTable)
  local combinedTable = {}
  for _, table in ipairs(tableOfTable) do
    for _, value in ipairs(table) do
      table.insert(combinedTable, value)
    end
  end
  return combinedTable
end

-- Function to trim text and replace it with an ellipsis if it exceeds the specified length
function TrimText(text: string, maxLength: number)
    if text:len() > maxLength then
        return text:sub(1, maxLength - 3) .. "..."
    else
        return text
    end
end

function SortScores(topScoreTable)
  -- Create a sortable list of players with score
  local sortableScores = {}
  for playerName, playerInfo in topScoreTable do
      table.insert(sortableScores, {playerName = playerInfo.playerName, playerScore = playerInfo.playerScore})
  end

  -- Sort the list by score in descending order
  table.sort(sortableScores, function(a, b)
      return a.playerScore > b.playerScore
  end)

  -- Extract the top scores (up to the number of players available)
  local numPlayers = #sortableScores
  local topScoresCount = math.min(numPlayers, 10)

  local topScores = {}
  local iTopScores = {}
  for i = 1, topScoresCount do
      topScores[sortableScores[i].playerName] = sortableScores[i]
      table.insert(iTopScores, sortableScores[i])
  end

  return topScores, iTopScores;
end

function findMaxKey(tbl)
  local maxKey = nil
  local maxValue = -math.huge -- Start with negative infinity as initial maximum value

  for key, value in pairs(tbl) do
      if value > maxValue then
          maxValue = value
          maxKey = key
      elseif value == maxValue then
          maxValue = value
          maxKey = nil
      end
  end

  return maxKey
end

function formatNumber(num)
  local absNum = math.abs(num)
  local suffix = ""
  local formatted = num

  if absNum < 1000 then
      return tostring(formatted)
  end

  -- Determine the appropriate suffix and scaling factor
  if absNum >= 1e12 then
      formatted = num / 1e12
      suffix = "T"  -- Trillion
  elseif absNum >= 1e9 then
      formatted = num / 1e9
      suffix = "B"  -- Billion
  elseif absNum >= 1e6 then
      formatted = num / 1e6
      suffix = "M"  -- Million
  elseif absNum >= 1e3 then
      formatted = num / 1e3
      suffix = "K"  -- Thousand
  end

  -- Truncate the number to the required number of decimal places
  local function truncateToDecimalPlaces(value, decimalPlaces)
      local multiplier = 10^decimalPlaces
      return math.floor(value * multiplier) / multiplier
  end

  -- Ensure we always have exactly 3 digits before the suffix
  if formatted >= 100 then
      formatted = math.floor(formatted)  -- No decimals for numbers 100 or more
  elseif formatted >= 10 then
      formatted = truncateToDecimalPlaces(formatted, 1)  -- One decimal for numbers 10 to 99.9
      -- Convert to string with one decimal place
      formatted = math.floor(formatted * 10) / 10  -- Truncate to 1 decimal without rounding
      formatted = string.format("%.1f", formatted)  -- Ensure it shows 1 decimal
  else
      formatted = truncateToDecimalPlaces(formatted, 2)  -- Two decimals for numbers below 10
      -- Convert to string with two decimal places
      formatted = math.floor(formatted * 100) / 100  -- Truncate to 2 decimals without rounding
      formatted = string.format("%.2f", formatted)  -- Ensure it shows 2 decimals
  end

  -- Return the formatted number as a string with the suffix
  return formatted .. suffix
end

function formatNumberSimple(num)
  local absNum = math.abs(num)
  local suffix = ""
  local formatted = num

  if absNum < 1000 then
      return tostring(formatted)
  end

  -- Determine the appropriate suffix and scaling factor
  if absNum >= 1e9 then
      formatted = num / 1e9
      suffix = "B"  -- Billion
  elseif absNum >= 1e6 then
      formatted = num / 1e6
      suffix = "M"  -- Million
  elseif absNum >= 1e3 then
      formatted = num / 1e3
      suffix = "K"  -- Thousand
  end

  -- Truncate the number to 2 significant digits
  formatted = math.floor(formatted * 100) / 100  -- Keep 2 decimal places

  -- Convert to string with 2 significant digits and append the suffix
  return string.format("%.1f", formatted) .. suffix
end

function find_next_highest(list, current)
  local next_highest = nil
  for _, value in ipairs(list) do
      if value > current then
          if next_highest == nil or value < next_highest then
              next_highest = value
          end
      end
  end
  if next_highest == nil then
      next_highest = list[#list]
  end

  return next_highest
end

function find_highest_beneath(list, current)
  local highest_beneath = nil
  for _, value in ipairs(list) do
      if value < current then
          if highest_beneath == nil or value > highest_beneath then
              highest_beneath = value
          end
      end
  end

  if highest_beneath == nil then
      highest_beneath = 0
  end
  return highest_beneath
end

-- Function to find the closest object in a table
function FindClosestObject(currentPosition, objectsToCheck)
  local closestObject = nil
  local shortestDistance = math.huge  -- Equivalent to Mathf.Infinity in Unity's C#

  -- Loop through all the objects in the array
  for _, obj in ipairs(objectsToCheck) do
      if obj ~= nil then
          -- Calculate the distance between the current position and the object
          local distance = Vector3.Distance(currentPosition, obj.transform.position)

          -- Check if this object is closer than the previously checked ones
          if distance < shortestDistance then
              shortestDistance = distance
              closestObject = obj
          end
      end
  end

  -- Return the closest object found
  return closestObject
end

-- Function to map a value from 0 to 1 to 0 -> 1 -> 0
function mapTo01To0(x)
  return 4 * x * (1 - x)
end

-- Function to find the index of a value in a table
function find_index(tbl, value)
  for i, v in ipairs(tbl) do
    if v == value then
      return i
    end
  end
  return 999999
end

function convertSecondsToMinSec(seconds)
  -- Ensure the input is a valid number
  if type(seconds) ~= "number" or seconds < 0 then
      return "Invalid input"
  end

  -- Calculate minutes and seconds
  local minutes = math.floor(seconds / 60)
  local remainingSeconds = seconds % 60

  -- Format the output as "min:sec" with zero-padding for seconds if needed
  return string.format("%d:%02d", minutes, remainingSeconds)
end

function unixToHMS(unixTime)
  local hrs = math.floor(unixTime / 3600)
  local mins = math.floor((unixTime % 3600) / 60)
  local secs = unixTime % 60

  if hrs > 0 then
      return string.format("%dh%dm", hrs, mins)
  else
      return string.format("%dm%ds", mins, secs)
  end
end

function self:ServerAwake()
  EVENTS.showGemRequest:Connect(function(player, gemID)
    EVENTS.showGemResponse:FireAllClients(player, gemID)
  end)
end