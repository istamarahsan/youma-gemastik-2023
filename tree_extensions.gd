extends Node

func get_tree_rec(root: Node) -> Array[Node]:
	var nodes: Array[Node] = [root]
	for child in root.get_children():
		nodes.append_array(get_tree_rec(child))
	return nodes
