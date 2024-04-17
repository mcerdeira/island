extends Area2D
var this_item = null

func _ready():
	$MenuSel.visible = false
	this_item = Global.pick_random(Global.ITEMS)
	boot_start()
	
func boot_start():
	$sprite.animation = this_item.name
	$MenuSel.add_item(this_item.action)
	$MenuSel.add_item("To Inventory")
	$MenuSel.add_item("Leave")

func _on_area_entered(area):
	if area.is_in_group("players_area"):
		$MenuSel.visible = true
		get_tree().paused = true

func _on_menu_sel_item_clicked(index, at_position, mouse_button_index):
	$MenuSel.visible = false
	await get_tree().create_timer(0.1).timeout
	get_tree().paused = false
	do_action(index)
	
func do_action(index):
	if index == 0:
		queue_free()
	elif index == 1:
		queue_free()
	elif index == 2:
		pass

func _on_area_exited(area):
	if area.is_in_group("players_area"):
		$MenuSel.visible = false
