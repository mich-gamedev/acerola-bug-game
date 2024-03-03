extends Node2D

@onready var collision: CollisionShape2D = $HurtBox/CollisionShape2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var particles: CPUParticles2D = $CPUParticles2D

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	anim.play("default")

func _process(delta: float) -> void:
	if anim.frame == 5: collision.set_deferred("disabled", false)

func _on_animated_sprite_2d_animation_finished() -> void:
	particles.emitting = false
	await particles.finished
	queue_free()
