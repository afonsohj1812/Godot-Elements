class_name Element extends Node2D


@export var icon: Texture2D
@export var duration: float = 6
@export var tickRate: float = 1

var entity: Entity
var durationTimer: Timer
var tickTimer: Timer


func _ready() -> void:
	entity = get_parent()

	for child: Node in entity.get_children():
		if (child is Element and child != self and not child.is_queued_for_deletion()):
			if (child.get_script() == get_script()):
				child.durationTimer.start()
				queue_free()
				return

			child.stop() # TODO: Reaction

	durationTimer = addTimer(duration, stop, true)
	tickTimer = addTimer(tickRate, tick)

	# Element Symbol Above Entity
	var symbol: Sprite2D = Sprite2D.new()
	symbol.position = entity.symbolOffset
	symbol.scale.x = sign(entity.scale.x)
	symbol.texture = icon
	add_child(symbol)

	start()


func addTimer(time: float, callback: Callable, oneShot: bool = false) -> Timer:
	var timer: Timer = Timer.new()
	timer.wait_time = time
	timer.one_shot = oneShot

	timer.timeout.connect(callback)
	add_child(timer)
	
	timer.start()
	return timer


func start() -> void:
	pass


func tick() -> void:
	pass


func stop() -> void:
	queue_free()


func nearby(radius: float) -> Array[Entity]:
	var entities: Array[Entity] = []
	for other: Entity in get_tree().get_nodes_in_group(Entity.GROUP):
		if (other != entity and other.global_position.distance_to(entity.global_position) <= radius):
			entities.append(other)

	entities.sort_custom(isCloser)
	return entities


func isCloser(a: Entity, b: Entity) -> bool:
	return a.global_position.distance_to(entity.global_position) < b.global_position.distance_to(entity.global_position)
