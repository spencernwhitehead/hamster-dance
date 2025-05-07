extends TextureRect

@export var shortcut_scene: PackedScene


func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		var shortcut = shortcut_scene.instantiate()
		var shortcut_container = get_tree().get_first_node_in_group("temp_shortcut_container")
		shortcut_container.add_child(shortcut)
