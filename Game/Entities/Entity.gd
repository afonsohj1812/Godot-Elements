class_name Entity extends CharacterBody2D


const GROUP: StringName = &"Entities"

@export var health: int = 10
@export var speed: float = 100
@export var hurtbox: Hurtbox

var slows: Array[float] = []


func _ready() -> void:
	assert(hurtbox != null, "Entity needs a Hurtbox")
	hurtbox.hit.connect(takeDamage)

	add_to_group(Entity.GROUP)


func takeDamage(damage: int) -> void:
	if (health <= 0):
		return
	
	health -= damage
	_on_hit(damage)

	if (health <= 0):
		_on_death()


func _on_hit(_damage: int) -> void:
	pass


func _on_death() -> void:
	queue_free()


func applyElement(element: Element) -> void:
	add_child(element)


func getSpeed() -> float:
	var slowMin: float = 1
	for slow in slows:
		if (slowMin > slow):
			slowMin = slow
	
	return speed * slowMin
