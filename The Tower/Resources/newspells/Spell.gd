extends Resource
class_name Spell

var components: Array = []
var effects: Dictionary = {}
	
func _init(components_param: Array) -> void:
	self.components = components_param
	for component in components:
		for effect_name in component.effects.keys():
			if effect_name == "intensity":
				# For multipliers like intensity, multiply the value if it's already in the dictionary,
				# otherwise just set the value.
				if effect_name in effects:
					effects[effect_name] *= component.effects[effect_name]
				else:
					effects[effect_name] = component.effects[effect_name]
			else:
				# For other effects, add the value if it's already in the dictionary,
				# otherwise just set the value.
				if effect_name in effects:
					effects[effect_name] += component.effects[effect_name]
				else:
					effects[effect_name] = component.effects[effect_name]

	# Apply intensity to base_damage after all components have been processed.
	# Note: You may want to include some error checking here in case either "intensity" or "base_damage" is not in the dictionary.
	effects["base_damage"] *= effects["intensity"]
	

	

