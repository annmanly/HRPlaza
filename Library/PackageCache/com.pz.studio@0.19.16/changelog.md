# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.19.16]

### Added

- Moderators can now speak in the Broadcast chat channel by default.
- Added more Studio and Unity tutorials for beginners.

### Fixed

- Fixed exception when calling Chat:DisplayChatBubble immediately when a player joins a world.
- Fixed exception when uploading a world if there is a UI script without a matching uss file.
- Fixed UI scripts set to World output displaying as a black box when first instantiated on mobile devices.
- Fixed Highrise Studio toolbar buttons disappearing when entering play mode if 'Switch Layout On Play Mode' is enabled.
- 'Switch Layout On Play Mode' is no longer enabled by default, it can be re-enabled in the World Settings.
- Fixed Leaderboard.SetScore and Leaderboard.IncrementScore functions when modifying score by entry Id.
- Removed 'Invalid World' error when uploading if you switch accounts after uploading a world.
- Improved Readme handling and detection when uploading an asset.

## [0.19.11]

### Added

- Added GetScaledDisplayHeight and GetScaledDisplayWidth to Lua on the client.

### Fixed

- Fixed characters not using pathfinding if you tap to move while your character is on an Off Mesh Link.
- Fixed issues related to swapping between pets with the same appearance.
- When validating a world, long audio files are now required to be set to streaming mode.
- Fixed Leaderboard.GetEntries and Leaderboard.GetEntry returning different ranks for the same entry in uploaded worlds.

## [0.19.8]

### Added

- In-scene gizmos measure the distance that objects are moved and rotated.
- Asset Catalog is now accessible as an in-scene Overlay with an improved interface.
- Common scene settings are now available as an in-scene Overlay.
- Entering Play Mode now automatically changes the window layout to feature multiple Virtual Player windows and a Simulator view. This behaviour can be disabled in the Highrise Settings.
- Object.Destroy on the server can now destroy scenes.
- Added Payments:ClosePurchasePrompt to lua on the client.

### Fixed

- Fixed crash when calling server.LoadScene
- Highrise Camera Settings overlay provides an easy way to toggle the Scene View camera between traditional HR isometric view and full 3D.
- All moderation event callbacks now have an extra parameter that is the id of the moderator
- An error will now be displayed in the console if using the bind attribute in lua and the corresponding UI element cannot be found.
- Fixed players getting kicked from worlds when using moderation actions
- Fixed player entries appearing above the channel they are in when joining an empty voice channel in worlds.

## [0.19.5]

### Added

- Added Character.MoveStarted event.
- Added UILabel.titlecase.
- Added 'Teleport if too far' and 'Teleport Distance' to PetFollowBehavior
- Added SetFollowTarget and TeleportToTarget to PetFollowBehavior so it can be used with NPCs and can follow any transform.
- Added OnBan, OnUnban, OnKick, OnMute and OnUnmute events to the moderation API.
- Added optional closeWithoutSaving callback to UI:OpenCloset

### Fixed

- Fixed ScriptableObject references being nil on the client if there is a circular reference
- Fixed the type of Character.state displaying as number and not CharacterState.
- Fixed not being able to create serialized fields of lua script types from the Highrise Studio package.
- Fixed nil exception in PetCharacterController.
- Fixed players spawning in the wrong position when using spawn points in Studio.
- Fixed the closet UI not displaying properly in Studio when not using the device simulator

## [0.19.4]

### Added

- RegisterPressCallback and RegisterLongPressCallback now return a Callback object which can be passed to UnregisterCallback.
- Formatting has been added to storage values in the Storage Viewer.

### Fixed

- Fixed clothing item previews not loading.
- Fixed ranks being wrong when adding new leaderboard entries in Studio.
- Fixed the pressEffect, sound and haptic parameters for RegisterPressCallback and RegisterLongPressCallback not working.

## [0.19.3]

### Added

- Added players and playerCount to client and server in lua.
- Added spectatorCount, scenes, and sceneCount to server in lua.
- Added name to Scene on both the Client and Server.
- Added Instantiate to Scene on the Server.
- Added isModerator and isAgeVerifiedAbove18 to Player.
- Added isAgeVerifiedAbove18 to User.
- Added earnedGold to WalletState.
- Added Wallet.TransferGold to lua on the server to send gold by User ID.
- Added locale to WorldInstanceInfo.
- A profile for each virtual player is now automatically created in a Profiles folder.  You can now customize the name and outfit of each virtual player by editing their profile.
- A 'Edit Profile' button has been added to the virtual player window.
- Added a 'DefaultPet' outfit which can be used to test pets with virtual players.
- Added Random.RangeInt to lua on the Client.

### Fixed

- Fixed worlds not appearing in the world list when uploading a world when you have created or joined more than 20 worlds.
- Fixed the wrong thumbnails showing up in the room info UI when using virtual players.

## [0.19.1]

### Added

