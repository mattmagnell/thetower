extends Control

var items = []
signal item_added(item : Resource)

func add_items(item : Resource):
	print(item.name, " added")
	items.append(item)
	emit_signal('item_added', item)


