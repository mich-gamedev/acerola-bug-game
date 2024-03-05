extends CharacterBody2D

@onready var timer: Timer = $Timer

func _process(_delta: float) -> void:
	move_and_slide()


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.is_in_group(&"upgrade_collider"):
		queue_free.call_deferred()


func _on_hurt_box_body_entered(_body: Node2D) -> void:
	if !timer.time_left:
		queue_free.call_deferred()
