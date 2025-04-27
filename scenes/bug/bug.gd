extends CharacterBody2D

@export var movement_speed := 200.0


func _physics_process(delta):
	#previous movement code for the bug
	#currently commented out in favor of the navigation code
	
	#$VelocityComponent.rotate_to_hamster()
	#$VelocityComponent.accelerate_to_hamster()
	#$VelocityComponent.move(self)
	
	#gets a reference to the hamster node to track
	var hamster = get_tree().get_first_node_in_group("hamster") as Node2D
	#stops trying to calculate movement if the hamster's already dead and can't be found
	if hamster == null:
		return
	
	#sets navigation to hamster's location
	$NavigationAgent2D.target_position = hamster.global_position
	
	#navigation agent creates a path to the hamster, 
	#so we move the bug towards whatever point in the path the navigation agent tells us to go to
	velocity = global_position.direction_to($NavigationAgent2D.get_next_path_position()) * movement_speed
	move_and_slide()

#detects if mouse click occurs within its hurtbox area
func _on_hurtbox_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		#this is where the bug would take damage
		#but we just delete it for now instead
		queue_free()
 
