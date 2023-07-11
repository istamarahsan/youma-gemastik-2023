@tool
extends TextureButton

@export_multiline var text: String:
	set(value):
		var label = get_node_or_null("Label")
		if label != null:
			label.text = value
	get:
		var label = get_node_or_null("Label")
		return label.text if label != null else ""
