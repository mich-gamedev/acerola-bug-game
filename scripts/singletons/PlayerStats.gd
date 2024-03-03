extends Node

signal abberation_hit(abberation: Node)
signal player_moved(direction: Vector2)

var can_abberate: bool = true
var can_move: bool = true

var absolute_position: Vector2
var health: int
var current_tweens: Array[Tween] = []
