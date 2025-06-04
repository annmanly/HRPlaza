--!Type(UI)

--[[


  pNotify
  A simple notification system for displaying alerts to players.

  Usage:
  pNotify.Notify({
    type = "success",
    title = "Title",
    message = "Message",
    duration = 5,
    autoHide = true,
    audio = true,
    audioShader = alertSound,
    scope = "local",
    player = client.localPlayer
  })

  Parameters:
  - type: The type of notification to display. (default, success, error, warning, info)
  - title: The title of the notification.
  - message: The message to display in the notification.
  - duration: The time in seconds before the notification automatically hides. (default: 3)
  - autoHide: Whether the notification should automatically hide after the timeout. (default: false)
  - scope: The scope of the notification. (local, global)
  - player: The player to display the notification to. (required for local scope)

  Example:
  local pNotify = require("pNotify")
  pNotify.Notify({
    type = "success",
    title = "Score Updated!",
    message = "You have earned 10 points!",
    duration = 5,
    autoHide = true,
    audio = true,
    audioShader = "alertSound",
    scope = "local",
    player = client.localPlayer
  })

]]

--!Bind
local _pnotify : UILuaView = nil

local notificationQueue = {}
local activeNotifications = 0
local maxNotifications = 3

local types = {
  default = "default",
  success = "success",
  error = "error",
  warning = "warning",
  info = "info"
}

-- Function to display next notification in the queue
local function displayNextNotification()
  if activeNotifications < maxNotifications and #notificationQueue > 0 then
    local nextNotification = table.remove(notificationQueue, 1)
    local success = DisplayNotification(nextNotification)

    if success then
      return true
    else
      return false
    end
  end
end

--[[
  Function to display a notification.

  @param options:table - The options for the notification.
]]
function DisplayNotification(options)
  options.animation = options.animation or {}
  options.sounds = options.sounds or {}
  
  local options = {
    type = options.type or "success",
    message = options.message or "Hello, there!",
    title = options.title or "Notification",
    duration = options.duration or 3,
    autoHide = options.autoHide or false,
    audio = options.audio or false,
    audioShader = options.audioShader or "alertSound",
    scope = options.scope or "local",
    player = options.player or nil
  }

  if options.type then
    if not types[options.type] then
      print("Invalid notification type. Please provide a valid type. (default, success, error, warning, info)")
      return
    end
  end

  if options.duration then 
    if type(options.duration) ~= "number" then
      print("Duration must be a number. Please provide a valid number in seconds.")
      return
    end

    if options.duration < 0 then
      print("Duration must be a positive number. Please provide a valid number in seconds.")
      return
    end

    if options.duration > 320 then
      print("Duration must be less than 320 seconds. Please provide a valid number in seconds.")
      return
    end
  end

  if options.audio then
    if type(options.audio) ~= "boolean" then
      print("Audio must be a boolean. Please provide a valid boolean value.")
      return
    end

    if not options.audioShader then
      print("Audio shader not found. Please provide an audio shader to play the alert sound.")
      return
    end
  end

  if options.autoHide then
    if type(options.autoHide) ~= "boolean" then
      print("AutoHide must be a boolean. Please provide a valid boolean value.")
      return
    end
  end

  if options.scope then
    if options.scope ~= "local" and options.scope ~= "global" then
      print("Invalid scope. Please provide a valid scope. (local, global)")
      return
    end

    if options.scope == "global" then
      if options.player then
        print("Player is not required for global scope. Please remove the player from the options.")
        return
      end
    end

    if options.scope == "local" then
      if not options.player then
        print("Player is required for local scope. Please provide a player in the options.")
        return
      else
        if options.player ~= client.localPlayer then
          print("Player is not the local player. Please provide the local player in the options.")
          return
        end
      end
    end
  end

  if options.player then
    if client.localPlayer ~= options.player then
      return
    end
  end
  
  -- Create a new notification
  local _type = VisualElement.new()
  _type:AddToClassList("notification")
  _type:AddToClassList("pnotify_type__" .. options.type)

  local notification = VisualElement.new()
  notification:AddToClassList("pnotify_layout")

  local content = VisualElement.new()
  content:AddToClassList("pnotify_content")

  local titleContainer = VisualElement.new()
  titleContainer:AddToClassList("pnotify_title_container")

  local title = UILabel.new()
  title:AddToClassList("pnotify_title")
  title:SetPrelocalizedText(tostring(options.title))
  titleContainer:Add(title)

  local textContainer = VisualElement.new()
  textContainer:AddToClassList("pnotify_text_container")

  local text = UILabel.new()
  text:AddToClassList("pnotify_text")
  text:SetPrelocalizedText(tostring(options.message))
  textContainer:Add(text)

  content:Add(titleContainer)
  content:Add(textContainer)

  notification:Add(content)
  _type:Add(notification)

  _pnotify:Add(_type)

  activeNotifications = activeNotifications + 1

  
  local interval = nil


  local function clearNotification()
    _type:AddToClassList("fadeOut")
    Timer.After(0.5, function()

      if interval ~= nil then
        interval:Stop()
        interval = nil
      end

      _pnotify:Remove(_type)
      activeNotifications = activeNotifications - 1
      displayNextNotification()  -- Display next notification in the queue
    end)
  end

  if options.autoHide then
    interval = Timer.After(options.duration, clearNotification)
  end

  _type:RegisterPressCallback(clearNotification)

  _pnotify:BringToFront()
  return true
end

-- Function to add notification to the queue
function Notify(options)
  table.insert(notificationQueue, options)
  local success = displayNextNotification()

  return success
end