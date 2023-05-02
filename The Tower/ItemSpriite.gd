@tool
extends TextureRect

@export var MY_ITEM : Resource : set = _setItem 
	
@onready var MyLabel = $RichTextLabel

func addQuantity(addedQuant : int):
	MY_ITEM.addQuantity(addedQuant)
	
func _setItem(newItem : Resource):
	if newItem == null:
		print("Error: No item resource provided.")
		return
	
	print("setting item!")
	MY_ITEM = newItem 
	self.texture = MY_ITEM.getTexture()
	if MyLabel != null:
		MyLabel.text = str(newItem.getQuantity())
	
	
	
	
	
	
