extends KinematicBody2D
class_name BaseEntity

signal died
signal took_damage

export(int) var speed := 100
export(int) var hp := 100
	
func moveTowards(movementAmount : Vector2) -> void:
	move_and_slide(movementAmount)
	setFacing(movementAmount)
	
func setFacing(vect : Vector2) -> void:
	if vect.x != 0 || vect.y != 0:
		self.rotation = lerp_angle(self.rotation, vect.angle() + deg2rad(90), vect.length() / 500);

func takeDamage(incomingDamage : int) -> void:
	hp -= incomingDamage
	emit_signal("took_damage", incomingDamage)
	if hp <= 0:
		die()

func die() -> void:
	emit_signal("died")
	queue_free() #delete this node
