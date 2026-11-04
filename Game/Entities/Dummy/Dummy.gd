class_name Dummy extends Entity


@export var sprite: AnimatedSprite2D


func _on_hit(_damage: int) -> void:
	sprite.play("Hit")
