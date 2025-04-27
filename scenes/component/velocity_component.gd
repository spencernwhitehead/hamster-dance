extends Node

#adjusting these values through the inspector will change the movement behavior 
#for the object this component is attached to
@export var max_speed: int = 200
@export var acceleration: float = 5
@export var rotational_acceleration: float = 5

var velocity = Vector2.ZERO


func get_direction_to_hamster():
	var owner_node2d = owner as Node2D
	if owner_node2d == null:
		return Vector2.ZERO
	
	var hamster = get_tree().get_first_node_in_group("hamster") as Node2D
	if hamster == null:
		return Vector2.ZERO
	
	var direction = (hamster.global_position - owner_node2d.global_position).normalized()
	return direction


func rotate_to_hamster():
	rotate_in_direction(get_direction_to_hamster())


func rotate_in_direction(direction: Vector2):
	owner.rotation = lerp_angle(owner.rotation, direction.angle(), 1.0 - exp(-rotational_acceleration * get_process_delta_time()))


func accelerate_to_hamster():
	accelerate_in_direction(get_direction_to_hamster())


func accelerate_in_direction(direction: Vector2):
	var desired_velocity = direction * max_speed
	velocity = velocity.lerp(desired_velocity, 1 - exp(-acceleration * get_process_delta_time()))


func decelerate():
	accelerate_in_direction(Vector2.ZERO)


func move(character_body: CharacterBody2D):
	character_body.velocity = velocity
	character_body.move_and_slide()
	velocity = character_body.velocity
