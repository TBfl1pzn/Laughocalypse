extends Node


const PORT = 28960
#const ADDRESS = "49.13.33.38"
const ADDRESS = "127.0.0.1"
const MAX_CONNECTIONS = 100
var game = {
	"players": {}
}

var playerNodes = {}
var featherNodes = {}
var myId = ""


var characters = 'abcdefghijklmnopqrstuvwxyz'
var playerName = generate_word(characters, 5)

func _ready():
	if DisplayServer.get_name() == "headless":
		# Runs on the server
		var peer = ENetMultiplayerPeer.new()
		peer.set_bind_ip(ADDRESS)
		var error = peer.create_server(PORT, MAX_CONNECTIONS)
		multiplayer.set_multiplayer_peer(peer)
		print("started the server on port " + str(PORT))
		multiplayer.peer_connected.connect(_on_peer_connected)
	else:
		# Runs on the client
		var peer = ENetMultiplayerPeer.new()
		var error = peer.create_client(ADDRESS, PORT)
		multiplayer.set_multiplayer_peer(peer)
		multiplayer.connected_to_server.connect(_on_connected_to_server)
		myId = str(multiplayer.get_unique_id())

# get called only on client
func _on_connected_to_server():
	RegisterPlayer.rpc_id(1, playerName)

# get called on server but not needed as we trigger from client the connect
func _on_peer_connected(id):
	pass
	
# get called from client on server
@rpc("any_peer", "reliable")
func SharePlayerPosition(position, clientId):
	playerNodes[clientId].position = position

@rpc("any_peer", "reliable")
func ShareFeatherPosition(direction, rotation, position, clientId):
	#instance.clientId = multiplayer.get_remote_sender_id()
	var feather_scene = preload("res://scenes/flying_feather.tscn")
	var feather_instance = feather_scene.instantiate()
	feather_instance.position = position
	feather_instance.rotation = rotation
	feather_instance.direction = direction
	get_node("/root/Main/World").add_child(feather_instance, true)
	featherNodes[clientId] = feather_instance
	#featherNodes[clientId].position = instance.position
	

# get called from client on server
@rpc("any_peer", "reliable")
func RegisterPlayer(name):
	print("add "+name + " as " + str(multiplayer.get_remote_sender_id()))	
	game.players[multiplayer.get_remote_sender_id()] = name

	var scene = load("res://scenes/player.tscn")
	var instance = scene.instantiate()
	instance.test(name)
	instance.clientId = multiplayer.get_remote_sender_id()
	get_node("/root/Main/World").add_child(instance, true)
	playerNodes[instance.clientId] = instance

	if game.players.size() > 1:
		instance.position.x = 100
		instance.position.y = 100
	else:
		instance.position.x = 50
		instance.position.y = 50

	RegisterPlayerOnClient.rpc(game)

# get called from server on client
@rpc("authority")
func RegisterPlayerOnClient(gameFromServer):
	print("update " + str(multiplayer.get_unique_id()))	
	game = gameFromServer
	

	
@rpc("authority")
func SendPlayerInformation(name):
	game.players[multiplayer.get_remote_sender_id()] = name

	#print("" + str(multiplayer.get_remote_sender_id()) + " called " + str(myId) + "to add " +  name)
	var scene = load("res://scenes/player.tscn")
	var instance = scene.instantiate()
	if game.players.size() > 1:
		instance.position.x = 150
		instance.position.y = 50
	else:
		instance.position.x = 100
		instance.position.y = 50
	get_node("/root/Main").add_child(instance)

func generate_word(chars, length):
	var word: String
	var n_char = len(chars)
	for i in range(length):
		word += chars[randi()% n_char]
	return word