- Added Leaderboard Viewer (Highrise > Studio > Leaderboard Viewer) for viewing and editing local leaderboard data.
- Added Add button to the Storage Viewer
- Added BanPlayer, KickPlayer, MutePlayer, UnmutePlayer to Moderation API
- Ban, Kick, Mute, and Unmute in the Moderation API now accept a user ID 
- Added skeletonId to Pet which can be used to identify what kind of pet it is
- Added activePlayers, and IsPlayerActiveChannel to ChannelInfo on the Client and Server
- Added isActive and isJoined to ChannelInfo on the Client
- Added IsPlayerInChannel to ChannelInfo on the Server
- Added activeChannel to Chat on the Client
- Added GetChannel to Chat on the Client and Server
- Added activeChannel to Player on the Client and Server
- Setting a default value is no longer needed for variables in lua marked with SerializeField.

### Fixed

- Fixed error when entering play mode if a GameObject, tag, or a string marked with SerializeField contains brackets, quotes or escape characters.
- Fixed compilation error if the default value of a string marked with SerializeField contains brackets
- Fixed lua scripts not updating when only the default value of a variable marked with SerializedField is changed.
- Fixed LuaScriptableObjects, AudioClips, AudioShaders, Scenes, CharacterOutfits, and Shaders not being able to be added to asset catalog asset uploads.
- Fixed UI elements drawing on top of the toolbar in studio when using the landscape layout.

## [0.19.0] - 2025/03/04

### Added

- Added musicVolume property to Audio
- Added fadeIn parameter to Audio:PlayMusicURL
- Added a checkbox when uploading a world for the first time to automatically enter it into the current game jam if one is currently running.
- Added Add, Edit, and Delete buttons to the Inventory Viewer
- Added CloseCloset to UI in lua

### Fixed

- Fixed music started using Audio:PlayMusic with a volume less than 1 resulting in a softer volume than intended
- Fixed virtual player windows using the wrong UI layout
- Fixed black bar on the right side of the screen in simulator mode

## [0.18.6] - 2025/02/24

### Fixed

- Fixed warning log messages when opening Clothing Editor.
- Updated API definitions, fixing errors loading Lua files in Visual Studio code.

## [0.18.5] - 2025/02/24

### Added

- Added `showOnlineIndicator` to `UIUserThumbnail` in Lua.

### Fixed

- Fixed UI in Highrise Studio not matching the Highrise app.

## [0.18.4] - 2025/02/19

### Added

- Added new Pet class to the Lua API that can be accessed through Player.pet or Character.pet.  It contains the pet's name and a unique identifier for the pet.
- Added Player.hasPet.
- Added new simplified anchor modes: stool for seats with no back, and chair for seats with a back that have to be entered from a specific direction
- When an anchor is set to custom mode, there is a new Emote animation type that allows you set an emote to play while attached to the anchor
- Added RegisterBackCallback and UnregisterBackCallback to UIView in lua for handling the android back button
- Added options.tapToMoveEnabled and options.tapHandlersEnabled to PlayerCharacterController
- GeneralChat now has 3 voice channels by default and you can select which is the default when joining the world

### Fixed

- Fixed "Method invoked with invalid signature" error when calling functions with a string parameter that is convertible to a number.
- Fixed UIs set to HUD overlapping the camera and room info buttons in landscape mode.
- Fixed lua scripts triggering recompilation each time they are edited and not only when necessary
- Fixed UIUserThumbnail and UISlider not working correctly when created in lua scripts
- Fixed exception when exiting play mode when there is a NPC in the world
- Fixed music playing from a URL not fading in or out
- Adjusted the size of the Highrise Studio toolbar buttons

## [0.18.1] - 2025/02/06

### Added

- Added validation that a studio user doesn't change a built-in layer name or interaction.
- Added option to cancel in-progress export in animation export tool.
- Added option to export items in an outfit as a png from the outfit inspector.
- Added Moderation API to lua that allows you to Mute, Ban and Kick users from lua.
- Added name, tag, CompareTag, GetComponentsInParent and GetComponentIndex to Components on the server.
- Added layer, tag, CompareTag, GetComponentsInParent, GetComponentAtIndex, GetComponentCount, and GetComponentIndex to GameObjects on the server.
- Added FloatChangeEvent and IntChangeEvent to lua for registering UI change events.
- Added Color type to the server.

### Fixed

- Fixed 'Add To Voice' and 'Remove From Voice' mini profile buttons not working in worlds
- Fixed links to Unity documentation for classes within namespaces.

## [0.17.12] - 2025/01/21

### Added

- Dragging prefabs into the scene will snap their position to collider surfaces and align to the normal of the surface. 
    - Press the **Alt** key while dragging to rotate the prefab up vector to align with the surface normal.
    - Press the **Control** key while dragging to enable grid snapping.
- Added a Built In Components category to the Asset Catalog. It contains premade prefabs that have commonly used scripting functionality.
- Added a price filter and pack filter to the Asset Catalog.
- Added a Open Pack button to installed asset packs in the Asset Catalog.
- Added a Show Asset, Open Readme, and Add Prefab to Scene buttons to assets installed from the Asset Catalog
- Added VFX, GUI, Animations, and Props as new categories to the Asset Catalog.
- Added an option to UI:OpenCloset to open to the first category tab.
- Added `Vector2Value` and `QuaternionValue`.
- `IStyle` properties can now be set directly instead of needing to create Style classes to hold the value.

### Fixed

- Fixed issues associated with having two Lua scripts with the same name in the project.

## [0.17.10] - 2025/01/14

### Added

