shader_type canvas_item;
uniform vec2 tiling = vec2(2.0, 2.0);
uniform vec2 offset = vec2(0.0, 0.0);

void fragment() {
    vec2 uv = fract(UV * tiling + offset * TIME);
    COLOR = texture(TEXTURE, uv);
}