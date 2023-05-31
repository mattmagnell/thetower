extends Node2D

var items = []

func add_items(item):
	items.append(item)
	print(item, "added")
	print(items)
