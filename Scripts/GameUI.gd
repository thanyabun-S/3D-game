extends Control

@onready var coinsLabel: Label = $CoinsLabel
@onready var tutorial_label: Label = $TutorialLabel
@export var target_coins: int = 10

var has_won: bool = false

func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	await get_tree().create_timer(7.0).timeout
	if tutorial_label:
		tutorial_label.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if event is InputEventKey and event.pressed and event.keycode == KEY_F11:
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _process(_delta: float) -> void:
	if GameManager.score >= target_coins and not has_won:
		has_won = true
		game_win()
	elif not has_won:
		coinsLabel.text = "x %d" % GameManager.score

func game_win() -> void:
	print("ชนะเกมแล้ว!")
	coinsLabel.text = "YOU WIN!\nPress ESC to Exit"
	