- Added Wallet, WalletState and WalletError to the vscode extension.
- Added server.info to the vscode extension.
- Added client.info which contains the same data as server.info.
- Added isOccupied and occupant to Anchor on the client.
- Added isOccupied, occupant, Entered and Exited to Anchor on the server.
- Added anchor, player, and AnchorChanged to Character on the server.
- Added FireClients and FireAllOtherClients to Event.
- Added UIOutlinedLabel to lua.
- Added client.isEditor and server.isEditor to lua.
- Added right click options in the hierarchy for 'Snap to NavMesh' and 'Exclude from NavMesh'.
- Added new spawn point prefab, it can be added to the scene using a right click option in the hierarchy.
- Added OnCharacterSpawned event to PlayerCharacterSpawner module.
- Added validator to ensure long audio files are set to streaming.
- Added `TakeRoomSnapshot` to UI Service to capture a screenshot of the world.
- Outfit inspector & editor allows for changing of character skeleton.
- Outfit editor now lets you rotate/flip your character.
- Outfit editor now shows animations included in skeleton in addition to emotes.
- Outfit editor for pets only shows pet emotes/animations.

### Fixed

- Fixed 'could not find server.hrassets' exception.
- Fixed case where server scripts don't update in play mode after the script file is changed.
- Fixed light probes carrying over when changing scenes.
- Fixed scripts not updating after being reverted in source control.
- Fixed character walking in place after reaching their destination when moving on an uneven surface.
- Fixed crash when calling a function on a destroyed object in lua.
- Outfit editor only shows clothing for the current skeleton.

### Fixed

- Fixed potential crash when comparing `LuaFunction` callbacks.

## [0.17.2] - 2024/12/06

### Added

- `Vector2` type is now available in the server Lua scripts.
- Functions connected to `TapHandler.Tapped` now receive the tap position as a parameter.
- Animations, animator controllers, sprites, textures and materials can now be dragged and dropped into the asset catalog upload window.
- Added option to fix only errors in world validator.
- Added warning if uploading large textures.
- Added Lua API to get resolved size of a `VisualElement`.

### Changed

- Warnings no longer block world uploads in upload validator.

### Fixed

- Fixed `Component` tag related functions not working in uploaded worlds.
- Fixed `Start` being called on scene behaviours before `Start` has been called on all world prefab behaviours.
- Fixed errors when uploading a world if a Lua script references another Lua script that is unused in the scene or prefabs.

## [0.16.3] - 2024/11/22

### Fixed

- Fixed issue with timers and network events triggered by UI callbacks.
- Asset catalog assets now support multiple preview images.
- Fixed search box in the 'select world' popup when uploading a world not working.
- Adjusted sorting of worlds in the 'select world' popup so newer worlds appear first.

## [0.16.0] - 2024/11/20

### Added

- Added localization support for worlds. Documentation coming soon.
- Added `ColorUtility` type to Lua.
- Added Alpha, MultiplyAlpha, ToHex and ToLuma functions to Color in Lua.
- Added a search box to the emote selection popup in the outfit UI.
- Added `ChatBubbleTransform` to `Character` in Lua.
- It is now possible to drag and drop a folder into the asset catalog upload window.
- You can now search by ID in the select asset popup when uploading an asset to the asset catalog.
- Added info property to server in Lua that contains data about the current world instance including world owner (creatorId) and room owner (ownerId).
- Added overload of `OpenMiniProfile` to UI in Lua that takes a user id instead of a player object.
- Added network traffic monitor to studio toolbar, clicking on this opens the Lua message log window.
- Added validator to look for missing components in scenes & prefabs.
- Added screen values screenPosition and screenStartPosition  to DragGestures, LogPressGestures, PinchGestures, PressEvent, and TapEvent for use with `VisualElement.RegisterCallback`.
- Added `CharacterClothing.new()` to Lua.
- Added a `CharacterClothing` array parameter to `UI:OpenCloset()`.

### Fixed

- Uploading your world is no longer blocked if an error occurs while validating your project.
- Fixed not being able to instantiate prefabs stored on scriptable objects.
- Fixed Physics functions in lua not working for virtual players.
- When right clicking or drag and dropping a folder when uploading an asset to the asset catalog, all subfolders will also be checked for assets.
- Fixed walk animation not playing for short movements.
- Fixed monobehaviour validator not handling missing components in scenes & prefabs.

## [0.15.2] - 2024/11/01

### Added

- Updated the UI when uploading an asset to the asset catalog
- Added support for bundles to the asset catalog, double clicking a bundle will allow you to drag and drop individual prefabs included in the bundle
- You can use the 'Export Highrise Asset' when right clicking a folder, all prefabs in that folder will be automatically added to the list of assets to upload

### Fixed

- Fixed VSCode extension not loading type definitions
- Fixed error when entering play mode if your world contained UIs using the bind attribute
- Fixed being able to upload a world while there are validation errors
- The asset catalog button now opens the asset catalog window instead of the asset catalog on the website
- Fixed case where lua script changes would not be detected if the file was changed while Unity was in play mode

## [0.15.1] - 2024/10/31

### Added

- By default the default channel in worlds will now have voice disabled, and there will be a second channel players can switch to that has voice enabled
- Added Chat:SetActiveChannel function to the server
- Added Lua UI collection providers
- Added Lua bindings for https://docs.unity3d.com/ScriptReference/AnimatorStateInfo.html
- Added validation rule to warn if there are MonoBehaviours in scene on project validate
- Added static server side Lua finds for Object and GameObject
- Added button linking to asset catalog in Studio Editor

