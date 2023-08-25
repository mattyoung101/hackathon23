extends Node3D

var sphere: SphereMesh
var noise: FastNoiseLite
var timer = 0.0

const MIN_RADIUS = 0.1
const MAX_RADIUS = 0.5

func create_sphere(colour):
	sphere = SphereMesh.new()
	sphere.radius = 0.3
	sphere.height = 2 * sphere.radius
	sphere.radial_segments = 63
	sphere.rings = 32
	
	var mat = StandardMaterial3D.new()
	mat.albedo_color = colour
	mat.roughness = 0.0
	mat.metallic = 0.0
	mat.metallic_specular = 0.36
	mat.emission_enabled = true
	mat.emission = colour
	mat.emission_energy_multiplier = 4.0
	
	sphere.surface_set_material(0, mat)
	
	var node = MeshInstance3D.new()
	node.mesh = sphere
	
	add_child(node)
	
	noise = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.frequency = 0.001
	#noise.fractal_type = FastNoiseLite.FRACTAL_FBM

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# adjust sphere size (works!)
	#sphere.radius = randf_range(MIN_RADIUS, MAX_RADIUS)
	#sphere.height = 2 * sphere.radius
	
	# some smooth noise to add a bit of movement
	timer += delta
	#position.x += noise.get_noise_2d(timer, 1.0)
	#position.y += noise.get_noise_2d(timer, 2.0)
	#position.z += noise.get_noise_2d(timer, 3.0)
