extends Node3D

func set_colour(colour):
	if randf() <= 0.5:
		print("Setting colour to " + str(colour))
		var mesh: MeshInstance3D = get_node("MeshInstance3D")
		var material: StandardMaterial3D = mesh.get_mesh().get_material().duplicate()
		material.albedo_color = colour
		material.emission = colour
		mesh.get_mesh().surface_set_material(0, material)

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Instantiating a sphere lmao")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
