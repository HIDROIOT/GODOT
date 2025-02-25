extends MeshInstance3D

@export var velocidad_base: float = 1  # Velocidad mínima de giro
@export var velocidad_max: float = 3.0   # Velocidad máxima según la potencia
var potencia_actual: float = 0.0  # Potencia dinámica del agua
var tiempo_inicio: float = 1  # Segundos antes de iniciar
var girando: bool = false  # Estado de la turbina
@onready var label = $CanvasLayer/Label  # Accede al Label dentro de CanvasLayer

# Rango ideal para cada parámetro
var flujo_ideal_min: float = 8.0  # Flujo mínimo ideal (L/min)
var flujo_ideal_max: float = 15.0  # Flujo máximo ideal (L/min)
var presion_ideal_min: float = 0.08  # Presión mínima ideal (Pa)
var presion_ideal_max: float = 0.15  # Presión máxima ideal (Pa)

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_HOME:
		iniciar_turbina()

func iniciar_turbina():
	if not girando:  # Solo inicia si no está ya girando
		girando = true
		print("✅ Turbina iniciando después de ", tiempo_inicio, " segundos.")
		await get_tree().create_timer(tiempo_inicio).timeout
		_actualizar_potencia()

func _process(delta):
	if girando:
		rotate_x(potencia_actual * delta)

func _actualizar_potencia():
	while girando:
		# Flujo y presión aleatorios dentro de un rango más amplio
		var flujo_agua = randf_range(5.0, 25.0)  # Flujo entre 5 y 25 Litros/min
		var presion = randf_range(0.05, 0.25)  # Presión entre 0.05 y 0.25 Pascales

		# Potencia calculada con un factor de variabilidad para mayor aleatoriedad
		potencia_actual = flujo_agua * presion * 0.1  # Aquí puedes ajustar el factor multiplicativo

		# Clamping de potencia entre los valores base y máximo
		potencia_actual = clamp(potencia_actual, velocidad_base, velocidad_max)

		# Redondeo de la potencia a 2 decimales
		potencia_actual = int(potencia_actual * 100 + 0.5) / 100.0

		# Mostrar los valores en el Label con sus unidades
		if label:
			var texto = "📊 **Datos de la Turbina**\n"
			texto += "Flujo de Agua: %.2f L/min (Rango Ideal: %.2f - %.2f L/min)\n" % [flujo_agua, flujo_ideal_min, flujo_ideal_max]
			texto += "Presión: %.3f Pa (Rango Ideal: %.3f - %.3f Pa)\n" % [presion, presion_ideal_min, presion_ideal_max]
			texto += "Potencia: %.2f W\n" % potencia_actual
			label.text = texto

		# También imprimir en consola para referencia
		print("Flujo de Agua: %.2f L/min" % flujo_agua)
		print("Presión: %.3f Pa" % presion)
		print("Potencia calculada: %.2f W" % potencia_actual)

		await get_tree().create_timer(1).timeout
