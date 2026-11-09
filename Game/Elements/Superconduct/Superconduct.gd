class_name Superconduct extends CombinedElement


@export var damage: int = 10
@export var radiusElectric: float = 100
@export var radiusCold: float = 150
@export var minDistance: float = 10

@export var implosion: GPUParticles2D

var radius: float
var strength: float


func start() -> void:
	if (trigger == Electric):
		radius = radiusElectric

		for other: Entity in nearby(radius):
			other.applyElement(Electric)
	elif (trigger == Cold):
		radius = radiusCold

	strength = radius / duration
	implosion.lifetime = duration

	var particlesMaterial: ParticleProcessMaterial = implosion.process_material
	particlesMaterial.emission_ring_radius = radius / implosion.global_scale.x
	particlesMaterial.emission_ring_inner_radius = particlesMaterial.emission_ring_radius - 2
	particlesMaterial.radial_velocity_min = -strength / implosion.global_scale.x
	particlesMaterial.radial_velocity_max = particlesMaterial.radial_velocity_min
	implosion.emitting = true

	entity.takeDamage(damage)


func _physics_process(delta: float) -> void:
	for other: Entity in nearby(radius):
		if (other.global_position.distance_to(entity.global_position) > minDistance):
			other.move_and_collide(other.global_position.direction_to(entity.global_position) * strength * delta)
