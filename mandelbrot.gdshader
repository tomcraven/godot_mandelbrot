shader_type canvas_item;

uniform vec2 position = vec2(-1.0, -0.5);
uniform vec2 re_bounds = vec2(
	-1.25, // 0.5 - 3.5 / 2.0
	2.25 // 0.5 + 3.5 / 2.0
);
uniform vec2 im_bounds = vec2(
	-0.5, // 0.5 - 2.0 / 2.0
	1.5 // 0.5 + 2.0 / 2.0
);

const int detail = 250;

// https://en.wikipedia.org/wiki/Plotting_algorithms_for_the_Mandelbrot_set#Optimized_escape_time_algorithms

void fragment() {
	vec2 scaled_uv = position + vec2(
		re_bounds[0] + (UV.x * (re_bounds[1] - re_bounds[0])),
		im_bounds[0] + (UV.y * (im_bounds[1] - im_bounds[0]))
	);

	float x = 0.0;
	float y = 0.0;
	float x2 = 0.0;
	float y2 = 0.0;

	int iteration = 0;
	while(x2 + y2 < 4.0 && iteration < detail) {
		y = 2.0 * x * y + scaled_uv.y;
		x = x2 - y2 + scaled_uv.x;
		x2 = x * x;
		y2 = y * y;
		iteration += 1;
	}

	float colour = float(iteration) / float(detail);
	COLOR.rgb = vec3(colour, colour, colour);
}
