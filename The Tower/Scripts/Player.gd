extends CharacterBody2D

# player variables
@export var health = 1
@export var speed = 150
@export var accel = 8
@export var friction = 10
@onready var animation = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")

# State tree
var state = MOVE
enum {
	MOVE,
	PICKUP,
	THROW,
}

# spell variables
@export var spell_speed = 250
var base_spell = preload("res://Scenes/Spells/Circle/CircleFilled.tscn")
var has_mana = false
var max_mana = 2
var mana_amount = 0
@onready var manaPool
var in_manaPool = false

################
# MAIN PROCESS #
################
func _ready():
	animationTree.active = true 
	print(mana_amount)
	print(in_manaPool)
	
func _process(_delta):
	death()
	
func _physics_process(_delta):
	match state:
		MOVE:
			wasd_move()
			mouse_look()
		PICKUP:
			pass
		THROW:
			pass
			mouse_look()
			
##################
# Player Methods #
##################
# Input Movement #
func wasd_move():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	input_direction = input_direction.normalized()
	
	if input_direction != Vector2.ZERO:
		animationTree.set("parameters/idle/blend_position", input_direction)
		animationTree.set("parameters/walk/blend_position", input_direction)
		animationState.travel("walk")
		velocity = velocity.move_toward(input_direction * speed, accel)
	else:
		animationState.travel("idle")
		velocity = velocity.move_toward(Vector2.ZERO, friction)
	move_and_slide()
		
# Aiming #
func mouse_look():
	var node_ref = $CharacterModel
	var pos_player = node_ref.get_global_position()
	var pos_mouse = get_global_mouse_position()
	var direction = (pos_mouse - pos_player).normalized()
	var sight_direction = (pos_mouse - pos_player).limit_length(50)
	
	if Input.is_action_pressed("mouse_look"):
		animationTree.set("parameters/idle/blend_position", direction)
		animationTree.set("parameters/walk/blend_position", direction)
			
		# Change to throw state
		if Input.is_action_just_pressed("cast_spell"):
			state = THROW
			
		# idle animation

# Instance snowball #
func throw_animation():
	var node_ref = $"Snowball-Point"
	var pos_player = node_ref.get_global_position()
	var pos_mouse = get_global_mouse_position()
	var direction = (pos_mouse - pos_player).normalized()
	
	state = THROW
	
	if has_mana:
		var baseSpell_instance = base_spell.instance()
		baseSpell_instance.position = pos_player
		baseSpell_instance.apply_impulse(Vector2(), direction * spell_speed)
		get_tree().get_root().add_child(baseSpell_instance)
		mana_amount -= 1
		if mana_amount == 0:
			has_mana = false
	else:
		print("No snowball made")

# TODO: Implement dying animation
func death():
	if health == 0:
		self.queue_free()
		get_tree().reload_current_scene()
