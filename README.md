# The Cursed Macguffin

used Godot `v4.2.1`

### Saving system 1.0

To add node data to save file, you need to add empty Node as a child and attach `SavingComponent` to it\
All savable properties should be listed in export variable\
To save data, you should call `SavingManager.save_data()` method\
To load data, you should call `SavingManager.load_data()` method

### Player Movement and Camera System 1.0

There's a dummy player with player script attached, that moves relative to camera
Cameras with the camera script will always look at the player
Areas will grab control, and switch to 'their camera'

An Example scene has been setup to show how to add new sets of cameras to build a level