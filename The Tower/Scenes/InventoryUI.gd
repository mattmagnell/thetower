extends Control

var inventory = Inventory  # Access the Inventory singleton

func _ready():
	# Connect a signal so the UI updates whenever an item is added
	inventory.connect("item_added", Callable(self, "_on_item_added"))

func _on_item_added(item):
	# When an item is added, refresh the UI
	refresh_UI()

func refresh_UI():
	# Clear the ItemList
	$ItemList.clear()

	# Add each item from the inventory to the ItemList
	for item in inventory.items:
		$ItemList.add_item(item.name, item.texture)
