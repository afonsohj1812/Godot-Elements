class_name Fire extends Element


@export var damage: int = 5


func tick() -> void:
	entity.takeDamage(damage)
