extends CharacterBody2D

#godot has a built in constant for gravity that we grab here
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#flag for if hamster can be picked up on left click
var pickable := false
#defines the types of movement the hamster can have and sets a default one
enum states {WANDER, DRAG}
var state: states = states.WANDER
#temporarily used to decide if hamster is going left or right
var flip = 1

func _ready():
	#sets health bar information
	$HealthBar.init_bar(100)



func _physics_process(delta):
	#hamster grows slightly and follows cursor if left click pressed within defined area
	if pickable and Input.is_action_just_pressed("mouse_left_click"):
		state = states.DRAG
		$Sprite2D.scale *= 1.2
	#goes back to wandering if released from dragging
	if Input.is_action_just_released("mouse_left_click") and state == states.DRAG:
		$Sprite2D.scale /= 1.2
		state = states.WANDER
	
	#when behavior is set to drag, moves hamster to location of cursor
	#lerp moves it over a short period of time to smooth it out
	if state == states.DRAG:
		velocity = Vector2.ZERO
		global_position = lerp(global_position, get_global_mouse_position(), 20 * delta)
	
	#wander behavior, just bounces back and forth between walls
	elif state == states.WANDER:
		#reverses movement on wall collision
		if is_on_wall():
			flip *= -1
		#only moves side to side when on taskbar
		if is_on_floor():
			velocity.x = 150 * flip
		#calculates gravity when in the air
		else:
			velocity.x = 0
			velocity.y += gravity * delta * 2
	move_and_slide()


#checks for cursor over hamster and allows it to be picked up
func _on_area_2d_mouse_entered():
	pickable = true


#vice versa of previous function
func _on_area_2d_mouse_exited():
	pickable = false


#syncs health bar with internal health value
func _on_health_action_applied(action, applied):
	$HealthBar.update_bar($Health.current)


#deletes hamster on death, and allows "revive hamster" button on taskbar to be clicked
func _on_health_died(entity):
	$"../Taskbar/HBoxContainer/ReviveHamsterButton".disabled = false

	queue_free()
