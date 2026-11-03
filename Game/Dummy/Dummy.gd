class_name Dummy extends Node2D


@export var sprite: AnimatedSprite2D
@export var hurtbox: Hurtbox


func _ready() -> void:
	hurtbox.damaged.connect(_on_hurtbox_damaged)


func _on_hurtbox_damaged(_attack: Attack) -> void:
	sprite.play("Damage")
