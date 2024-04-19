extends Node2D
var is_on = false

func _ready():
	Global.INV_Object = self
	$inv.visible = false
	
func refresh():
	var curr = 0
	for slo in Global.SLOTS:
		if slo.item != null:
			var slo_item = get_node("inv/slot"+ str(curr) +"/item")
			var slo_count = get_node("inv/slot"+ str(curr) +"/count")
			slo_item.animation = slo.item.name
			slo_count.text = str(slo.count)
			curr += 1

func _on_expand_toggled(toggled_on):
	is_on = toggled_on
	Global.PLAYER.click_position = null
	if is_on:
		get_tree().paused = true
		$inv.visible = true
		Global.INV_Object.refresh()
	else:
		get_tree().paused = false
		$inv.visible = false
