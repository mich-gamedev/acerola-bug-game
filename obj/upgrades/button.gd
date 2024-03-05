extends Area2D
class_name ActivatingButton

@onready var anim: AnimationPlayer = $AnimationPlayer

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group(&"upgrade_collider"):
		anim.play(&"player_on_button")

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group(&"upgrade_collider"):
		anim.play(&"player_off_button")
