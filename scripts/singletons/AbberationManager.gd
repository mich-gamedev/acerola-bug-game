extends Node

var level_rect := Rect2(Vector2(96, 48), Vector2(416, 288))
var abberations: Array[PackedScene] = [
	preload("res://obj/abberations/lava.tscn")
]

func _process(_delta: float) -> void:
	if randi_range(1, 20) == 1:
		var new_abberation: Node2D = abberations.pick_random().instantiate()
		add_child(new_abberation)
		new_abberation.global_position = snapped(Vector2(randi_range(level_rect.position.x, level_rect.end.x), randi_range(level_rect.position.y, level_rect.end.y)), Vector2(32,32)) + Vector2(0, -16)
