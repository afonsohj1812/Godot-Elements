class_name Game extends Node2D


@export var attack: Attack
@export var dummy: PackedScene
@export var elements: Array[GDScript]
@export var elementSymbol: TextureRect


func _ready() -> void:
	selectElement(elements[0])


func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("Spawn")):
		var mousePos: Vector2 = get_global_mouse_position()

		var dummyScene: Node2D = dummy.instantiate()
		dummyScene.position = mousePos

		add_child(dummyScene)
	
	if (event.is_action_pressed("Attack")):
		var mousePos: Vector2 = get_global_mouse_position()

		for child: Node in get_children():
			if (child is Dummy):
				var hurtbox: Hurtbox = child.get_node("Hurtbox")
				var collision: CollisionShape2D = hurtbox.get_node("Collision")
				if (collision.shape.get_rect().has_point(collision.to_local(mousePos))):
					child.takeAttack(attack)
	
	if (event.is_action_pressed("Fire")):
		selectElement(elements[0])
	if (event.is_action_pressed("Electric")):
		selectElement(elements[1])
	if (event.is_action_pressed("Cold")):
		selectElement(elements[2])


func selectElement(element: GDScript) -> void:
	attack.element = element
	
	elementSymbol.texture = load(element.resource_path.get_basename() + ".png")
