class_name Superconduct extends CombinedElement


@export var damage: int = 10
@export var radiusElectric: float = 150
@export var strengthElectric: float = 100
@export var radiusCold: float = 300
@export var strengthCold: float = 200

var radius: float
var strength: float

func start() -> void:
	if (trigger == Electric):
		radius = radiusElectric
		strength = strengthElectric

		for other: Entity in nearby(radius):
			if (trigger == Electric):
				other.applyElement(Electric)
	elif (trigger == Cold):
		radius = radiusCold
		strength = strengthCold

	entity.takeDamage(damage)


func _physics_process(delta: float) -> void:
	for other: Entity in nearby(radius):
		other.move_and_collide(other.global_position.direction_to(entity.global_position) * strength * delta)
