extends Node

const PORT = 7000
const MAX_CONNECTIONS = 100
var players = {}

func _ready():
	if DisplayServer.get_name() == "headless":
		var peer = ENetMultiplayerPeer.new()
		var error = peer.create_server(PORT, MAX_CONNECTIONS)
		multiplayer.multiplayer_peer = peer
		print("started the server on port " + str(PORT))
		pass

