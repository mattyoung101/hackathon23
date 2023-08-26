extends Node3D

# Number of balls to display
const NUM_BALLS = 50

# Human hearing range (except for me im based i can hear up to like 20 MHz get trolled)
const FREQ_MIN = 20.0 # 20 Hz
const FREQ_MAX = 20000.0 # 20 KHz

var rng = RandomNumberGenerator.new()

var timer = 0.0
var chromatic_times = [2.755, 13.190, 23.620, 34.0745, 44.5]

# Called when the node enters the scene tree for the first time.
func _ready():
	var ball_scene = load("res://ball.tscn")
	rng.seed = 0xB0FADEE5
	
	# min and max bounding box for spawning
	var min_spawn = $ball_spawn_min.position
	var max_spawn = $ball_spawn_max.position
	
	# calculate colour interval
	var interval = 1.0 / NUM_BALLS
	print("Colour interval: " + str(interval))
	
	var i = 0.0
	var last_i = 0.0
	while i <= 1.0:
		var colour = Color(rng.randf(), rng.randf(), rng.randf())
		i += interval
		
		var fmin = remap(last_i, 0.0, 1.0, FREQ_MIN, FREQ_MAX)
		var fmax = remap(i, 0.0, 1.0, FREQ_MIN, FREQ_MAX)
		print("FREQ RANGE: %f ... %f" % [fmin, fmax])
		
		var x = rng.randf_range(min_spawn.x, max_spawn.x)
		var y = rng.randf_range(min_spawn.y, max_spawn.y)
		var z = rng.randf_range(min_spawn.z, max_spawn.z)
		var pos = Vector3(x, y, z)
		
		var new_ball = ball_scene.instantiate()
		new_ball.set_position(pos)
		new_ball.create_sphere(colour, fmin, fmax)
		add_child(new_ball)
		
		# MATT'S JIRA
		# HACK-1066: Synchronise the balls to the music (2 story points)
		# HACK-1067: Scan of AEB (420 story points)
		
		# JORDY'S JIRA
		# HACK-1068: Fixin' this (fixin' the point cloud) (47.638 story points)
		last_i = i

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# quit on escape
	if Input.is_action_pressed("key_exit"):
		get_tree().quit()
		
	# play chromatic abberation at fixed times
	timer += delta
	var bubble_player = get_node("CanvasLayer/AnimationPlayer")
	if not chromatic_times.is_empty() and timer >= chromatic_times[0]:
		print("Playing chromatic")
		bubble_player.play("chromatic")
		chromatic_times.remove_at(0)

