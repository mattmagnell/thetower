@tool
extends TextureRect

@export var MY_ITEM : Resource :
	set = _setItem
		
		
		
 
@onready var MyLabel = $RichTextLabel

func addQuantity(addedQuant : int):
	MY_ITEM.addQuantity(addedQuant)
	
func _setItem(newItem : Resource):
	print("setting item!")
	MY_ITEM = newItem 
	self.Texture = MY_ITEM.getTexture()
	$RichTextLabel.bbcode_text = newItem.getQuantity()