### Fixed

- Fixed objects instantiated on the server in one scene appearing in other scenes
- Fixed scriptable objects stored in serialized fields of client scripts being nil when passed to the server
- Fixed changes to the physics settings other than gravity not carrying over to the uploaded world
- Fixed socket errors when starting play mode
- Fixed a case where a virtual player window would have the wrong landscape/portrait setting when opened during play mode
- Fixed editor scripts being included in world uploads and causing build failures
- Fixed being unable to report chat messages in worlds
- Fixed RTS camera issue when for rotating screen while following player

## [0.15.0] - 2024/10/29

### Added

- New world upload dialog
- Added `Chat:DisplayChatBubble` to Lua to show a chat bubble at a transform
- Added 'Empty Highrise Scene' to the menu when creating a new scene in unity
- CharacterClothing objects defined in Clothing Collections are now accessible with .clothing

### Fixed

- Fixed exception when uploading a world if the scene contains components with missing scripts
- Fixed error when uploading a world if the unity project's name is not a valid world name
- Fixed NPCs not appearing for virtual players
- Fixed color palettes not displaying correctly in the Clothing Collections Editor

## [0.14.2] - 2024/10/10

### Fixed

- Fixed 'Unknown global' errors in the VSCode extension

## [0.14.1] - 2024/10/08

### Added

- Added `IPanel.WorldToLocal` and `IPanel.LocalToWorld` to Lua.
- Added validator to ensure there are not multiple copies of a module between the scene, world prefab and scene prefab.
- Added validator to ensure the world and scene prefabs are in the correct slots in the world settings.
- Added support for default values for `Vector2`, `Vector4`, and `Color` serialized fields.
- Added Inventory Viewer which can be accessed through **Highrise menu > Studio > Inventory Viewer**.
- Spawn points can be specified by either the 'AvatarSpawn' tag or 'CharacterSpawn' tag.
- `SceneLoader` is now a module and now has a `MovePlayerToScene` function for basic scene switching functionality.
- `Quaternion` can now be stored in serialized fields.
- Added Quaternion type to the server.
- `Object.Instantiate` on the server now accepts either Euler Vector3 or Quaternion for the rotation parameter. Position and rotation parameters are now optional.
- `Transform.rotation` is now accessible from Lua server scripts.
- Inspector now disables editor fields when in Play mode.
- New `RenderSettings` Lua API allows creators to change scene skybox and other graphics settings.

### Fixed

- Fixed `GetComponent` not returning `nil` if the component does not exist.
- Fixed `Object` and `GameObject` Find functions not working correctly with virtual players.
- Fixed default values for `Vector3` serialized fields getting ignored when they contained negative numbers or decimals without a leading zero.
- Fixed Lua compile errors not opening in VSCode when double clicked.
- Removed `Collider` from `PetCharacter` prefab.
- Fixed some methods accepting `Enum` parameters incorrectly marshaling values.

## [0.13.5] - 2024/09/30

### Added

- Added IsUsingPetType to player to check which pet a player is using
- Added GetPetForPlayer getter function in PetCharacterController

## [0.13.2] - 2024/09/24

### Added

- Added validator to ensure the same scene isn't listed multiple times in the world settings.
- Added validator to ensure unsupported mesh formats (.blend, .max, .ma, .mb) aren't present in the world (.blend support coming soon).

### Fixed

- Fixed characters being unable to use NavMeshLinks.
- Fixed characters flickering between front and back or left and right when facing specific directions relative to the camera.
- Fixed prefabs referenced in a serialized field in a ScriptableObject being nil on the server.
- Fixed prefabs referenced in a serialized field of a Component type being nil on the server.
- Fixed pets no longer following their players after being teleported.
- Fixed ScriptableObjects not being able to be sent through events.
- Fixed default values for number serialized fields being ignored in some cases.
- Fixed Unity functions in Lua that accept array-style tables not working properly.
- Fixed music volume lowering when people are speaking when you have the voice channel muted.

## Known Issues

- Prefabs referenced in a serialized field of a lua script component, character or anchor type being nil on the client.

## [0.12.11] - 2024/09/15

### Fixed

- Fixed issue affecting `NavMesh` assets in published worlds.

## [0.12.10] - 2024/09/13

### Added

- `JoystickCharacterController` Add options to move the local character and temporarily disable joystick.

### Changed

- `JoystickCharacterController` Optimize movement update data structure to save ~15% on packet size.
- Improved performance in Worlds making use of proximity chat feature.

### Fixed

- Fixed `LuaScriptableObject` assets not being included in published worlds.
- Fixed possible websocket exception, preventing Unity from entering play mode.
- Ensure `Player.CharacterChanged` event is bound to the player's environment so it doesn't get disposed on scene change.

## [0.12.9] - 2024/09/11

### Added

- Added reset buttons to the Transform inspector.
- `JoystickCharacterController`: Added an option to stop dragging the thumbstick or completely fix it in place.
- `JoystickCharacterController`: Added an option to show the thumbstick on desktop and hide it only during external input.
- `JoystickCharacterController`: Changed the script type to `Module`.
- "Upload" button now gives the option to cancel and re-upload if a world is already processing.

### Fixed

