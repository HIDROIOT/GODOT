extends Label3D

@export var turbina: Node3D  # Referencia a la turbina

func _process(_delta):
	if turbina and turbina.has_method("_actualizar_potencia"):
		text = "Potencia Actual: %.3f" % turbina.potencia_actual
