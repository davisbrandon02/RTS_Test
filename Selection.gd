extends Node2D

var selected = Array()

var drag_start : Vector2 # Where the drag started
var drag_end : Vector2 # Where the drag ends
var dragging : bool # Are we currently dragging?
var select_rect = RectangleShape2D.new()

var selectColor = Color("4d1fbaa8")

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			select_all(false)
			drag_start = event.position
			dragging = true
		else:
			dragging = false
			drag_end = event.position
			select_rect.extents = (drag_end - drag_start) / 2
			cast_select()
			update()
	
	if event is InputEventMouseMotion and dragging:
		update()

func _draw():
	if dragging:
		draw_rect(Rect2(drag_start, get_global_mouse_position() - drag_start), selectColor, true)

func cast_select():
	var space = get_world_2d().direct_space_state
	var query = Physics2DShapeQueryParameters.new()
	query.set_shape(select_rect)
	query.transform = Transform2D(0, (drag_end + drag_start) / 2)
	selected = space.intersect_shape(query)
	print(selected)
	
	select_all(true)


func select_all(value):
	for unit in selected:
		unit.collider.select(value)
