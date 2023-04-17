extends Node2D

# Add the paths to your spell scenes
const FILLED_CIRCLE_SPELL = preload("res://Scenes/Spells/Circle/CircleFilled.tscn")
const HOLLOW_CIRCLE_SPELL = preload("res://Scenes/Spells/Circle/CircleHollow.tscn")
const BEAM_SPELL = preload("res://Scenes/Spells/Beam/BeamH.tscn")
const ZIG_ZAG_SPELL = preload("res://Scenes/Spells/ZigZag/ZigZagA.tscn")

func spawn_spell(spell_scene):
	var spell_instance = spell_scene.instantiate()
	self.add_child(spell_instance)

	# Set the position of the spell to the player's position
	spell_instance.global_position = self.global_position

	# Set the direction of the spell
	spell_instance.direction = Vector2.RIGHT  # Change this to set the desired direction

