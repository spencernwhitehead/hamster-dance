extends StaticBody2D

var can_grab := false
var dragging := false
var grabbed_offset := Vector2(0,0)

#puts shortcut on mouse when created
func _ready():
	global_position = get_global_mouse_position()


#lot of really weird stuff in here to get the movement of the shortcut to feel right
#will be improved later
func _process(delta):
	#sets dragging behavior if clicked on
	if Input.is_action_just_pressed("mouse_left_click") and can_grab:
		dragging = true
		$Sprite2D.self_modulate.a = .5
		grabbed_offset = position - get_global_mouse_position()
	
	#follows mouse coordinates while being dragged
	if dragging:
		global_position = get_global_mouse_position() + grabbed_offset
	
	#when shortcut released, either place on desktop grid, or delete if over recycle
	if Input.is_action_just_released("mouse_left_click") and dragging:
		global_position = snapped(global_position - Vector2(32,32), Vector2(64, 64)) + Vector2(32,32)
		$Sprite2D.self_modulate.a = 1
		dragging = false
		
		#disables collision for next step if shortcut is over the trash can
		var trash = get_tree().get_first_node_in_group("trash")
		if trash != null and trash.can_trash:
			$CollisionShape2D.set_deferred("disabled", true)
		
		#updates path bugs can travel based on where shortcut was placed
		var nav_region = get_tree().get_first_node_in_group("navregion") as NavigationRegion2D
		if nav_region != null and not nav_region.is_baking():
			nav_region.bake_navigation_polygon()
		
		#deletes if collision was disabled, meaning it was placed on trash
		if $CollisionShape2D.disabled:
			queue_free()


func _on_mouse_detect_area_mouse_entered():
	can_grab = true


func _on_mouse_detect_area_mouse_exited():
	can_grab = false
