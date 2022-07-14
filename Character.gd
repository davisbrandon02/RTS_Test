extends KinematicBody2D

var selected : bool


func _process(delta):
	pass


func select(value):
	selected = value
	$Selected.visible = value
