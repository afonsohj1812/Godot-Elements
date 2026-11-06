class_name Melt extends CombinedElement


@export var damageFire: int = 100
@export var damageCold: int = 75

var damage: int


func start() -> void:
	if (trigger == Fire):
		damage = damageFire
	elif (trigger == Cold):
		damage = damageCold
		entity.applyElement(Cold)


	entity.takeDamage(damage)

	stop()
