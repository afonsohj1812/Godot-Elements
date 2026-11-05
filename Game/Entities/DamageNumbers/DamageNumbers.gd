class_name DamageNumbers extends Node2D


@export var entity: Entity
@export var labelSettings: LabelSettings
@export var container: Node
@export var rise: float = 24
@export var time: float = 0.5
@export var spread: float = 5


func _ready() -> void:
	entity.damaged.connect(_on_damaged)


func _on_damaged(damage: int) -> void:
	var label: Label = Label.new()
	label.text = str(damage)
	label.label_settings = labelSettings
	label.z_index = 1
	(container if container else get_tree().current_scene).add_child(label)

	label.reset_size()
	label.global_position = (global_position + Vector2(randf_range(-spread, spread), 0) - label.size / 2).round()

	var start: float = label.global_position.y

	var tween: Tween = label.create_tween()
	tween.tween_property(label, "global_position:y", start - rise, time / 2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(label, "global_position:y", start, time / 2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.parallel().tween_property(label, "modulate:a", 0.0, time / 2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.tween_callback(label.queue_free)
