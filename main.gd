extends Node2D

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_login_pressed() -> void:
	Auth.start_login()
