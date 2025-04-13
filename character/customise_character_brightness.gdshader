shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	float brightness = UV.x; // 0.0 = left (black), 1.0 = right (white)
    COLOR = vec4(vec3(brightness), 1.0); // grayscale
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
