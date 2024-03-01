extends Node2D

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
	handle_inputs()

func tween_new_position():
	print("tweening")
	var tween := get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, "global_position", placer.global_position, 0.33)
	await PlayerStats.abberation_hit
	tween.kill()

func handle_inputs() -> void:
	if Input.is_action_just_pressed("move_left") and !left_check.has_overlapping_bodies():
		anim.play(&"dash")
		anim.flip_h = true
		placer.position += Vector2.LEFT * cell_size
		PlayerStats.can_teleport = true
		tween_new_position()

	if Input.is_action_just_pressed("move_right") and !right_check.has_overlapping_bodies():
		anim.play(&"dash")
		anim.flip_h = false
		placer.position += Vector2.RIGHT * cell_size
		PlayerStats.can_teleport = true
		tween_new_position()

	if Input.is_action_just_pressed("move_up") and !up_check.has_overlapping_bodies():
		anim.play(&"dash")
		placer.position += Vector2.UP * cell_size
		PlayerStats.can_teleport = true
		tween_new_position()

	if Input.is_action_just_pressed("move_down") and !down_check.has_overlapping_bodies():
		anim.play(&"dash")
		placer.position += Vector2.DOWN * cell_size
		PlayerStats.can_teleport = true
		tween_new_position()
