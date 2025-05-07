extends Draggable

@export var shortcut_2d_scene: PackedScene = null
var shortcut: StaticBody2D = null


#instead of whatever this is: what if draggable is initially on taskbar, 
#and once picked up switches its parent to the desktop?
func _ready():
	pass#global_position = get_global_mouse_position()
	#_mouse_dragging = true


func _process(delta):
	print(global_position, position, _mouse_dragging)


func _on_drag_ended():
	if !_mouse_over:
		return
	print("drag ended")
	print(global_position)
	#if shortcut == null:
		#shortcut = shortcut_2d_scene.instantiate()
		#get_tree().root.get_child(0).add_child.call_deferred(shortcut)
	#shortcut.global_position = global_position + Vector2(32,32)
	#shortcut.modulate.a = 1
	#$TextureRect.modulate.a = .2
	
	#var nav_region = get_tree().get_first_node_in_group("navregion") as NavigationRegion2D
	#if nav_region != null and not nav_region.is_baking():
		#nav_region.bake_navigation_polygon()


func _on_gui_input(event):
	if event is InputEventMouseButton:
		var shortcut_container = get_tree().get_first_node_in_group("temp_shortcut_container") as PanelContainer
		if shortcut_container != null and shortcut_container != get_parent():
			print(global_position)
			#cannot continue dragging while switching parent, is forcibly released due to bugginess apparently
			reparent(shortcut_container)
			print(global_position)
		if shortcut:
			shortcut.modulate.a = .6
			$TextureRect.modulate.a = 1
