class_name Game extends Node2D


@export var dummy: PackedScene


func _ready() -> void:
	pass


func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("Spawn")):
		var mousePos: Vector2 = get_global_mouse_position()

		var dummyScene: Node2D = dummy.instantiate()
		dummyScene.position = mousePos
		dummyScene.scale *= Vector2(-2 if mousePos.x < get_window().size.x / 2.0 else 2, 2)

		add_child(dummyScene)
		print("Spawned Dummy")


func _process(_delta: float) -> void:
	pass
