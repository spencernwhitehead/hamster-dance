extends MenuButton


func _ready():
	connect("pressed", on_pressed)


func on_pressed():
	get_popup().position.y -= 50
