extends Node

# Señal para notificar cuando se reciben nuevos datos
signal datos_recibidos(voltaje, corriente, potencia)

var udp = PacketPeerUDP.new()
var udp_port = 12345  # Puerto UDP

func _ready():
	# Configurar el socket UDP para recibir datos
	if udp.bind(udp_port) == OK:
		print("🔊 Conexión UDP iniciada en el puerto:", udp_port)
	else:
		print("❌ No se pudo iniciar la conexión UDP.")

func _process(_delta):
	# Verificar si hay datos disponibles
	if udp.get_available_packet_count() > 0:
		# Leer el paquete UDP
		var packet = udp.get_packet()
		var raw_data = packet.get_string_from_utf8().strip_edges()
		
		if not raw_data.is_empty():
			print("📥 Datos crudos recibidos:", raw_data)  # Depuración
			_procesar_datos(raw_data)

func _procesar_datos(message):
	# Dividir los datos en voltaje, corriente y potencia
	var data = message.split(",")
	if data.size() >= 3:
		# Tomar los valores directamente sin conversiones
		var voltaje = data[0]
		var corriente = data[1]
		var potencia = data[2]

		# Emitir la señal con los datos recibidos
		emit_signal("datos_recibidos", voltaje, corriente, potencia)
	else:
		print("⚠️ Datos incompletos recibidos:", message)