- Fixed scriptable objects in lists not loading properly.
- Fixed image validator failing to convert images to PNG.
- Fixed EXIF format JPG files not being identified as JPG files.
- Fixed error on upload for .obj files.
- Fixed error when opening the storage viewer if there is no storage data.
- Fixed issues with movement angles being incorrect depending on the camera angles.
- Fixed input not working in virtual player windows when 'Simulate Multi-Touch' is enabled.
- `LuaScript` types now work with `GameObject.AddComponent()`.

## [0.12.6] - 2024/09/09

### Added

- LuaScript assets may now be referenced in serialized fields within Lua scripts.
- Added `PetCharacterController` script, enabling the ability to create and manage pets in a world.
- Added a default pet behavior script, `PetFollowTraitBehavior`, which gives pets the ability to follow a character around in a world.
- Added `VisualElement.pickingMode` to Lua API.
- Added "randomize" button to Outfit Editor.
- Added ability to like items in the Outfit Editor, and added a liked items tab.

### Changed

- `LuaScriptableObject` now uses the generic scriptable object icon instead of the Lua icon.
- Removed travel button from the UI when in play mode in studio to match the Highrise app.

### Fixed

- Fixed issue where `ScriptableObject` instances only referenced by other `ScriptableObject` would not load on client side.
- Fixed the emote UI being empty when in play mode in studio.
- Fixed colliders from one virtual player scene overlapping another virtual player scene.
- Fixed world and scene variants displaying the wrong message in the inspector in prefab mode.
- Fixed Tooltip and Header attributes not working if the string contained a commas.
- Fixed chat bubbles not appearing in virtual player windows.
- Fixed music ducking being inconsistent when people are speaking in worlds.
- Fixed multiple characters not being able to use an OffMeshLink at the same time.
- Fixed VSCode not opening for lua scripts.
- Fixed 'Render Pipeline Converter' and 'Show in Explorer' menu options not appearing in the default layout.
- Fixed .obj models with a corresponding .mtl file not displaying correctly in uploaded worlds.
- Fixed UIs set to Hud mode not covering the entire width of the screen.
- Fixed tap handlers activating outside of their range when 'Check Distance' is enabled and 'Move To' is disabled.
- Fixed Unity crash when `LuaScriptableObject` assets have no script set.
- Fixed camera prefabs not matching the settings of the default scene camera.

## [0.12.2] - 2024/08/23

### Added

- Added a new `UIThumbstick` control. This is a 2D onscreen joystick for touch devices.
- Added `InputAction`, `InputActionMap` and `InputActionReference` types to provide access to keyboard and gamepad controls.
- Added a new `JoystickCharacterController` component that uses a `UIThumbstick` for character movement on mobile clients and `InputActions` for keyboard or gamepad based movement on desktop clients.
- Added a new `LongPressMiniProfileController` component that opens the miniprofile when a character is long-pressed.
- Added new `LuaScriptableObject` type, allowing creators to author re-usable data assets from Lua.
- Added `NavMesh` functions to Lua including `Raycast` and `SamplePosition`.
- Added new Player Outfit and NPC Outfit options to the create menu that automatically set the outfit's skeleton.
- Added new World Variant and Scene Variant options to the create menu.
- Added more settings to the default `GeneralChat` script to disable voice, disable proximity chat, or change the name of the default chat channel.
- Added ability to pass in a player when creating a Value (`TableValue`, `StringValue`, etc...). If a player is passed in, only that player will receive events when the value changes.
- Added fadeIn and loop parameters to `Audio:PlayMusic`.
- Added *Highrise > World Settings* menu option to access the world settings without going through the project settings.
- Added ability to favorite items in the Asset Catalog for easy access later.
- Added ability to include README files and editor scripts when uploading assets to the Asset Catalog.
- Lua scripts can now be uploaded to the Asset Catalog without being referenced by a Prefab.

### Changes

- Increased the table size limit from 255 to 4096 for Events / RemoteFunctions.
- The project validator will now report image files of types that will cause world uploads to fail. The fix button in the validator window will automatically convert those images to png.

### Fixed

- Fixed a potential crash when Lua script contains many properties.
- Fixed audio shaders with multiple clips never playing the last clip.
- Fixed `Mathf.Sign` and `Mathf.Round` returning incorrect values for negative numbers.
- Fixed `Tilemap` and `LODGroup` not working in uploaded worlds.
- Fixed `NavMeshAgent` functions not working correctly for virtual players.
- Fixed side panel UI in unity not matching the UI in the Highrise app.
- Fixed cases where a player would be unable to move to a moving Anchor.
- Fixed `Range` and `Space` attributes not working when used in Lua scripts.
- Fixed `Inventory` functions causing errors in Unity if the localInventory.txt file was empty or corrupted.
- Fixed `Payments.GetProduct` returning `InternalError` error code for non-existent products.

## [0.11.4] - 2024/08/09

### Added

- Unity layout now uses Simulator instead of Game View by default.

### Fixed

- Fixed incorrect World API version.
- Fixed terrain appearing white in uploaded worlds.
- Fixed post processing effects being missing in uploaded worlds.

## [0.11.3] - 2024/08/06

### Added

