extends Node3D

func _ready():
	# Crear la tabla de madera
	var tabla = MeshInstance3D.new()
	tabla.mesh = BoxMesh.new()
	tabla.mesh.size = Vector3(4, 0.2, 2)  # Tamaño de la tabla
	tabla.position = Vector3(0, 0, 0)  # Posición en la escena
	
	# Cargar textura de madera
	var material = StandardMaterial3D.new()
	material.albedo_texture = load("res://texturas/madera.png")  # Asegúrate de tener la textura en tu proyecto
	tabla.mesh.surface_set_material(0, material)
	
	add_child(tabla)

	# Nombres de los materiales
	var materiales = ["Hierro", "Cobre", "Madera", "Vidrio"]
	var posiciones = [Vector3(-1.5, 0.15, 0.5), Vector3(-0.5, 0.15, 0.5), 
					  Vector3(0.5, 0.15, 0.5), Vector3(1.5, 0.15, 0.5)]

	for i in range(len(materiales)):
		var label = TextMesh.new()
		label.text = materiales[i]
		
		var text_instance = MeshInstance3D.new()
		text_instance.mesh = label
		text_instance.position = posiciones[i]  # Ubicación sobre la tabla
		text_instance.scale = Vector3(0.2, 0.2, 0.2)  # Ajustar tamaño del texto

		add_child(text_instance)
