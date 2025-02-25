extends MeshInstance3D

func _ready():
	# Crear el SubViewport
	var sub_viewport = SubViewport.new()
	sub_viewport.size = Vector2(512, 512)
	sub_viewport.transparent_bg = true
	add_child(sub_viewport)

	# Crear un Control dentro del SubViewport
	var control = Control.new()
	sub_viewport.add_child(control)

	# Crear un Label para el texto de la tabla
	var label = Label.new()
	label.text = "Hierro    Cobre    Madera    Vidrio"  # Nombres en la tabla
	label.add_theme_font_size_override("font_size", 32)
	label.set_position(Vector2(50, 200))
	control.add_child(label)

	# Crear una textura a partir del SubViewport
	var texture = sub_viewport.get_texture()

	# Aplicar la textura a la tabla
	var material = StandardMaterial3D.new()
	material.albedo_texture = texture
	mesh.surface_set_material(0, material)