- Added "Info" tab to World Upload window, showing exported files and estimated size.
- Added equivalent Lua types for most VisualElement events.
- Added ability to purchase assets from the asset catalog using gold.
- Added ability to price uploaded assets for gold.
- Improved interface for editing Anchor components. New in-scene gizmos and buttons to fix common issues.
- Added validator window that detects and automatically fixes errors in the project when uploading.
- Added optional parameter targetSearchDistance to Character.MoveTo and Character.MoveWithinRangeOf.

### Fixed

- Avatar render issue fix to give MeshAttachments priority over RegionAttachments.

## [0.11.1] - 2024/08/01

### Added

- [Lua] UI.OpenCloset Lua API to show Closet view in worlds.
- [Lua] ClothingCollection asset type to store sets of wearable items.
- New default camera Lua scripts: First Person, Over the Shoulder, and Side Scroller.
- New built-in camera prefabs are available to use directly, or create variants of.
- Minor improvements to RTS camera keep player in screen.
- [Lua] Added all missing functions and operators to Vector3 for Lua server scripts (excepting RotateTowards and Slerp).
- [Lua] Added isSubscriber property to the Player object to indicate whether the player is a Highrise+ subscriber.
- Added ability to set up Virtual Player Profiles, which contain settings for virtual players.
- Introduced new setting for Virtual Player Profiles: Highrise Subscriber

### Fixed

- Fixed nav mesh agent incorrectly pathing to unreachable anchors.
- Fixed storage viewer not displaying properly.
- Fixed tag and layer changes in prefab overrides not working in published worlds.
- Fixed images loaded by url in .uss files not displaying in published worlds.
- [Lua] Fixed some functions generating an error when called (ex, Vector3.SmoothStep).
- [Lua] Fixed some functions not modifying the object (for example Vector3.Set).

## [0.10.4] - 2024/07/22

### Added

- Added playerCount and players to Scene.
- Added Storage Viewer (accessed through Highrise > Studio > Storage Viewer) for viewing and editing local storage data.
- Added IsDisplayed, SetDisplay, and WorldToLocal to VisualElement.
- Added support for SerializeField attribute to array-style tables.
- Added support for proximity chat.  New worlds will now use proximity chat by default.
- Added PlayerPrefs support to Lua.
- Added player follow option on RTS camera.
- Added support for reset event on RTS camera.
- Added multi-touch simulation support to VirtualPlayer.

### Changed

- Improved pinch zoom & rotate on RTS camera.

### Fixed

- Fixed crash when a LuaScript has a large number of properties.
- Chat bubbles that behind the camera are hidden.
- Fixed event.position and event.startPosition not being correctly scaled in touch events.
- Fixed SerializedFields for Vectors when using non-integer numbers.

## [0.9.4] - 2024/07/09

### Fixed

- Fixed world upload failing to export uxml files in project.

## [0.9.3] - 2024/07/08

### Fixed

- Fixed a potential exception when exiting Unity.
- Fixed players spawning below the nav mesh.
- The Lua API Payments:PromptPurchase now correctly loads world products in the editor during play mode.
- Support for default table values in Lua.

## [0.9.2] - 2024/07/02

### Added

- Added new RegisterGesture method to VisualElement which allows registering gesture handlers such as TapGesture and DragGesture
- Added Transform.Find method on server

### Fixed

- Fixed deep links not working.
- Fixed crash when destroying a spatial audio source.
- Fixed Component.gameObject returning the Transform instead of GameObject in server scripts.
- Fixed Transform.Find not working in server scripts.
- Fixed issue where Virtual Player windows would not update cameras when enabling or disabling.
- Fixed Transform.TweenLocalPosition incorrectly operating in world space.
- Fixed case where character would not move to anchor.
- Fixed a crash when destroying an object that has an unregistered event connection.

## [0.9.1] - 2024/07/02

### Fixed

- Fixed exceptions with NPCs.
- Fixed exceptions when switching between 3d and 2d worlds.
- Fixed Anchor.entered and Anchor.exited not always firing.
- Fixed bug causing avatars to spawn under the world.
- Fixed various path finding bugs.

## [0.9.0] - 2024/06/25

### Added

- Voice support has arrived for Worlds! Now all worlds have voice support enabled by default and your users can freely join audio channels and use their mics to communicate. Worlds do not need voice tokens to activate voice chat. We’ve also introduced the Channels API to give you, the World creator, control over privileges and create multiple communication channels to organize the users in the room.
- You can finally sit in 3D! Anchors have been added for sitting, etc.
- Owned Rooms With app version 4.9.0, users can now create their own (3D) Rooms (instances) within Worlds, as opposed to being randomly assigned a Room. 3D Room creation is either free or paid, and the World Creator can charge a subscription for having a Room. This can be configured via the Create Portal Dashboard.
- Added Character.MoveToAnchor to move a character to an anchor
- Added OffMeshLink support to allow jumping, teleporting, etc via OffMeshLinks
- Added Time.serverTime which is a synchronized time across all clients
- Added Character.TeleportToAnchor to teleport a character directly to an anchor
- Added Character.JumpTo to perform a jump from the current location to a given location
- Added Load methods to UIUserThumbnail to support showing a thumbnail of users by userId or player
- Added support for more UI toolkit style structures

### Fixed

