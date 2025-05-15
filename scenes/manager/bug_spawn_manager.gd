extends Node

@export var bug_scene: PackedScene
@export var disabled := false

#connects to the timer and spawns in the bug every loop
func _on_cooldown_timer_timeout():
	if disabled: 
		return
	var bug = bug_scene.instantiate() as Node2D
	get_parent().add_child(bug)


#this is the only part of the code being used right now
#just creates a bug every time the button is pressed
func _on_spawn_bug_button_pressed():
	var bug = bug_scene.instantiate() as Node2D
	get_parent().add_child(bug)
