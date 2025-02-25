extends Node3D  # Usa Node2D si es en 2D

@export var camera1: Camera3D
@export var camera2: Camera3D
@export var camera3: Camera3D
@export var camera4: Camera3D
@export var camera5: Camera3D
func _input(event):
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_1:
				change_camera(camera1)
			KEY_2:
				change_camera(camera2)
			KEY_3:
				change_camera(camera3)
			KEY_4:
				change_camera(camera4)
			KEY_5:
				change_camera(camera5)


func change_camera(new_camera):
	if new_camera:
		camera1.current = false
		camera2.current = false
		camera3.current = false
		camera4.current = false
		new_camera.current = true
