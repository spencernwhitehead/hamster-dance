extends TextureRect

@export var shortcut_scene: PackedScene

#spans a new shortcut node when clicked on in taskbar
func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		var shortcut = shortcut_scene.instantiate()
		get_tree().root.get_child(0).add_child(shortcut)
		shortcut.can_grab = true
		shortcut.dragging = true
