# Nombre del script: LabelTabla.gd
extends Label3D

# Variables para almacenar los datos
var voltaje = 3.5
var amperaje = 0.02
var potencia = voltaje * amperaje

# Función que actualiza el texto
func actualizar_texto():
	var tabla_texto = "Voltaje (V) | Amperaje (A) | Potencia (W)\n"
	tabla_texto += str(voltaje) + "V        | " + str(amperaje) + "A        | " + str(potencia) + "W\n"
	self.text = tabla_texto

# Función para modificar los valores y actualizar el texto
func set_valores(v: float, a: float):
	voltaje = v
	amperaje = a
	potencia = voltaje * amperaje
	actualizar_texto()
