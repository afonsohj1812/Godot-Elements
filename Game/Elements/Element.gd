class_name Element extends Node2D


@export var icon: Texture2D
@export var color: Color
@export var particles: Array[GPUParticles2D]

@export var duration: float = 6
@export var tickRate: float = 1

var entity: Entity
var durationTimer: Timer
var tickTimer: Timer


static func create(script: GDScript) -> Element:
	return load(script.resource_path.get_basename() + ".tscn").instantiate()


func _ready() -> void:
	entity = get_parent()
	entity.died.connect(stop)

	durationTimer = addTimer(duration, stop, true)
	tickTimer = addTimer(tickRate, tick)

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
	tick()


func tick() -> void:
	pass


func stop() -> void:
	for emitter: GPUParticles2D in particles:
		if (not emitter.one_shot):
			emitter.emitting = false
		emitter.reparent(entity if entity.health > 0 else entity.get_parent())
		get_tree().create_timer(emitter.lifetime).timeout.connect(emitter.queue_free)

	queue_free()


func refresh() -> void:
	durationTimer.start()


func nearby(radius: float) -> Array[Entity]:
	var entities: Array[Entity] = []
	for other: Entity in get_tree().get_nodes_in_group(Entity.GROUP):
		if (other != entity and other.global_position.distance_to(entity.global_position) <= radius):
			entities.append(other)

	entities.sort_custom(isCloser)
	return entities


func isCloser(a: Entity, b: Entity) -> bool:
	return a.global_position.distance_to(entity.global_position) < b.global_position.distance_to(entity.global_position)
