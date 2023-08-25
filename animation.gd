extends AnimationPlayer

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.seed = 0xB0FADEE5
	var i = 0
	
	while true:
		var animations = get_animation_list()
		var anim = animations[i]
		print("Playing anim: " + anim)
		play(anim)
		await animation_finished
		print("Animation done!")
		i += 1
		if i >= animations.size():
			print("All animations done!!")
			break
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
