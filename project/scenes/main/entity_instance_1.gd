extends Spatial

export(NodePath) var mesh : NodePath
export(NodePath) var targetable : NodePath
export(String) var character : String

var entity : Script = preload("res://scenes/main/entity.gd")

var e

func _ready():
	e = entity.new(get_node(mesh), get_node(targetable), character)
