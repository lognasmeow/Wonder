shader_type canvas_item;

uniform float circle_size : hint_range(0.0, 0.9) = 1.0;
uniform float screen_aspect : hint_range(0.1, 10.0) = 1.3;

void fragment() {
    vec2 center = vec2(0.5, 0.5);
    vec2 uv = UV - center;
	
    uv.x *= screen_aspect;
    float dist = length(uv);
	float alpha = step(circle_size, dist);
    COLOR = vec4(0.0, 0.0, 0.0, alpha);
}
