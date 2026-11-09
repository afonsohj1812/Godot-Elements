class_name Hurtbox extends Area2D


signal hit(attack: Attack)


var entity: Entity


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if (area is not Hitbox):
		return

	hit.emit(area.attack)
