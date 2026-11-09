class_name Overload extends CombinedElement


@export var damageFire: int = 30
@export var radiusFire: float = 100
@export var damageElectric: int = 20
@export var radiusElectric: float = 150

@export var explosion: GPUParticles2D

var damage: int
var radius: float


func start() -> void:
	if (trigger == Fire):
		damage = damageFire
		radius = radiusFire
	elif (trigger == Electric):
		damage = damageElectric
		radius = radiusElectric
	
	var particlesVelocity: float = radius / explosion.lifetime / explosion.global_scale.x
	explosion.process_material.initial_velocity_min = particlesVelocity
	explosion.process_material.initial_velocity_max = particlesVelocity
	explosion.emitting = true

	for target: Entity in [entity] + nearby(radius):
		target.takeDamage(damage)
	
	stop()
