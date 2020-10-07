extends Particles2D
class_name DamageParticles

func emitDamage(damage : int) -> void:
	amount = damage
	restart()
