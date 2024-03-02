extends Node

signal abberation_hit(abberation: Node)
signal player_moved(direction: Vector2)

var can_abberate: bool = true
var can_move: bool = true

var current_tweens: Array[Tween] = []
