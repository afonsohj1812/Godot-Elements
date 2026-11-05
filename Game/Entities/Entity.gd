class_name Entity extends CharacterBody2D

signal health_changed(health: int)
signal damaged(damage: int)


const GROUP: StringName = &"Entities"

@export var maxHealth: int = 10
@export var speed: float = 100
@export var hurtbox: Hurtbox

@export var symbolOffset: Vector2 = Vector2(0, -32)

var health: int
var slows: Array[float] = []


func _ready() -> void:
	health = maxHealth
	hurtbox.hit.connect(takeDamage)

	add_to_group(Entity.GROUP)


func _physics_process(_delta: float) -> void:
	pass


func takeDamage(damage: int) -> void:
	if (health <= 0):
		return
	
	health = max(health - damage, 0)
	
	health_changed.emit(health)
	damaged.emit(damage)

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
