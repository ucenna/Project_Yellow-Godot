extends BaseEntity
class_name Player

onready var damageParticles := $DamageParticles

func _ready() -> void:
	self.connect("took_damage", damageParticles, "emitDamage")

func _physics_process(delta) -> void:
	var movementAmount : Vector2 = getVelocityFromInput() * speed * delta * 100; 
	moveTowards(movementAmount)

func getVelocityFromInput() -> Vector2:
	var velocity : Vector2
	velocity.x = 0;
	velocity.y = 0;
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	velocity.normalized()
	return velocity
