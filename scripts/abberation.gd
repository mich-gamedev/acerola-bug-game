extends Area2D
class_name Abberation

func _ready() -> void:
	area_entered.connect(area_check)

func area_check(area: Area2D):
	if area.is_in_group(&"upgrade_collider") and PlayerStats.can_abberate:
		_player_entered(area, get_tree().get_first_node_in_group(&"player"))

func _player_entered(player_collider: Area2D, player: Player) -> void:
	pass
