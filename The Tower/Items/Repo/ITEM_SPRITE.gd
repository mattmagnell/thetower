@tool
extends TextureRect

@export var MY_ITEM : Resource :
	set (_ITEM):
		_setItem(MY_ITEM)
	get:
		
		
		
 
@onready var MyLabel = $RichTextLabel

func addQuantity(addedQuant : int):
	MY_ITEM.addQuantity(addedQuant)
	
func _setItem(newItem : Resource):
	print("setting item!")
	MY_ITEM = newItem 
	self.Texture = MY_ITEM
	$RichTextLabel.bbcode_text = newItem.getQuantity()
