# Godot Wild Jam 68

used Godot `v4.2.1`

### Saving system

To add node data to save file, you need to add empty Node as a child and attach `SavingComponent` to it\
All savable properties should be listed in export variable\
To save data, you should call `SavingManager.save_data()` method\
To load data, you should call `SavingManager.load_data()` method
