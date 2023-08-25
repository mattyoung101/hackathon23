extends Node3D

# Number of balls to display
const NUM_BALLS = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	# calculate colour interval
	var interval = 1.0 / NUM_BALLS
	print("Colour interval: " + str(interval))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
