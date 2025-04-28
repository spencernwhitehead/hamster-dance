extends TextureRect

var can_trash := false

func _on_mouse_entered():
	can_trash = true


func _on_mouse_exited():
	can_trash = false
