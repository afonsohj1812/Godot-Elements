class_name HealthBar extends Control


@export var entity: Entity
@export var damageBar: ProgressBar
@export var healthBar: ProgressBar
@export var delay: float = 0.5
@export var drainTime: float = 0.25

var tween: Tween


func _ready() -> void:
	if (not entity.is_node_ready()):
		await entity.ready

	damageBar.max_value = entity.maxHealth
	healthBar.max_value = entity.maxHealth
	damageBar.value = entity.health
	healthBar.value = entity.health

	entity.health_changed.connect(_on_health_changed)


func _on_health_changed(value: int) -> void:
	healthBar.value = value

	if (tween):
		tween.kill()

	if (damageBar.value < value):
		damageBar.value = value
		return

	tween = create_tween()
	tween.tween_interval(delay)
	tween.tween_property(damageBar, "value", value, drainTime)
