extends Area3D

@export_file("*.tscn", "*.scn") var next_level_path: String
@export var required_coins: int = 5 # จำนวนเหรียญที่ต้องใช้เพื่อผ่านด่าน

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		# เช็กว่าเก็บเหรียญถึง 5 หรือยัง
		if GameManager.score >= required_coins:
			if next_level_path != "":
				print("เหรียญครบแล้ว! ไปด่านถัดไป")
				get_tree().change_scene_to_file(next_level_path)
			else:
				print("ยังไม่ได้ใส่ next_level_path")
		else:
			print("ยังไปไม่ได้! ต้องเก็บเหรียญให้ครบ %d เหรียญก่อน (ตอนนี้มี %d)" % [required_coins, GameManager.score])
