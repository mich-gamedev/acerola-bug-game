extends Node2D
class_name Player

@onready var placer: Node2D = $Placer
@onready var left_check: Area2D = $Placer/LeftCheck
@onready var right_check: Area2D = $Placer/RightCheck
@onready var up_check: Area2D = $Placer/UpCheck
@onready var down_check: Area2D = $Placer/DownCheck
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

const cell_size = 32


func _ready() -> void:
	placer.global_position = global_position 

func _process(_delta: float) -> void:
	PlayerStats.absolute_position = placer.global_position
	if PlayerStats.can_move:
		handle_inputs()

func tween_new_position():
	print("tweening")
	var tween := get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, "global_position", placer.global_position, 0.33)
	PlayerStats.current_tweens.append(tween)
	await tween.finished
	PlayerStats.current_tweens.erase(tween)

func handle_inputs() -> void:
	if Input.is_action_just_pressed("move_left") and !left_check.has_overlapping_bodies():
		anim.stop()
		anim.play(&"walk")
		anim.flip_h = true
		placer.position += Vector2.LEFT * cell_size
		PlayerStats.player_moved.emit(Vector2.LEFT)
		PlayerStats.can_abberate = true
		tween_new_position()

	if Input.is_action_just_pressed("move_right") and !right_check.has_overlapping_bodies():
		anim.stop()
		anim.play(&"walk")
		anim.flip_h = false
		placer.position += Vector2.RIGHT * cell_size
		PlayerStats.can_abberate = true
		PlayerStats.player_moved.emit(Vector2.RIGHT)
		tween_new_position()

	if Input.is_action_just_pressed("move_up") and !up_check.has_overlapping_bodies():
		anim.stop()
		anim.play(&"up")
		placer.position += Vector2.UP * cell_size
		PlayerStats.can_abberate = true
		PlayerStats.player_moved.emit(Vector2.UP)
		tween_new_position()

	if Input.is_action_just_pressed("move_down") and !down_check.has_overlapping_bodies():
		anim.stop()
		anim.play(&"down")
		placer.position += Vector2.DOWN * cell_size
		PlayerStats.can_abberate = true
		PlayerStats.player_moved.emit(Vector2.DOWN)
		tween_new_position()


func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.animation == &"walk" or anim.animation == &"down" or anim.animation == &"up":
		anim.play(&"idle")
