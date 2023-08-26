extends Node3D

var sphere: SphereMesh
var noise: FastNoiseLite
var timer = 0.0

const MIN_RADIUS = 0.1
const MAX_RADIUS = 0.75
const MIN_DB = 80

var freq_min = 0.0
var freq_max = 0.0
var spectrum: AudioEffectSpectrumAnalyzerInstance

func create_sphere(colour, fmin, fmax):
	sphere = SphereMesh.new()
	sphere.radius = 0.3
	sphere.height = 2 * sphere.radius
	sphere.radial_segments = 32
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
	
	freq_min = fmin
	freq_max = fmax
	spectrum = AudioServer.get_bus_effect_instance(0,0)

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
	
	var magnitude: float = spectrum.get_magnitude_for_frequency_range(freq_min, freq_max).length()
	var energy = clamp((MIN_DB + linear_to_db(magnitude)) / MIN_DB, 0, 1)
	
	sphere.radius = remap(energy, 0.0, 1.0, MIN_RADIUS, MAX_RADIUS)
	sphere.height = 2 * sphere.radius
	
