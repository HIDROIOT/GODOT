extends Node3D

# Variables para voltaje, amperaje e intensidad
var voltaje = 3.5
var amperaje = 0.02  # Ejemplo de amperaje
var potencia = voltaje * amperaje  # Potencia calculada

@onready var mesh_instance = $MeshInstance3D  # Asegúrate de que el nodo existe en la escena
@onready var texto = Label3D.new()  # Crear el Label3D

func _ready():
	# Verificar si el nodo MeshInstance3D está presente
	if mesh_instance == null:
		print("Error: MeshInstance3D no encontrado en la escena.")
		return  # Detener el código si el nodo no se encuentra

	# Posicionar el texto sobre el MeshInstance3D
	texto.position = Vector3(0, 0.5, 0)  # Ajusta esta posición según necesites

	# Tamaño del texto
	texto.font_size = 32

	# Generar el texto de la tabla
	actualizar_texto()

	# Añadir el Label3D como hijo del MeshInstance3D
	mesh_instance.add_child(texto)

	# Simulación de cambio en los valores (por ejemplo, incrementando el voltaje)
	voltaje += 0.2
	amperaje = 0.02 + randf_range(0, 0.01)  # Variación aleatoria en amperaje
	potencia = voltaje * amperaje

	# Actualizar el texto después de 1 segundo
	await get_tree().create_timer(1.0).timeout  # Espera 1 segundo
	actualizar_texto()  # Actualiza el texto con los nuevos valores

# Función para actualizar el texto
func actualizar_texto():
	var tabla_texto = "Voltaje (V) | Amperaje (A) | Potencia (W)\n"
	tabla_texto += str(voltaje) + "V        | " + str(amperaje) + "A        | " + str(potencia) + "W\n"
	texto.text = tabla_texto
