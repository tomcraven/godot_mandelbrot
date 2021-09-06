shader_type canvas_item;

uniform vec2 position = vec2(0.0, 0.0);
uniform float zoom = 1.0;
uniform int detail = 100;

void fragment() {
	vec2 scaled_uv = position + vec2(
		-2.5 + (UV.x * 3.5),
		-1.0 + (UV.y * 2.0)
	) * zoom;

	float x = 0.0;
	float y = 0.0;
	int iteration = 0;
	while(x * x + y * y < 4.0 && iteration < detail) {
		float x_temp = x * x - y * y + scaled_uv.x;
        y = 2.0 * x * y + scaled_uv.y;
        x = x_temp;
		iteration += 1;
	}
	
	float colour = float(iteration) / float(detail);
	COLOR.rgb = vec3(colour, colour, colour);
}
