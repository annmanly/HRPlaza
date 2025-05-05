# NPC Dialogue System

A comprehensive dialogue system that enables interactive conversations between players and NPCs, featuring dynamic camera transitions, animated text display, and response-based dialogue progression.

## Core Components

### Scriptable Objects

1. **DialogueTextBlock**
   - Stores individual message text and styling
   - Properties:
     - `message`: The text content
     - `specialAnimationID`: Animation type for text display (0 = none, 1 = wave, 2 = bounce)
     - `textColor`: Custom color for the text

2. **DialoguePage**
   - Contains a collection of messages and possible responses
   - Properties:
     - `Messages`: Array of DialogueTextBlock objects
     - `responses`: Array of response text options
     - `responseIDs`: Array of unique identifiers for responses
     - `Chunks`: Array of DialogueChunk objects for branching dialogue

3. **DialogueChunk**
   - Groups multiple dialogue pages together
   - Properties:
     - `Pages`: Array of DialoguePage objects

### Main Scripts

1. **DialogueCameraController**
   - Manages camera transitions during dialogue
   - Features:
     - Smooth transitions between default and dialogue cameras
     - Automatic character positioning and rotation
     - Collision avoidance
     - Configurable camera distances and heights
     - Avatar rotation to face each other during dialogue

2. **DialogueResponseManager**
   - Handles dialogue responses and character animations
   - Features:
     - Response event system
     - Character talking animations
     - NPC behavior management
     - Nameplate visibility control

3. **DialogueUI**
   - Manages the dialogue interface
   - Features:
     - Animated text display
     - Response button creation
     - Special text animations
     - Page navigation
     - Character name display

4. **NPCBehaviour**
   - Controls NPC movement and interaction
   - Features:
     - Waypoint-based movement
     - Idle wandering
     - Player detection
     - Nameplate management
     - Interaction state tracking

## Configuration

### DialogueCameraController Settings
- `_DefaultCamera`: The default gameplay camera
- `_EnableDefaultCameraOnStart`: Whether to enable default camera on start
- `_TransitionDuration`: Duration of camera transitions (default: 1.0s)
- `_DialogueDistance`: Distance from characters during dialogue (default: 4)
- `_DialogueHeight`: Height of camera during dialogue (default: 2)
- `_LookAtOffset`: Height offset for look-at point (default: 1.5)
- `_EnableCollisionAvoidance`: Whether to avoid obstacles
- `_RotateAvatars`: Whether to automatically rotate characters to face each other

### NPCBehaviour Settings
- `_IsStatic`: Whether the NPC remains stationary
- `_ViewRadius`: Detection range for player interaction
- `_WaitToMoveTime`: Time between movements
- `_WayPoints`: Array of movement waypoints
- `_ShouldIdleWander`: Whether NPC should wander during idle
- `_ShowNamePlate`: Whether to display the NPC's name
- `_NamePlateOffset`: Height offset for nameplate
- `_DistanceToShowNamePlate`: Distance at which nameplate becomes visible

## Usage

1. **Setting up an NPC**
   - Attach the NPCBehaviour script to the NPC GameObject
   - Configure waypoints and behavior settings
   - Set up the nameplate prefab if using name display

2. **Creating Dialogue**
   - Create DialogueTextBlock objects for each message
   - Group messages into DialoguePage objects
   - Create response options and link to DialogueChunk objects
   - Configure special animations and text colors

3. **Starting Dialogue**
   - Call `StartDialogueCamera(player, npc)` to begin dialogue
   - The system will automatically:
     - Position the camera
     - Rotate characters to face each other
     - Display the dialogue UI
     - Play appropriate animations

4. **Ending Dialogue**
   - Dialogue ends when:
     - Player selects a response
     - All pages are completed
     - Player closes the dialogue
   - System automatically:
     - Returns camera to default position
     - Restores character rotations
     - Hides dialogue UI

## Requirements

- Character component on NPC and player
- Camera component for dialogue view
- UI system for dialogue interface
- NavMeshAgent for NPC movement (if using waypoints)
