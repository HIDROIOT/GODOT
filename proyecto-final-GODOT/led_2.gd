extends Node3D

@onready var led_light = $OmniLight3D
var udp = PacketPeerUDP.new()
var udp_port = 12345  # Puerto UDP

func _ready():
	led_light.visible = false
	
	# Configurar el socket UDP para recibir datos
	if udp.bind(udp_port) == OK:
		print("🔊 Escuchando en el puerto UDP:", udp_port)
	else:
		print("❌ No se pudo iniciar el servidor UDP.")

func _process(_delta):
	# Verificar si hay datos disponibles
	if udp.get_available_packet_count() > 0:
		# Leer el paquete UDP
		var packet = udp.get_packet()
		var raw_data = packet.get_string_from_utf8().strip_edges()
		
		if not raw_data.is_empty():
			print("📥 Datos crudos recibidos en Godot:", raw_data)  # Depuración
			_on_data_received(raw_data)

func _on_data_received(message):
	var data = message.split(",")
	if data.size() >= 3:
		# Convertir los valores a float
		var voltaje = float(data[0])
		var corriente = float(data[1])
		var potencia = float(data[2])

		print("⚡ Voltaje:", voltaje, "V | 🔌 Corriente:", corriente, "A | 💡 Potencia:", potencia, "W")

		# Encender o apagar el LED según los valores recibidos
		if voltaje >= 0.5  and voltaje <= 5.0 and corriente >= 5.0 and corriente <= 20.0:
			print("💡 Encendiendo LED")
			led_light.visible = true
		else:
			print("🚫 Apagando LED")
			led_light.visible = false
	else:
		print("⚠️ Datos incompletos recibidos:", message)
