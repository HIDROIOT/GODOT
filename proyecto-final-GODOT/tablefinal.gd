extends Node3D

var mediciones = []
var actualizando = false  # Bandera para evitar múltiples inicios

@onready var texto = Label3D.new()
@onready var timer := Timer.new()  # Crear un Timer para la espera inicial

func _ready():
	texto.position = Vector3(0, -0.2, 0)
	texto.font_size = 12
	add_child(texto)

	# Configurar el timer para esperar 5 segundos antes de iniciar
	timer.wait_time = 5
	timer.one_shot = true  # Solo se ejecuta una vez
	timer.connect("timeout", Callable(self, "_iniciar_actualizacion"))
	add_child(timer)

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_HOME:
		if not actualizando:  # Evita múltiples inicios
			print("⏳ Esperando 5 segundos antes de iniciar mediciones...")
			actualizando = true
			timer.start()  # Inicia la cuenta regresiva

func _iniciar_actualizacion():
	print("✅ Comenzando mediciones...")
	actualizar_datos()
	
	# Configurar un timer para actualizar cada 3 segundos
	var update_timer = Timer.new()
	update_timer.wait_time = 3
	update_timer.autostart = true
	update_timer.connect("timeout", Callable(self, "actualizar_datos"))
	add_child(update_timer)

func actualizar_datos():
	var voltaje = randf_range(3.5, 5.0)
	var amperaje = (0.02 + randf_range(0, 0.01)) * 1000  # Convertir a mA
	var potencia = (voltaje * amperaje) / 1000  # Calcular potencia

	voltaje = int(voltaje * 100) / 100.0
	amperaje = int(amperaje * 100) / 100.0
	potencia = int(potencia * 100) / 100.0

	mediciones.append([voltaje, amperaje, potencia])

	if mediciones.size() > 5:
		mediciones.pop_front()

	actualizar_texto()

func actualizar_texto():
	var tabla_texto = ""

	for medicion in mediciones:
		tabla_texto += str(medicion[0]) + "V  |  " + str(medicion[1]) + "mA  |  " + str(medicion[2]) + "W\n"

	texto.text = tabla_texto
