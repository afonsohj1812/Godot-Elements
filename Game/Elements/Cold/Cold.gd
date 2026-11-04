class_name Cold extends Element


@export var slow: float = 0.25
@export var auraSlow: float = 0.5
@export var auraRadius: float = 50

var slowed: Array[Entity] = []


func start() -> void:
	entity.slows.append(slow)

	var shape: CircleShape2D = CircleShape2D.new()
	shape.radius = auraRadius

	var collision: CollisionShape2D = CollisionShape2D.new()
	collision.shape = shape

	var aura: Area2D = Area2D.new()
	aura.area_entered.connect(_on_aura_entered)
	aura.area_exited.connect(_on_aura_exited)
	aura.monitorable = false	

	aura.add_child(collision)
	add_child(aura)


func stop() -> void:
	entity.slows.erase(slow)
	
	super.stop()


func _on_aura_entered(area: Area2D) -> void:
	var hurtbox: Hurtbox = area as Hurtbox
	if (hurtbox == null or hurtbox.owner == entity):
		return

	hurtbox.owner.slows.append(auraSlow)
	slowed.append(hurtbox.owner)


func _on_aura_exited(area: Area2D) -> void:
	var hurtbox: Hurtbox = area as Hurtbox
	if (hurtbox == null or not is_instance_valid(hurtbox.owner) or not slowed.has(hurtbox.owner)):
		return

	release(hurtbox.owner)


func _exit_tree() -> void:
	for other in slowed:
		if (is_instance_valid(other)):
			other.slows.erase(auraSlow)

	slowed.clear()


func release(other: Entity) -> void:
	other.slows.erase(auraSlow)
	slowed.erase(other)
