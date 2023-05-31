@tool
extends "res://ItemObject.gd"

@export var spell : Resource:
	get:
		return _spell
	set(value):
		_spell = value
		update_properties_from_spell()
		
var _spell : Resource
	
func _ready():
	if spell != null:
		update_properties_from_spell()

# This method updates the name and texture properties based on the spell
func update_properties_from_spell():
	if _spell != null:
		var sprite : Sprite2D = get_node("Area2D/ScrollSprite")
		sprite.texture = _spell.texture
		item_name = _spell.name + " Scroll"
		icon = _spell.texture
		
func _get_configuration_warning():
	if _spell == null:
		return "No spell resource set for this scroll."
	else:
		return ""

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		var item = spell 
		var inventory = body.inventory
		inventory.add_items(item)
		self.queue_free()  # Remove the item from the scene
