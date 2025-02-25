extends MeshInstance3D

func _ready():
	var circle_mesh = CylinderMesh.new()
	circle_mesh.radial_segments = 32  # Número de segmentos para hacer el círculo suave
	circle_mesh.height = 0.1  # Grosor muy pequeño para que parezca un disco plano
	self.mesh = circle_mesh  # Asigna la malla al MeshInstance
