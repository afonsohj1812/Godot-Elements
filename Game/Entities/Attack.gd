class_name Attack extends Resource


@export var damage: int = 1
@export var critDamage: float = 2
@export var critChance: float = 0.2
@export var statusChance: float = 0.25
@export var element: GDScript


func getDamage() -> int:
	var damageValue: float = damage * (critDamage if randf() < critChance else 1.0)

	return roundi(damageValue)


func getElement() -> GDScript:
	return (element if randf() < statusChance else null)
