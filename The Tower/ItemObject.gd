@tool
extends Node2D

@export var item_name : String 
@export var description : String 
@export var icon : Texture = null

func use():
	pass  

# Define a signal for when the item is picked up
signal item_picked_up(item)


