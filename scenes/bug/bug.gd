extends CharacterBody2D


func _physics_process(delta):
	$VelocityComponent.rotate_to_hamster()
	$VelocityComponent.accelerate_to_hamster()
	$VelocityComponent.move(self)


func _on_hurtbox_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		queue_free()
 
