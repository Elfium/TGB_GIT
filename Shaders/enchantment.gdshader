shader_type canvas_item;

uniform bool shader_enabled = true;
uniform vec4 enchant_color : source_color = vec4(0.0, 0.5, 1.0, 1.0);
uniform float intensity = 0.5;
uniform float speed = 2.0;
uniform sampler2D texture;
uniform vec2 texture_scale = vec2(1.0, 1.0);
uniform float glow_threshold = 0.8;
uniform float glow_intensity = 1.5;
uniform float rotation_speed = 1.0;

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    float alpha = color.a;

    if (alpha == 0.0) {
        discard;
    }

    if (!shader_enabled) {
        COLOR = color;
    } else {
        float effect = sin(TIME * speed);

        vec2 center_uv = vec2(0.5, 0.7);
        vec2 scaled_uv = (UV - center_uv) * texture_scale + center_uv;

        float rotation = TIME * rotation_speed;
        vec2 rotated_uv;
        rotated_uv.x = cos(rotation) * scaled_uv.x - sin(rotation) * scaled_uv.y;
        rotated_uv.y = sin(rotation) * scaled_uv.x + cos(rotation) * scaled_uv.y;

        rotated_uv = fract(rotated_uv);

        vec2 animated_uv = rotated_uv;
        animated_uv.y += TIME * speed * 0.1;
        animated_uv.y = fract(animated_uv.y);

        vec4 animated_texture_color = texture(texture, animated_uv);
        float brightness = dot(animated_texture_color.rgb, vec3(0.299, 0.587, 0.114));

        float glow = smoothstep(glow_threshold, 1.0, brightness);
        vec4 glow_color = enchant_color * glow * glow_intensity;

        COLOR = color;
        COLOR = mix(COLOR, enchant_color + glow_color, intensity * brightness);
        COLOR.a = alpha;
    }
}