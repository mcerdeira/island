extends Node
var FULLSCREEN = false
var SAVED_GAME = false
var PLAYER = null
var ITEMS = []
var MUSIC_ENABLED = true
var MUSIC_PLAYING = false
var MainTheme = "res://music/Bone Yard Waltz - Loopable.ogg"
var shaker_obj = null
var SLOTS = []
var INV_Object = null

var apple = {
	"name": "apple",
	"description": "Apple",
	"long_description": "Tasty apple",
	"price": 400,
	"type": "food",
	"action": "Eat"
}

var axe = {
	"name": "axe",
	"description": "Axe",
	"long_description": "Sharp Axe",
	"price": 400,
	"type": "weapon",
	"action": "Equip"
}

func init_game():
	for i in range(0, 9):
		SLOTS.push_back({
			"item": null,
			"count": 0
		})
	ITEMS.push_back(apple)
	ITEMS.push_back(axe)
	
func add_to_inventory(item):
	var found = false
	for slo in SLOTS:
		if slo.item != null and slo.item.name == item.name:
			slo.count += 1
			found = true
			return true
	
	if !found:
		for slo in SLOTS:
			if slo.item == null:
				slo.item = item
				slo.count += 1
				return true

func save_game():
	pass
#	var saved_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
#	saved_game.store_var(Global.LEVEL)
#	saved_game.close()
#
#	var saved_poss = FileAccess.open("user://savepos.save", FileAccess.WRITE)
#	saved_poss.store_var(Global.POSSESSIONS)
#	saved_poss.close()
	
func load_game():
	pass
#	var saved_game = FileAccess.open("user://savegame.save", FileAccess.READ)
#	PLAY_INTRO = !saved_game
#	if saved_game:
#		var level = saved_game.get_var()
#		if level:
#			SAVED_GAME = true
#			Global.LEVEL = level
#			saved_game.close()
#
#	var saved_poss = FileAccess.open("user://savepos.save", FileAccess.READ)
#	if saved_poss:
#		var pos = saved_poss.get_var()
#		if pos:
#			Global.POSSESSIONS = pos
#			saved_poss.close()

func _ready():
	init_game()
	load_sfx()
	load_game()
	
func load_sfx():
	pass
	
func init():
	pass

func pick_random(container):
	if typeof(container) == TYPE_DICTIONARY:
		return container.values()[randi() % container.size() ]
	assert( typeof(container) in [
			TYPE_ARRAY, TYPE_PACKED_COLOR_ARRAY, TYPE_PACKED_INT32_ARRAY,
			TYPE_PACKED_BYTE_ARRAY, TYPE_PACKED_FLOAT32_ARRAY, TYPE_PACKED_STRING_ARRAY,
			TYPE_PACKED_VECTOR2_ARRAY, TYPE_PACKED_VECTOR3_ARRAY
			], "ERROR: pick_random" )
	return container[randi() % container.size()]

func play_sound(stream: AudioStream, options:= {}) -> AudioStreamPlayer:
	var audio_stream_player = AudioStreamPlayer.new()

	add_child(audio_stream_player)
	audio_stream_player.stream = stream
	audio_stream_player.bus = "SFX"
	
	for prop in options.keys():
		audio_stream_player.set(prop, options[prop])
	
	audio_stream_player.play()
	audio_stream_player.finished.connect(kill.bind(audio_stream_player))
	
	return audio_stream_player
	
func kill(_audio_stream_player):
	_audio_stream_player.queue_free()
