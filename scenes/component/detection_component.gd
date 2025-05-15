@tool
class_name DetectionComponent extends Area2D

#allows size of detection radius to be changed through parent node,
#rather than updating it through the CollisionShape2D node every time
@export_range(0.1, 2048, .1) var detect_range := 1.0:
	set(value):
		detect_range = value
		$CollisionShape2D.shape.radius = value

#list where each
var enemies_in_range := []


func get_current_target():
	#TODO: add targeting logic in this function
	#DA PLAN: targeting type enum with matching sort functions, use sort_custom with selected targeting type
	
	#temp targeting method, targets most recent enemy to enter range
	if enemies_in_range.size() == 0:
		return null
	else:
		return enemies_in_range.front()


#if new enemy walks into detection radius, adds it to list of enemies that can be targeted
func _on_body_entered(body):
	if body.is_in_group("bug"):
		enemies_in_range.append(body)


#removes enemy from list of possible targets once it leaves radius
func _on_body_exited(body):
	enemies_in_range.erase(body)
