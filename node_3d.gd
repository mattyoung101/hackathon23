extends Node3D

# Number of balls to display
const NUM_BALLS = 20

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.seed = 0xB0FADEE5
	
	# calculate colour interval
	var interval = 1.0 / NUM_BALLS
	var colours = []
	print("Colour interval: " + str(interval))
	
	var i = 0.0
	while i <= 1.0:
		print("HSV: %s, %s, %s" % [i, 1.0, 1.0])
		colours.append(Color.from_hsv(i, 1.0, 1.0))
		i += interval
		
		var x = rng.randf_range(-10.0, 10.0)
		var y = rng.randf_range(-10.0, 10.0)
		var z = rng.randf_range(-10.0, 10.0)
		var pos = Vector3(x, y, z)
		print("Pos: %s" % pos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# quit on escape
	if Input.is_action_pressed("key_exit"):
		get_tree().quit()

