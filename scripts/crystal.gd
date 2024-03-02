extends Node2D

@onready var player: Player = get_tree().get_first_node_in_group(&"player") as Player
@onready var anim: AnimationPlayer = $Sprite2D/AnimationPlayer
@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer

var player_position: Vector2
func _ready() -> void:
	animation_player.speed_scale = randf_range(0.9, 1.1)

func _on_left_area_entered(area: Area2D) -> void:
	if area.is_in_group(&"upgrade_collider") and PlayerStats.can_abberate:
		anim.play("grow")
		for i in PlayerStats.current_tweens:
			i.kill()
		player_position = global_position + Vector2(16 + 64, 16)
		tween_player()


func _on_right_area_entered(area: Area2D) -> void:
	if area.is_in_group(&"upgrade_collider") and PlayerStats.can_abberate:
		anim.play("grow")
		for i in PlayerStats.current_tweens:
			i.kill()
		player_position = global_position + Vector2(16 - 64, 16)
		tween_player()


func _on_down_area_entered(area: Area2D) -> void:
	if area.is_in_group(&"upgrade_collider") and PlayerStats.can_abberate:
		anim.play("grow")
		for i in PlayerStats.current_tweens:
			i.kill()
		player_position = global_position + Vector2(16, -64 + 16)
		tween_player()

func _on_up_area_entered(area: Area2D) -> void:
	if area.is_in_group(&"upgrade_collider") and PlayerStats.can_abberate:
		anim.play("grow")
		for i in PlayerStats.current_tweens:
			i.kill()
		player_position = global_position + Vector2(16, 64 + 16)
		tween_player()

func tween_player():
	PlayerStats.can_abberate = false
	var tween = player.create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(player, "global_position", player_position, 0.33)
	player.placer.global_position = player_position
	await tween.finished
	PlayerStats.can_abberate = true
