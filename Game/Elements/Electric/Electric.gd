class_name Electric extends Element


@export var damage: int = 5
@export var targets: int = 2
@export var radius: float = 150


func tick() -> void:
	for target: Entity in [entity] + nearby(radius).slice(0, targets):
		target.takeDamage(damage)
