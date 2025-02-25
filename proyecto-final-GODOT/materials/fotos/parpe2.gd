extends MeshInstance3D

# Tiempo de parpadeo en segundos
var blink_time : float = 0.3  # Cambia este valor para más o menos velocidad
var timer : float = 0.0

func _ready():
	# Inicializa el tiempo al principio
	timer = blink_time

func _process(delta):
	# Reducir el temporizador con el tiempo
	timer -= delta

	# Si el temporizador llega a 0, alterna la visibilidad
	if timer <= 0:
		# Alterna la visibilidad del objeto
		visible = !visible
		
		# Restablecer el temporizador
		timer = blink_time
