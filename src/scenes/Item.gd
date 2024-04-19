extends Area2D
var this_item = null

func _ready():
	$MenuSel.visible = false
	$MenuItem.visible = false
	$MenuItem2.visible = false
	this_item = Global.pick_random(Global.ITEMS)
	boot_start()
	
func boot_start():
	$sprite.animation = this_item.name
	$MenuItem.text = "== " + this_item.description + " =="
	$MenuSel.add_item(this_item.action, null, false)
	$MenuSel.add_item("To Inventory", null, false)
	$MenuSel.add_item("Leave", null, false)

func _on_area_entered(area):
	if area.is_in_group("players_area"):
		$MenuSel.visible = true
		$MenuItem.visible = true
		$MenuItem2.visible = true
		get_tree().paused = true

func _on_menu_sel_item_clicked(index, at_position, mouse_button_index):
	$MenuSel.visible = false
	$MenuItem.visible = false
	$MenuItem2.visible = false
	await get_tree().create_timer(0.1).timeout
	get_tree().paused = false
	do_action(index)
	
func do_action(index):
	if index == 0: #Use
		queue_free()
	elif index == 1: #Inventory
		if Global.add_to_inventory(this_item):
			Global.INV_Object.refresh()
			queue_free()
		else:
			pass #Notificar que no hay más espacio 	
	elif index == 2:
		pass

func _on_area_exited(area):
	if area.is_in_group("players_area"):
		$MenuSel.visible = false
		$MenuItem.visible = false
		$MenuItem2.visible = false
