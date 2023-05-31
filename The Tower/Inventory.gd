@tool
extends TextureRect

var items = []

func add_items(item):
	print(item.texture)
	items.append(item)
	print(items)
	update_gui()
	
func update_gui():
	if items.size() > 0:
		self.texture = items[items.size() - 1].texture
		print(self.texture)
		self.queue_redraw()
