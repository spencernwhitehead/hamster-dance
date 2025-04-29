extends CharacterBody2D

@export var movement_speed := 200.0


func _ready():
	$HealthBar.init_bar(100)


func _physics_process(delta):
	#gets a reference to the hamster node for tracking
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
		$Health.damage(20)


func _on_basic_hit_box_2d_hurt_box_entered(hurt_box):
	$BasicHitBox2D/CollisionShape2D.set_deferred("disabled", true)
	$HitCooldownTimer.start()


func _on_hit_cooldown_timer_timeout():
	$BasicHitBox2D/CollisionShape2D.set_deferred("disabled", false)


func _on_health_action_applied(action, applied):
	$HealthBar.update_bar($Health.current)


func _on_health_died(entity):
	queue_free()
