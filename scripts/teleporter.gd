extends Abberation
class_name Teleporter

@export var other_teleporter: Teleporter
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimatedSprite2D/AnimationPlayer

func _ready() -> void:
	super()
	animation_player.speed_scale = randf_range(0.9, 1.1)

func _player_entered(player_area: Area2D, player: Player):
	for i in PlayerStats.current_tweens:
		i.kill()
	PlayerStats.can_abberate = false
	PlayerStats.can_move = false

	var fade_tween = player.create_tween()
	fade_tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	fade_tween.tween_property(player, "scale", Vector2.ZERO, 0.5)
	fade_tween.parallel().tween_property(player, "global_position", anim.global_position + Vector2(0,-6), 0.5).set_ease(Tween.EASE_OUT)
	fade_tween.parallel().tween_property(player, "rotation_degrees", 180.0, 0.5)

	await fade_tween.finished
	player.global_position = other_teleporter.global_position + Vector2(16, 16)
	player.placer.global_position = other_teleporter.global_position + Vector2(16, 16)
	player.rotation = 0.0
	PlayerStats.can_move = true
	
	var exit_tween = player.create_tween()
	exit_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	exit_tween.tween_property(player, "scale", Vector2(1,1), 0.25)
	await exit_tween.finished
