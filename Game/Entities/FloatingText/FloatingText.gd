class_name FloatingText extends Node2D


@export var entity: Entity
@export var labelSettings: LabelSettings
@export var container: Node
@export var rise: float = 24
@export var time: float = 0.5
@export var spread: float = 5
@export var drift: float = 10

@export var event: StringName = &"damaged"


func _ready() -> void:
	entity.connect(event, _on_event)


func _on_event(value: Variant, color: Color = Color.WHITE) -> void:
	var label: Label = Label.new()
	label.text = str(value)

	label.label_settings = labelSettings.duplicate()
	label.label_settings.font_color = color
	label.z_index = 1
	(container if container else get_tree().current_scene).add_child(label)

	label.reset_size()
	label.global_position = (global_position + Vector2(randf_range(-spread, spread), 0) - label.size / 2).round()

	var start: float = label.global_position.y
	var side: float = drift * [-1, 1].pick_random()

	var tween: Tween = label.create_tween().set_parallel()
	tween.tween_property(label, "global_position:x", label.global_position.x + side, time).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(label, "global_position:y", start - rise, time / 2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(label, "global_position:y", start, time / 2).from(start - rise).set_delay(time / 2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.tween_property(label, "modulate:a", 0.0, time / 2).set_delay(time / 2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.chain().tween_callback(label.queue_free)
