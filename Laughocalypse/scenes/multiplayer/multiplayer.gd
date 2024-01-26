extends Node

const PORT = 28960
#const ADDRESS = "49.13.33.38"
const ADDRESS = "127.0.0.1"
const MAX_CONNECTIONS = 100
var game = {
	"players": {}
}

func _ready():
	multiplayer.peer_connected.connect(_on_per_connected)
	multiplayer.connected_to_server.connect(_on_player_connected)

	if DisplayServer.get_name() == "headless":
		var peer = ENetMultiplayerPeer.new()
		peer.set_bind_ip(ADDRESS)
		var error = peer.create_server(PORT, MAX_CONNECTIONS)
		multiplayer.multiplayer_peer = peer
		print("started the server on port " + str(PORT))
	else:
		var peer = ENetMultiplayerPeer.new()
		var error = peer.create_client(ADDRESS, PORT)
		multiplayer.multiplayer_peer = peer
		
func _on_player_connected():
	print(multiplayer.get_unique_id())

func _on_per_connected(id):
	game.players[id] = {
		"name": 123
	}
