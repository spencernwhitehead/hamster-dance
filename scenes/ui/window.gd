extends Window


func _on_close_requested():
	hide()


func _on_window_button_pressed():
	if visible:
		hide()
	else:
		show()
