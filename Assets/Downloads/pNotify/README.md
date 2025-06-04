# Interactive Notifications

## Description

This resource is a simple notification system that can be used to display messages to players. It is highly customizable and can be used to create alerts, notifications, and more.

## Features

- Locally and globally displayed notifications
- 4 different types of notifications
- Easy to use
- Responsive design
- Clickable notifications

## Installation

1. Download the latest version.
2. Drag and drop the `Alerts` prefab into your hierarchy.
3. Select the prefab and `enable/disable` Test Notifications to test the notifications.
4. Run your project and test the notifications.
5. Feel free to customize the notifications as needed.

## Usage

To use this resource, you can simply call the `pNotify` function with the following parameters:

```lua
local pNotify = require("pNotify")
```

To display a notification locally, you can use the following code:

```lua
pNotify.Notify({
  type = "default",
  title = "Welcome back!",
  message = client.localPlayer.name .. " it's good to see you again!",
  duration = 5,
  autoHide = true,
  audio = true,
  audioShader = "alertSound",
  scope = "local",
  player = client.localPlayer
})
```

To display a notification globally, you can use the following code:

```lua
pNotify.Notify({
  type = "default",
  title = "Welcome back!",
  message = client.localPlayer.name .. " it's good to see you again!",
  duration = 5,
  audio = true,
  audioShader = "alertSound",
  autoHide = true,
  scope = "global"
})
```

## Parameters

- `type` (string): The type of notification to display. Can be `default`, `success`, `error`, or `warning`.
- `title` (string): The title of the notification.
- `message` (string): The message of the notification.
- `duration` (number): The time in seconds before the notification disappears.
- `autoHide` (boolean): Whether the notification should automatically hide after the timeout.
- `scope` (string): The scope of the notification. Can be `local` or `global`.
- `player` (Player): The player to display the notification to. Only required if the scope is `local`.
- `audio` (boolean): Whether to play an audio notification.
- `audioShader` (string): The name of the audio shader to play (only required if `audio` is true).

## Alert Sounds

To add more sounds to the notifications, head to `pNotify.lua` and locate `audioShaders`. Create a serialized field for the new sound and add it to the list.

> Note: The audio shaders must be defined as strings in the `audioShaders` table.

```lua
--!SerializeField
local alertSound : AudioShader = nil -- (Default sound)
--!SerializeField
local myCustomSound : AudioShader = nil -- (Custom sound)

-- Map the audio shaders to their names
local audioShaders = {
  ["alertSound"] = alertSound, -- (Default sound)
  ["myCustomSound"] = myCustomSound -- (Custom sound)
}

-- Assuming you want to use the custom sound
pNotify.Notify({
  audioShader = "myCustomSound",
})
```

## Video Tutorial
> Note: This video is outdated but still provides a good overview of the resource.

<iframe width="100%" height="100%" style={{"aspect-ratio":"16/9"}} src="https://www.youtube.com/embed/eqofWbfBhEk" title="YouTube Video Player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

## Contributing

This resource is open-source and contributions are welcome. If you would like to contribute, please fork the repository and submit a pull request.
