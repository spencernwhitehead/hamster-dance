extends Node

@export var bug_scene: PackedScene

func _on_cooldown_timer_timeout():
	var bug = bug_scene.instantiate() as Node2D
	get_parent().add_child(bug)
