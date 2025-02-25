extends GPUParticles3D

@onready var timer := Timer.new()  # Crear un Timer en código

func _ready():
	emitting = false  # Apagar partículas al inicio
	timer.wait_time = 1.0  # Tiempo de espera en segundos
	timer.one_shot = true  # Para que solo se ejecute una vez
	timer.timeout.connect(_on_timer_timeout)  # Conectar la señal manualmente
	add_child(timer)  # Agregar el Timer a la escena

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_HOME:
		timer.start()  # Iniciar el Timer

func _on_timer_timeout():
	emitting = true  # Encender las partículas cuando el Timer termine
