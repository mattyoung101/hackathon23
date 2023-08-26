extends AnimationPlayer

var rng = RandomNumberGenerator.new()

const ORDER = ["4", "2", "3", "1", "2"]

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.seed = 0xB0FADEE5
	var i = 0
	
	while true:
		var animations = get_animation_list()
		var anim = "camera_move_" + ORDER[i % ORDER.size()]
		print("Playing anim: " + anim)
		play(anim)
		await animation_finished
		print("Animation done!")
		i += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
