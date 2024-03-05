extends Node2D

@export var activators: Array[ActivatingButton]
@onready var sprite: Sprite2D = $Sprite2D

const WRENCH = preload("res://obj/upgrades/wrench.tscn")
const SPEED := 120

func _ready() -> void:
	activators.all(func(a: ActivatingButton): a.area_entered.connect(fire_bullet))

func fire_bullet(area: Area2D):
	if area.is_in_group(&"upgrade_collider"):
		var bullet: CharacterBody2D = WRENCH.instantiate() as CharacterBody2D
		get_tree().current_scene.call_deferred("add_child", bullet)
		bullet.global_position = sprite.global_position
		bullet.velocity = Vector2.DOWN * SPEED
