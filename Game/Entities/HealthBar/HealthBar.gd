class_name HealthBar extends Control


@export var entity: Entity
@export var damage: ProgressBar
@export var health: ProgressBar
@export var delay: float = 0.5
@export var drainTime: float = 0.25

var tween: Tween


func _ready() -> void:
	if (not entity.is_node_ready()):
		await entity.ready

	damage.max_value = entity.health
	health.max_value = entity.health
	damage.value = entity.currentHealth
	health.value = entity.currentHealth

	entity.health_changed.connect(_on_health_changed)


func _on_health_changed(value: int) -> void:
	health.value = value

	if (tween):
		tween.kill()

	if (damage.value < value):
		damage.value = value
		return

	tween = create_tween()
	tween.tween_interval(delay)
	tween.tween_property(damage, "value", value, drainTime)
