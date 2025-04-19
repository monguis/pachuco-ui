extends Node2D

signal roll_finished(result: int)

@onready var sprite := $AnimatedSprite2D
const ROLL_DURATION := 2 # seconds

func _ready():
	randomize()

func roll(result: int) -> void:
	sprite.play("roll")
	await get_tree().create_timer(ROLL_DURATION).timeout
	sprite.play("land_%d" % result)
	emit_signal("roll_finished", result)
