@tool
extends "res://ItemObject.gd"

@export var spell : Resource
	
func _init():
	if spell != null:
		update_properties_from_spell()

# This method updates the name and texture properties based on the spell
func update_properties_from_spell():
	item_name = spell.name + " Scroll"
	icon = spell.texture

# This method is called when the script is reloaded, or when the spell property is changed
func _get_configuration_warning():
	if spell == null:
		return "No spell resource set for this scroll."
	else:
		update_properties_from_spell()
		return ""



