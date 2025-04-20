shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

uniform bool selected = false;
uniform vec4 ring_color = vec4(0.7, 0.4, 1.0, 1.0); // purple
uniform float ring_thickness = 0.08;

void fragment() {
	vec2 uv = (UV - vec2(0.5)) * 2.0;
	float dist = length(uv);
	
	if (dist > 1.0) {
		discard;
	}

	if (selected && dist > 1.0 - ring_thickness) {
		COLOR = ring_color;
	} else {
		COLOR = texture(TEXTURE, UV);
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
