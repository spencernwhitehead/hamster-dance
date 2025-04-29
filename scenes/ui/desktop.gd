extends Node2D


#updates the navigation region in case shortcuts have been moved around
func _ready():
	$NavigationRegion2D.bake_navigation_polygon()


func _on_revive_hamster_button_pressed():
	var hamster = preload("res://scenes/hamster/hamster.tscn").instantiate()
	hamster.global_position = Vector2(600,300)
	add_child(hamster)
	$Taskbar/HBoxContainer/ReviveHamsterButton.disabled = true
