extends Node

#creates a new parameter in the inspector titled "Bug Scene"
#once the bug.tscn file is dragged into that parameter, this script can reference it and use it to spawn the bugs
@export var bug_scene: PackedScene

#connects to the timer and spawns in the bug every loop
func _on_cooldown_timer_timeout():
	#instantiate() takes the bug_scene we have referenced and creates an object from it
	#like building a house from a blueprint
	var bug = bug_scene.instantiate() as Node2D
	#then you add that instanced bug to the current scene
	#this is where you would set the spawn coordinates if you didn't want them spawning in at (0,0)
	#but that's the top left corner so we don't have to worry about that for now
	get_parent().add_child(bug)


func _on_spawn_bug_button_pressed():
	var bug = bug_scene.instantiate() as Node2D
	get_parent().add_child(bug)
