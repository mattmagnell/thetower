@tool
extends Resource

class_name ITEM

@export var ITEM_NAME : String 
@export var ITEM_TEXTURE : Texture
@export var QUANTITY : int
@export_multiline var HOVER_TEXT :  String 


func addQuantity(addedQuant : int):
	QUANTITY += addedQuant
	
func getTexture() -> Texture2D:
	return ITEM_TEXTURE
func getQuantity() -> int:
	return QUANTITY 
