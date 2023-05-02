extends Resource
class_name spellEffect

@export var ITEM_NAME : String 
@export var ITEM_TEXTURE : Texture
@export_multiline var HOVER_TEXT :  String

func getTexture() -> Texture2D:
	return ITEM_TEXTURE
 
