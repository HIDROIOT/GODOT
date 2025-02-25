extends Node

var websocket = WebSocketClient.new()

func _ready():
	websocket.connect_to_url("ws://localhost:8765")
	websocket.connect("data_received", self, "_on_data_received")

func _on_data_received():
	var data = websocket.get_peer(1).get_packet().get_string_from_utf8()
	print("Datos recibidos del ESP32:", data)

func _process(delta):
	if websocket.get_connection_status() == WebSocketClient.CONNECTION_CONNECTED:
		# Enviar datos al ESP32
		websocket.get_peer(1).put_packet("Hola desde Godot".to_utf8())
