extends CharacterBody2D

@export var player: CharacterBody2D
const speed = 25
var life = 3
var life_animation_weight = {
	4: "",
	3: "",
	2: "_medium",
	1: "_heavy",
	0: "", # Workaround to not get a nullpointer on a dead clown
}
@onready var hit1: AudioStreamPlayer = $AudioHit1
@onready var hit2: AudioStreamPlayer = $AudioHit2
@onready var hit3: AudioStreamPlayer = $AudioHit3
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var explosionSprite: Sprite2D = $ExplosionSprite
@onready var colorRect: ColorRect = $Sprite/ColorRect
var executed_once = true

func _ready():
	explosionSprite.hide()
	colorRect.hide()

func _process(delta):
	if life > 0:
		if velocity.x > 0:
			animationPlayer.play("walk_right" + life_animation_weight[life])
		else:
			animationPlayer.play("walk_left" + life_animation_weight[life])

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	velocity = Vector2(0, 0)
	if life <= 0:
		return

	if player.position.x > position.x:
		velocity += Vector2(1, 0)
	if player.position.x < position.x:
		velocity += Vector2(-1, 0)
	if player.position.y > position.y:
		velocity += Vector2(0, 1)
	if player.position.y < position.y:
		velocity += Vector2(0, -1)

	velocity = velocity * speed

	move_and_collide(velocity * delta)

func hit():
	life -= 1
	if life == 2:
		hit1.play()
	elif life == 1:
		hit2.play()
	if life <= 0:
		if executed_once:
			hit3.play(2.0)
			$AnimationPlayerDying.play("dying_color")
			executed_once = false
			colorRect.show()
			$"..".enemies = $"..".enemies - 1
			player.kills = player.kills + 1
			$"../CanvasLayer/KillsCounter/Kills".text = str(player.kills)
			$CollisionShape2D.disabled = true
			animationPlayer.stop()
			await hit3.finished
			$Sprite.hide()
			explosionSprite.show()
			animationPlayer.play("explosion")
			await animationPlayer.animation_finished
			queue_free()

func _on_hit_box_body_entered(body):
	if body.name == "FlyingFeather":
		hit()
