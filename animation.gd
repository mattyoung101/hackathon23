extends AnimationPlayer

var rng = RandomNumberGenerator.new()

const ORDER = ["5"]

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.seed = 0xB0FADEE5
	var i = 0
	
	while true:
		var animations = get_animation_list()
		var anim = "camera_move_" + ORDER[i % ORDER.size()]
		print("Playing anim: " + anim)

		# also play the bubble effect if it's not playing
		#var bubble_player = get_parent().get_node("CanvasLayer/AnimationPlayer")
		#if not bubble_player.is_playing():
		#	print("PLAYING ANIMATION")
		#	bubble_player.play("bubble")

		play(anim)
		await animation_finished
		print("Animation done!")
		i += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
