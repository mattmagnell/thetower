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
#@export var spell_speed = 250
var base_spell = preload("res://Scenes/Spells/Circle/BallFilled.tscn")
var fire_ball = preload("res://Scenes/Spells/Circle/BallFire.tscn")
var selected_spell
var spells = []

################
# MAIN PROCESS #
################
func _input(event):
		if event.is_action_pressed("spell_1"):
			selected_spell = spells[0]
		if event.is_action_pressed("spell_2"):
			selected_spell = spells[1]
		if event.is_action_pressed("spell_3") and spells[2] != null:
			selected_spell = spells[2]

	
func _ready():
	animationTree.active = true 
	spells = [base_spell, fire_ball, null]
	selected_spell = base_spell
	
func _process(_delta):
	pass
	
func _physics_process(_delta):
	match state:
		MOVE:
			wasd_move()
			mouse_look()
		PICKUP:
			pass
		THROW:
			cast_spell()
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
	
	if Input.is_action_pressed("mouse_look"):
		animationTree.set("parameters/idle/blend_position", direction)
		animationTree.set("parameters/walk/blend_position", direction)
			
		# Change to throw state
		if Input.is_action_just_pressed("cast_spell"):
			state = THROW
			
		# idle animation

# Instance spell #
func cast_spell():
	var spell_instance = selected_spell.instantiate()
	var spawn_position = $SpellPoint.global_position
	spell_instance.global_position = spawn_position
	spell_instance.start_position = spawn_position
	spell_instance.linear_velocity = (get_global_mouse_position() - spawn_position).normalized() * spell_instance.spell_speed
	get_parent().add_child(spell_instance)

	state = MOVE


# TODO: Implement dying animation
func death():
	self.visible = false
	self.collision_layer = 0
	self.collision_mask = 0
	$Timer.start()

func _on_hurtbox_body_entered(body):
	if body.is_in_group("Enemy") and health > 0:
		health -= 1
	if health == 0:
		death()

func _on_timer_timeout():
	get_tree().reload_current_scene()
