# WebSocketService.gd
extends Node

class_name WebSocketService

signal connected
signal connection_closed
signal message_received(message)

var ws_peer : WebSocketPeer = WebSocketPeer.new()
var reconnect_delay := 2.0
var url := "wss://your.server.com/ws"

func _ready():
	_setup_signals()
	_connect_to_server()

func _process(_delta):
	if ws_peer.get_ready_state() == WebSocketPeer.STATE_OPEN:
		ws_peer.poll()  # Poll for messages

func _setup_signals():
	# Connect signals properly in Godot 4.x (use Callable objects)
	ws_peer.connect("connected", Callable(self, "_on_connected"))
	ws_peer.connect("connection_closed", Callable(self, "_on_closed"))
	ws_peer.connect("data_received", Callable(self, "_on_data"))
	ws_peer.connect("error", Callable(self, "_on_error"))

func _connect_to_server():
	var err = ws_peer.connect_to_url(url)
	if err != OK:
		push_error("WebSocket connection error: %s" % err)

func _on_connected(proto: String):
	print("✅ Connected to WebSocket")
	emit_signal("connected")
	send_json({ "type": "join", "name": OS.get_name() })

func _on_closed(code: int, reason: String, clean: bool):
	print("❌ Disconnected: %s" % reason)
	emit_signal("connection_closed")
	# Optionally reconnect after delay
	get_tree().create_timer(reconnect_delay).timeout.connect(Callable(self, "_connect_to_server"))

func _on_error():
	push_error("WebSocket error!")

func _on_data():
	var raw = ws_peer.get_packet().get_string_from_utf8()
	var data := {}
	if raw.begins_with("{"):
		data = JSON.parse_string(raw)
	emit_signal("message_received", data)

func send_json(data: Dictionary):
	if ws_peer.get_ready_state() == WebSocketPeer.STATE_OPEN:
		ws_peer.send_text(JSON.stringify(data))
