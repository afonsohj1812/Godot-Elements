class_name CombinedElement extends Element


@export var first: GDScript
@export var second: GDScript

var trigger: GDScript


static func combine(aura: Element, _trigger: Element) -> CombinedElement:
	for info: Dictionary in ProjectSettings.get_global_class_list():
		if (info.base == &"CombinedElement"):
			var combined: CombinedElement = Element.create(load(info.path))
			if (combined.combines(aura, _trigger)):
				combined.trigger = _trigger.get_script()
				return combined

			combined.free()

	return null


func combines(aura: Element, other: Element) -> bool:
	var pair: Array = [aura.get_script(), other.get_script()]
	return pair == [first, second] or pair == [second, first]