- Fixed some emotes failing to load due to missing bones
- Fixed Transform.SetParent(nil) to properly remove the parent
- Fixed virtual player clicking when game window is in simulator mode
- Fixed Mini profile in virtual players so it openes in the virutal player window
- Fixed playing emotes from virtual player so they play on the virtual player properly
- Fixed world user interface not rendering after being diabled and reenabled

## [0.8.1] - 2024/06/05

### Added

- Added GetComponent, GetComponentInParent, and GetComponentInChildren methods on server.
- Added Object.Destroy method on server.
- Added TableValue.
- Added support for negative numbers as the default value of number serialized fields.
- Added support for default values of vector serialized fields.
- Added support for spatial audio.
- Added Audio:SetListenerPositionAndRotation method to controler listener for spatial audio.
- Added emote selector to outfit editor with button to copy emote identifier.
- Added warning messages for unrecognized attributes --!XX.
- Added button to the left of the play button to easily add virtual players.
- Added prefixes to logs to show which source they came from (Client, Server, Virtual Player).

### Fixed

- Fixed bug causing file copy error when opening a studio project on a clean computer.
- Fixed bug preventing multiple studio projects from being opened at the same time.
- Fixed bug with Character.SetIdle and Character.Teleport that would not stop movement if not using pathfinding.
- Fixed bug causing a timer to continue running after its host behaviour is destroyed.
- Fixed bug preventing OnDestroy from being called on client behaviours.
- Fixed bug with serialized fields that started with ' ' or `m`.
- Fixed bug when --!Bind was used in a non UI script.
- Fixed crash using .transform or .gameObject on a script before the script is run.
- Improved error reporting in lua including call stacks.
- Virtual players are now assigned a consistent userid to make testing local storage easier.

## [0.8.0] - 2024/06/05

### Added

- NPCs. You can now create and control your own NPCs. We’ve also added the ability for you to setup and control their outfits directly within Highrise Studio.
- Added support for building outfits within studio.
- Added apis for controlling outfits on characters.
- New Unity APIs. We’ve reworked the under-the-hood systems connecting Highrise Studio and Unity to expose many new Unity APIs.
- Significantly improved compile time when changing and creating new lua files.
- Enabled support for creating custom editors for lua components.
- Added support for negative values to Storage.IncrementValue api.

### Fixed

- Fixed bug that would cause lua behaviour properties to reset when you had a lua compile error
- Fixed bugs causing prefab overrides to not make it to published builds
- Fixed bug causing long running worlds to start to have networking issues such as desync and triggers not working
- Fixed bug that would cause the time on the server to be incorrect when running in studio

## [0.7.6] - 2024/05/20

### Fixed

- LuaSerializer crash fix
- Improved build manager stability and lua build time reduction
- Fix for prefab variant overrides not being included in builds
- UI guid support in factories

## [0.7.5] - 2024/05/16

### Fixed

- Reworked how Lua scripts are serialized on prefabs and scenes to help prevent data loss and be more reliable.
- Fixed crash when opening a project
- Fixed bug that would prevent entering play mode with a socket error if another studio project was opened
- Fixed panning issue in virtual players

## [0.7.1] - 2024/05/07

### Fixed

- Fixed a server/studio crash with accessing player.name during PlayerDisconnect event (crashed virtual player on exit)
- Fixed a bug importing modules
- Fixed all virtual player coordinate issues
- Fixed crash with setting a character prefab with no Character component
- Fixed the bug preventing publish from working
- Alt drag now rotates virtual players

## [0.7.0] - 2024/05/07

### Added

- Added Storage API: https://create.highrise.game/learn/studio-api/services/Storage
- Added Inventory API: https://create.highrise.game/learn/studio-api/services/Inventory
- Improved client/server stability and error handling
- Added Event.Fire method which will fire an event without networking
- Added support for creating UI elemnets at runtime with the .new operator (ex. UILabel.new())
- Added new view global on UI scripts that provides access to the attached UILuaView
- Added new unity apis

### Fixed

- Fixed user interface not working correctly in Virtual Player
- Fixed hud ui sort order so it is behind the chat history
- Fixed UI not hiding when the component or GameObject is disabled
- Fixed UI not destroying when the component is removed or GameObject destroyed
- Fixed bug in UI template for newly created UI’s that included an incorrect :Bind call
- Fixed bug with Character.usePathFinding = true which would not properly enable pathfinding
- Fixed bug causing lua scripts attached to prefabs to not run on the server
- Fixed various methods such as Transform.RotateAround and Transform.SetPositionAndRotation that were not correctly workign with virtual players
- Fixed bug with some Vector3 math operations that would cause incorrect lua errors
- Fixed Event.FireClient so it properly sends an event to just a single client

## [0.6.11] - 2024/04/24

### Fixed

- Fixed crash when entering play mode with one ore more Virtual Player(s) active
- Virtual Players will no longer overlap on large scenes
- Virtual Players will no longer generate navmesh errors in the console and fail to generate nav mesh data on larger scenes
- Fixed exception in Asset Catalog when exiting play mode
- Asset Catalog will now automatically open on new projects

## [0.6.8] - 2024/04/03

### Added

