extends StaticBody2D

var can_grab := false
var dragging := false
var grabbed_offset := Vector2(0,0)

func _process(delta):
	if Input.is_action_just_pressed("mouse_left_click") and can_grab:
		dragging = true
	
	if dragging:
		global_position = snapped(get_global_mouse_position() + Vector2(32,32), Vector2(64, 64)) - Vector2(32,32)
		
	if Input.is_action_just_released("mouse_left_click") and dragging:
		dragging = false
		var delete = false
		
		var trash = get_tree().get_first_node_in_group("trash")
		if trash != null and trash.can_trash:
			delete = true
		
		var nav_region = get_tree().get_first_node_in_group("navregion") as NavigationRegion2D
		if delete:
			global_position.y -= 1000
		if nav_region != null and not nav_region.is_baking():
			nav_region.bake_navigation_polygon()
		
		
		if delete:
			queue_free()

func _on_mouse_detect_area_mouse_entered():
	can_grab = true


func _on_mouse_detect_area_mouse_exited():
	can_grab = false
