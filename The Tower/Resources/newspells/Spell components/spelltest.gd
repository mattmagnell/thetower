extends Node

func _ready() -> void:
	var ball_component = load("res://Resources/newspells/Spell components/BASE/Ball.tres")
	var fire_component = load("res://Resources/newspells/Spell components/ELEMENTAL/Fire.tres")
	var intensity_component = load("res://Resources/newspells/Spell components/SPECIAL/Intensity.tres")

	var spell = Spell.new([ball_component, fire_component, intensity_component])

	print("Spell effects:")
	for effect_name in spell.effects.keys():
		print(effect_name + ": " + str(spell.effects[effect_name]))
