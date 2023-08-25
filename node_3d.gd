extends Node3D

# Number of balls to display
const NUM_BALLS = 200

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var ball_scene = load("res://ball.tscn")
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
		
		var x = rng.randf_range(-5.0, 5.0)
		var y = rng.randf_range(-10.0, 10.0)
		var z = rng.randf_range(-10.0, 10.0)
		var pos = Vector3(x, y, z)
		print("Pos: %s" % pos)
		
		print("Creating...")
		var new_ball = ball_scene.instantiate()
		new_ball.set_position(pos)
		add_child(new_ball)
		
		# MY JIRA
		# HACK-1063: Extract the material (80 story points)
		# HACK-1064: Change the base colour (2 story points), blocked by HACK-1063
		# HACK-1065: Change the emissive colour (2 story points), blocked by HACK-1063

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# quit on escape
	if Input.is_action_pressed("key_exit"):
		get_tree().quit()

