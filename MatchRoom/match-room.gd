extends Node2D

@onready var dice := $Dice
@onready var dice2 := $Dice2
@onready var dice3 := $Dice3
@onready var dice4 := $Dice4
@onready var dice5 := $Dice5
@onready var roll_button := $RollButton

#func _ready():
	#dice.roll_finished.connect(_on_dice_rolled)

func _on_dice_rolled(result: int) -> void:
	print("Dice rolled:", result)
	roll_button.disabled = false
	# You can trigger further logic here (e.g., player turn, animation, etc.)

func _on_button_pressed() -> void:
	roll_button.disabled = true  # Prevent spamming
	dice.roll(2)
	dice2.roll(2)
	dice3.roll(1)
	dice4.roll(3)
	dice5.roll(2)
