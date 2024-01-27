extends Node


const PORT = 28960
#const ADDRESS = "49.13.33.38"
const ADDRESS = "127.0.0.1"
const MAX_CONNECTIONS = 100
var game = {
	"players": {}
}
var myId = 0
var name2 = ""

func _ready():
	if DisplayServer.get_name() == "headless":
		var peer = ENetMultiplayerPeer.new()
		peer.set_bind_ip(ADDRESS)
		var error = peer.create_server(PORT, MAX_CONNECTIONS)
		multiplayer.set_multiplayer_peer(peer)
		print("started the server on port " + str(PORT))
		name2 = generate_word(characters, 5)
		multiplayer.peer_connected.connect(_on_peer_connected)
		print("wtfwtf")
	else:
		var peer = ENetMultiplayerPeer.new()
		var error = peer.create_client(ADDRESS, PORT)
		multiplayer.set_multiplayer_peer(peer)
		myId = peer.get_unique_id()
		name2 = generate_word(characters, 5)
		multiplayer.connected_to_server.connect(_on_connected_to_server)
		print("wtf")

func _on_connected_to_server():
	print("ja")
	#SendPlayerInformation.rpc_id(id, name2)

# get called on server
func _on_peer_connected(id):
	print(id)
	#SendPlayerInformation.rpc_id(id, name2)

@rpc("any_peer", "reliable")
func SendPlayerInformation(name):
	game.players[multiplayer.get_remote_sender_id()] = name

	print("" + str(multiplayer.get_remote_sender_id()) + " called " + str(myId) + "to add " +  name)
	var scene = load("res://scenes/player.tscn")
	var instance = scene.instantiate()
	if game.players.size() > 1:
		instance.position.x = 150
		instance.position.y = 50
	else:
		instance.position.x = 100
		instance.position.y = 50
	get_node("/root/Main").add_child(instance)

var characters = 'abcdefghijklmnopqrstuvwxyz'

func generate_word(chars, length):
	var word: String
	var n_char = len(chars)
	for i in range(length):
		word += chars[randi()% n_char]
	return word
