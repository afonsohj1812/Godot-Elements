class_name Melt extends CombinedElement


@export var damageFire: int = 100
@export var damageCold: int = 75

@export var shards: GPUParticles2D

var damage: int


func start() -> void:
	shards.emitting = true

	if (trigger == Fire):
		damage = damageFire
	elif (trigger == Cold):
		damage = damageCold
		entity.applyElement(Cold)


	entity.takeDamage(damage)

	stop()
