extends Node2D

var tween: Tween
var target_position = Vector2(0,0)
var projectile_distance = 500

#gets direction to target, moves a certain distance in that direction over a set amount of time
func _ready():
	var vector_to_target = Vector2(projectile_distance, 0).rotated(get_angle_to(target_position))
	tween = create_tween()
	tween.tween_property(self, "global_position", global_position + vector_to_target, .3)
	tween.finished.connect(on_tween_finished)


#deletes after movement finished
func on_tween_finished():
	queue_free()


#deletes if hits an enemy
func _on_basic_hit_box_2d_hurt_box_entered(hurt_box):
	queue_free()
