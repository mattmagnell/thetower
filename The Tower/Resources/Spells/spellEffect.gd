extends Resource
class_name spellEffect

@export var EFFECT_NAME : String 
@export var EFFECT_TEXTURE : Texture
@export_multiline var HOVER_TEXT :  String

func getTexture() -> Texture2D:
	return EFFECT_TEXTURE
 