- Highrise Asset Catalog Now you have access to hundreds of pre-made assets and smart objects you can drag and drop into your world. Stay tuned for the ability to publish your own assets to the catalog to be released soon
- Unity ProBuilder Package Support Added support for ProBuilder 19. With ProBuilder, you can build, edit, and texture custom geometry in Unity with the actions and tools available in the ProBuilder package. You can also use ProBuilder to help with in-scene level design, prototyping, collision Meshes, and play-testing. Note: The ProBuilder scripting API with C# scripts is not supported
- UI Support Added support for UI via Lua UIView behaviours. Documentation to come soon
- Timers Added new Timer Lua object. Timers are automatically bound to the behaviour they were created in similar to how coroutines behave in unity. This means if the behaviour is destroyed they are automatically destroyed as well. Timers will continue to run as long as their interval has not elapsed, even if no references to the timer exist in the script and will automatically be collected when appropriate.
- Added Character.speed
- Added linear movement to characters when agent is disabled via MoveTo
- Build Status now available inside Studio

### Fixed

- Fixed issues with Lua script properties losing or changing values when used with prefabs
- Fixed bug causing ClientStart to get called multiple times or not at at all
- All custom lua behaviours are now registered as global types to enable calls such as GetComponent to work with them
- Character.MoveTo should work without an agent or when the agent is disabled
- Other bug fixes

## [0.5.18] - 2024/04/12

### Added

- Changelog button informs of new package versions and has a new look
- Uploading your project ensures all assets/scenes are saved

### Fixed

- Fixed bug where users were not being informed of required Studio Package Updates
- Fixed bug where users that hit “Remind me later” on the auto update prompt had their update dialogs prevented entirely
- Fixed layering bugs to make Not Us playable in the Hub game example

## [0.5.0] - 2024/04/10

### Added

- Publish Button changed to Upload
- Organizations removed
- Tags, Layers, and Sorting layers should now work when publishing
- Added gizmo to TapHandler to set the MoveTo distance
- Disabled/Destroyed game objects or scripts will no longer still call Update
- TapHandler MoveTo is now more reliable on larger objects
- Physics gravity setting is now included when publishing
- Avatar’s default size increased to better match world size
- Fixed occasional error when publishing worlds
- Custom WorldPrefab and ScenePrefab in settings will now publish properly
- PlayerConnected event will now be called for all players even in scene scripts
- Lua stability improvements

## [0.4.11] - 2024/03/28

### Added

- Multiple Scene Support
    - Now you can create and manage multiple scenes within your projects! Place players in different scenes for unique gameplay experiences and streamline your development process.
- Chat API
    - Introducing the new Chat API, allowing players to join chat channels for team communication, collaboration, and community engagement.
- Modules Enhancement
    - We’ve improved the Module script type to act as a singleton behavior, providing easier access and integration within your projects.
- Improved Virtual Player
    - Enhancements to the virtual player system to allow virtual players to be added and removed at any time for smoother testing and debugging.
- Remote Functions
    - Simplify communication between clients and servers with the introduction of Remote Functions, streamlining interaction and data exchange.
- Server Side Prefabs
    - Instantiate and synchronize prefabs on the server across all clients for enhanced multiplayer experiences.
- New Client/Server Lifecycle Methods
    - Streamline your networked scripts with new lifecycle methods tailored for client/server interactions.
- Tweens
    - Introducing the Tween API for easy and lightweight programmatic animations, bringing your projects to life with dynamic movement and effects.
- Indicators
    - Easily add indicators above characters or objects for visual cues and interactive elements in your games.
- Highrise World Settings
    - Simplified and reworked Highrise settings within Project Settings for easier configuration of world and scene prefabs:
        - World Prefab This world prefab is instantiated when the world is loaded on both client and server. This prefab will be instantiated only once and acts as a bootstrap for worlds. The default world prefab will automatically load the first scene in the scenes list and move all players into that scene.
        - Scene Prefab The scene prefab is automatically instantiated when any scene other than the world scene is loaded. This prefab generally contains functionality for controlling the player, etc, that is common within your game.
        - Hide Virtual Player Scenes This option when enabled will hide the additional scenes that are loaded in the hierarchy window when using virtual players. This is on by default, disable if you want to debug issues occurring in your virtual players scenes.
        - Scenes To facilitate multiple scene support you can now list the scenes you want included in your world here as well as some meta data such as the loading screen to use when switching.


## [0.3.0] - 2024/03/21

### Added

- All things “Avatar” in Lua have been renamed to “Character” to be more generic:
    - IE: AvatarInstantiated → CharacterInstantiated
    - IE: player.avatar → player.character
- AudioShaders - A new asset introduced to bring more customization to your audio clips! Add one to your project by right clicking in the Project tab of Unity and going Create → Highrise → Audio → Audio Shader
- Introduces the Audio 7 service that allows you to play the new AudioShader assets and even get the intensity of music played by this service
- Basic room info tab to see who’s in the room (Beta)
- Can once again long press Avatars :point_up_2:
- Duplicating GameObjects with a lua script on them no longer results in only one of them working on the server side
- Movement indicators are back ! !
- HighriseCameraController is now a Vertical Plane camera controller with yaw clamping (like the Highrise Mall camera). If you prefer the old camera, it is now called RTSCamera and can be found in the Add Component menu
- Don’t forget to upgrade your Visual Studio Code Highrise extension! We’ve added plenty of upgrades
- Various bug fixes
- Breaking change to Behaviour events syntax! This is a simpler and more direct way to set all the basic unity behaviour events like Start, Update, OnTriggerEnter, etc
