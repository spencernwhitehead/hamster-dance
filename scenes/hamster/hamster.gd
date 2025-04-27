extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var pickable = false
enum states {WANDER, DRAG}
var state: states = states.WANDER
var flip = 1


func _physics_process(delta):
	#changes size and state of hamster if clicked or released
	if pickable and Input.is_action_just_pressed("mouse_left_click"):
		state = states.DRAG
		scale *= 1.2
	if Input.is_action_just_released("mouse_left_click"):
		if state == states.DRAG:
			scale /= 1.2
		state = states.WANDER
	
	#moves hamster to location of cursor
	#lerp moves it over a short time so it's not immediate
	if state == states.DRAG:
		global_position = lerp(global_position, get_global_mouse_position(), 20 * delta)
	
	#wander behavior, just bounces back and forth between walls
	elif state == states.WANDER:
		if is_on_wall():
			flip *= -1
		if is_on_floor():
			velocity.x = 300 * flip
		else:
			velocity.x = 0
			velocity.y += gravity * delta * 2
		move_and_slide()


#checks for cursor over hamster
func _on_area_2d_mouse_entered():
	pickable = true


func _on_area_2d_mouse_exited():
	pickable = false


#dies if collides with bug
#currently just gets deleted, need to add health
func _on_area_2d_body_entered(body):
	if body.is_in_group("bug"):
		queue_free()
