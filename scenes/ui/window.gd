#makes the window close and reopen based on input from the x button or the taskbar button
extends Window


func _on_close_requested():
	hide()


func _on_window_button_pressed():
	if visible:
		hide()
	else:
		show()
