class_name Overload extends CombinedElement


@export var damageFire: int = 30
@export var radiusFire: float = 100
@export var damageElectric: int = 20
@export var radiusElectric: float = 150

var damage: int
var radius: float


func start() -> void:
	if (trigger == Fire):
		damage = damageFire
		radius = radiusFire
	elif (trigger == Electric):
		damage = damageElectric
		radius = radiusElectric

	for target: Entity in [entity] + nearby(radius):
		target.takeDamage(damage)
	
	stop()
