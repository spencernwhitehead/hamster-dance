extends Node2D

var draggable = false


func _process(_delta):
	if draggable and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		global_position = get_global_mouse_position()


func _on_area_2d_mouse_entered():
	draggable = true


func _on_area_2d_mouse_exited():
	draggable = false


func _on_area_2d_body_entered(body):
	if body.is_in_group("bug"):
		queue_free()
