class_name Dummy extends Entity


@export var sprite: AnimatedSprite2D

var isMoving: bool = false
var direction: Vector2 = Vector2.ZERO
var turnTime: float = 0


func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("Move Dummies")):
		isMoving = !isMoving


func _on_hit(_damage: int) -> void:
	sprite.play("Hit")


func _process(_delta: float) -> void:
	if (velocity.x):
		sprite.flip_h = (velocity.x > 0)


func _physics_process(delta: float) -> void:
	if !isMoving:
		return

	turnTime -= delta
	if (turnTime <= 0):
		turnTime = randf_range(1, 2)
		direction = Vector2.from_angle(randf() * TAU)

	velocity = direction * getSpeed()
	move_and_slide()
