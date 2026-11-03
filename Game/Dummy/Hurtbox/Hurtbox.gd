class_name Hurtbox extends Area2D


signal damaged(attack: Attack)


@export var health: int = 10


func _ready() -> void:
	connect("area_entered", _on_area_entered)


func _on_area_entered(attack: Attack) -> void:
	damage(attack)


func damage(attack: Attack) -> void:
	damaged.emit(attack)

	health -= attack.damage
	if (health <= 0):
		owner.queue_free()
