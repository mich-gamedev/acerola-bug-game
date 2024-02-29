extends Area2D
class_name Teleporter

@export var other_teleporter: Teleporter

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group(&"upgrade_collider") and PlayerStats.can_teleport:
		var player := get_tree().get_first_node_in_group(&"player") as Node2D
		PlayerStats.abberation_hit.emit(self)
		player.global_position = other_teleporter.global_position + Vector2(16,16)
		player.placer.global_position = other_teleporter.global_position + Vector2(16,16)
		PlayerStats.can_teleport = false
