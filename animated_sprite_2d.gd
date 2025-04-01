extends AnimatedSprite2D
func _ready():
	await get_tree().create_timer(0.1).timeout
	print(self.sprite_frames.get_animation_names())
	self.play("default")
