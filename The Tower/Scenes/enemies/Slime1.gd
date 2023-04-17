extends Node2D

@onready var nav_agent = $NavigationAgent2D
var nav_map_rid = RID()

var target_position = Vector2.ZERO

func _ready():
	nav_map_rid = get_tree().get_root().get_node("NavigationRegion2D").get_navigation_map()
	generate_new_target_position()

func _physics_process(delta):
	if nav_agent.distance_to_target() < 10:
		generate_new_target_position()

func generate_new_target_position():
	var random_x = randf_range(-500, 500) # Adjust these values based on your scene's dimensions
	var random_y = randf_range(-500, 500)
	var random_position = Vector2(random_x, random_y)
	target_position = NavigationServer2D.map_get_closest_point(nav_map_rid, random_position)
	nav_agent.set_target_location(target_position)
