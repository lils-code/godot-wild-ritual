class_name entity
extends Node

var mesh : MeshInstance
var targetable : Area
var character : String

func _init(_mesh : MeshInstance, _targetable : Area, _character : String) -> void:
	mesh = _mesh
	targetable = _targetable
	character = _character
