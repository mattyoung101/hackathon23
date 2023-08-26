extends Node3D

var sphere: SphereMesh
var noise: FastNoiseLite
var timer = 0.0
var mat: StandardMaterial3D

const MIN_RADIUS = 0.1
const MAX_RADIUS = 0.6
const MIN_DB = 80
const BPM = 96

var freq_min = 0.0
var freq_max = 0.0
var spectrum: AudioEffectSpectrumAnalyzerInstance
var beat_interval = 0.0
var beat_count = 0
var did_just_enter_bar = true

var rng = RandomNumberGenerator.new()

func create_sphere(colour, fmin, fmax):
	sphere = SphereMesh.new()
	sphere.radius = 0.3
	sphere.height = 2 * sphere.radius
	sphere.radial_segments = 32
	sphere.rings = 32
	
	mat = StandardMaterial3D.new()
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
	
	beat_interval = 60.0 / BPM
	rng.seed = 0xB0FADEE5 * fmin * fmax

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
	var can_be_large = false
	
	if timer >= beat_interval:
		#print("BEAT " + str(beat_count))
		timer = 0.0
		beat_count += 1
		
	var max_radius = 0.0
	if beat_count % 4 == 0:
		if did_just_enter_bar:
			print("Did just enter new bar " + str(beat_count))
			var new_colour = Color.from_hsv(rng.randf(), 1.0, 1.0)
			mat.albedo_color = new_colour
			mat.emission = new_colour
			did_just_enter_bar = false
	else:
		did_just_enter_bar = true
			
	
	#position.x += noise.get_noise_2d(timer, 1.0)
	#position.y += noise.get_noise_2d(timer, 2.0)
	#position.z += noise.get_noise_2d(timer, 3.0)
	
	var magnitude: float = spectrum.get_magnitude_for_frequency_range(freq_min, freq_max).length()
	var energy = clamp((MIN_DB + linear_to_db(magnitude)) / MIN_DB, 0, 1)
	
	sphere.radius = remap(energy, 0.0, 1.0, MIN_RADIUS, MAX_RADIUS)
	sphere.height = 2 * sphere.radius
	
