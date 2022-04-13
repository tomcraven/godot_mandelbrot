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
uniform sampler2D palette;

const float max_iteration = 250.0;
const float colour_period = 250.0;

void fragment() {
	vec2 scaled_uv = position + vec2(
		re_bounds[0] + (UV.x * (re_bounds[1] - re_bounds[0])),
		im_bounds[0] + (UV.y * (im_bounds[1] - im_bounds[0]))
	);

	// https://en.wikipedia.org/wiki/Plotting_algorithms_for_the_Mandelbrot_set#Optimized_escape_time_algorithms
	float x = 0.0;
	float y = 0.0;
	float x2 = 0.0;
	float y2 = 0.0;

	float iteration = 0.0;
	while(x2 + y2 < 18.0 && iteration < max_iteration) {
		y = 2.0 * x * y + scaled_uv.y;
		x = x2 - y2 + scaled_uv.x;
		x2 = x * x;
		y2 = y * y;
		iteration += 1.0;
	}

	// https://en.wikipedia.org/wiki/Plotting_algorithms_for_the_Mandelbrot_set#Continuous_(smooth)_coloring
	// http://linas.org/art-gallery/escape/escape.html
	if (iteration < max_iteration) {
		//float log_2 = log(2.0);
		//float log_zn = log(x2 + y2) / 2.0;
		//float nu = log(log_zn / log_2) / log_2;
		//iteration = iteration + 1.0 - nu;

		//vec2 colour_offset_1 = vec2(mod(floor(iteration + 0.0), colour_period) / colour_period);
		//vec2 colour_offset_2 = vec2(mod(floor(iteration + 1.0), colour_period) / colour_period);

		//vec4 colour_1 = texture(palette, colour_offset_1);
		//vec4 colour_2 = texture(palette, colour_offset_2);
		//COLOR = mix(colour_1, colour_2, fract(iteration));
		
		float n = (float(iteration) + 1. - log(log(length(vec2(x,y))))/log(2.));
		
		COLOR = vec4((-cos(0.025*n)+1.0)/2.0,
                          (-cos(0.08*n)+1.0)/2.0,
                          (-cos(0.12*n)+1.0)/2.0,
                          1.0);
	} else {
		COLOR = vec4(0.0, 0.0, 0.0, 1.0);
	}
}
