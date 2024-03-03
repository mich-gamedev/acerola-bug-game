extends Area2D
class_name HurtBox

@export var damage: int = 1

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group(&"upgrade_collider"):
		PlayerStats.health -= damage
