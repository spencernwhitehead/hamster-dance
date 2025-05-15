extends Node2D

@export var projectile_scene: PackedScene
@export var detection_component: DetectionComponent

#allows firerate to be set from the parent node, and updates FirerateTimer wait time when it's set
@export var firerate := 1.0:
	set(value):
		firerate = value
		#sometimes this code will be called before the timer is fully set up internally
		#using "await ready" makes sure everything exists before interacting with children
		await ready
		$FirerateTimer.wait_time = 1.0 / value


func _ready():
	#connects signal from connection component
	#can also be done through the editor, but I like using this for signals outside of the current object
	detection_component.connect("body_entered", on_detection_component_body_entered)


func attack_enemy():
	#finds target to attack, does nothing if no target exists
	var target = detection_component.get_current_target()
	if target == null:
		return
	
	#spawns projectile at current position and gives it the target's coordinates so it knows where to point
	var projectile = projectile_scene.instantiate() as Node2D
	get_tree().root.call_deferred("add_child", projectile)
	projectile.global_position = global_position
	projectile.target_position = target.global_position
	
	#starts firerate timer to repeat attacks if not already going
	if $FirerateTimer.is_stopped():
		$FirerateTimer.start()


#starts attack loop if something new enters detection radius while not currently attacking
func on_detection_component_body_entered(body):
	if $FirerateTimer.is_stopped():
		attack_enemy()


#creates projectile every time the timer runs out
func _on_firerate_timer_timeout():
	attack_enemy()
