extends Sprite2D
@export var limb_type = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	$limb.text = limb_type
