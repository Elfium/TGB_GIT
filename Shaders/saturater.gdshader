shader_type canvas_item;

uniform float saturation;
uniform float brightness : hint_range(0.0, 2.0) = 1.0; // Диапазон яркости от 0 до 2, по умолчанию 1

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);

    // Применяем насыщенность
    vec3 saturated_color = mix(vec3(dot(tex_color.rgb, vec3(0.299, 0.587, 0.114))), tex_color.rgb, saturation);

    // Применяем яркость
    vec3 final_color = saturated_color * brightness;

    COLOR.rgb = final_color;
    COLOR.a = tex_color.a;
}