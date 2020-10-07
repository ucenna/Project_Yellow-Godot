extends BaseEntity
class_name Enemy

onready var playerDetectionArea := $PlayerDetectionArea
onready var MeleeAttackRange := $MeleeAttackRange

onready var damageParticles := $DamageParticles

var nearbyPlayer : Player

var timeSinceLastAttack := 0.0

func _ready() -> void:
	playerDetectionArea.connect("body_entered", self, "handleEntityEntered")
	playerDetectionArea.connect("body_exited", self, "handleEntityExited")
	self.connect("took_damage", damageParticles, "emitDamage")
	
func _physics_process(delta) -> void:
	if nearbyPlayer:
		handleMeleeAttack(delta, nearbyPlayer)
		var movementAmount : Vector2 = self.position.direction_to(nearbyPlayer.position)  * speed * delta * 100
		moveTowards(movementAmount)

func handleEntityEntered(player : Player) -> void:
	if player:
		nearbyPlayer = player
	
func handleEntityExited(player : Player) -> void:
	if player:
		nearbyPlayer = null

func handleMeleeAttack(delta : float, target : BaseEntity) -> void:
	if timeSinceLastAttack <= 0:
		if self.position.distance_to(target.position) < 50:
			attack()
			timeSinceLastAttack = 2.0
	else:
		timeSinceLastAttack -= delta

func attack() -> void:
	for entity in playerDetectionArea.get_overlapping_bodies():
		var target := entity as BaseEntity
		if target && target != self:
			target.takeDamage(10)
