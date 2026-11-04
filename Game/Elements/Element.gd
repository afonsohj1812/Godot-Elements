class_name Element extends Node2D


@export var duration: float = 6
@export var tickRate: float = 1

var entity: Entity
var durationTimer: Timer


func _ready() -> void:
	entity = get_parent()

	for child: Node in entity.get_children():
		if (child is Element and child != self and not child.is_queued_for_deletion()):
			if (child.get_script() == get_script()):
				child.durationTimer.start()
				queue_free()
				return

			child.stop() # TODO: Reaction

	# Start Timers
	durationTimer = Timer.new()
	durationTimer.wait_time = duration
	durationTimer.one_shot = true
	durationTimer.timeout.connect(stop)
	
	add_child(durationTimer)
	durationTimer.start()

	var tickTimer: Timer = Timer.new()
	tickTimer.wait_time = tickRate
	tickTimer.timeout.connect(tick)
	
	add_child(tickTimer)
	tickTimer.start()

	start()


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
