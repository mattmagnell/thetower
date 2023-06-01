extends Control

var items = []
var item_slots

func add_items(item):
	print(item.name, " added")
	items.append(item)
	print(items)
	update_inventory()
	
func update_inventory():
	item_slots = get_node("ItemSlots")
	for i in range(item_slots.get_child_count()):
		var item_slot = item_slots.get_child(i)
		var texture_slot = item_slot.get_child(0)
		if i < items.size():
			var current_item = items[i]
			print(current_item.texture)
			texture_slot.texture = current_item.texture
			print(texture_slot.texture)
		else:
			pass

