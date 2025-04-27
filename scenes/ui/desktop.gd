extends Node2D

#updates the navigation region in case shortcuts have been moved around
func _ready():
	$NavigationRegion2D.bake_navigation_polygon()
