class_name Electric extends Element


@export var damage: int = 5
@export var targets: int = 2
@export var radius: float = 150

@export var zap: Line2D
@export var zapSegments: int = 5
@export var zapJitter: float = 5
@export var zapTime: float = 0.1


func tick() -> void:
	entity.takeDamage(damage)

	for target: Entity in nearby(radius).slice(0, targets):
		target.takeDamage(damage)
		drawZap(target)


func drawZap(target: Entity) -> void:
	var from: Vector2 = zap.global_position
	var to: Vector2 = target.to_global(zap.position)

	var line: Line2D = zap.duplicate()
	line.top_level = true
	line.position = Vector2.ZERO
	line.visible = true

	for i: int in zapSegments + 1:
		var point: Vector2 = from.lerp(to, float(i) / zapSegments)
		if (i > 0 and i < zapSegments):
			point += from.direction_to(to).orthogonal() * randf_range(-zapJitter, zapJitter)

		line.add_point(point.round())

	add_child(line)

	var tween: Tween = line.create_tween()
	tween.tween_property(line, "modulate:a", 0.0, zapTime)
	tween.tween_callback(line.queue_free)
