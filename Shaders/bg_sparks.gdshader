shader_type canvas_item;

uniform vec4 background_color : source_color = vec4(0.0, 0.0, 0.1, 1.0);
uniform int star_count = 50;
uniform float star_size = 2.0;
uniform float fade_duration = 2.0;

// Координаты звезд созвездия (пример: Малая Медведица)
const vec2 constellation_stars[7] = vec2[7](
    vec2(0.2, 0.8),
    vec2(0.3, 0.7),
    vec2(0.45, 0.75),
    vec2(0.6, 0.85),
    vec2(0.7, 0.7),
    vec2(0.8, 0.6),
    vec2(0.9, 0.5)
);

void fragment() {
    COLOR = background_color;

    // Рисуем обычные звезды
    for (int i = 0; i < star_count; i++) {
        vec2 star_position = vec2(
            fract(sin(dot(UV, vec2(12.9898, 78.233) + float(i) * 48.1357)) * 43758.5453),
            fract(cos(dot(UV, vec2(12.9898, 78.233) + float(i) * 48.1357)) * 43758.5453)
        );

        float time_offset = float(i) * 10.0;
        float brightness = 0.5 + 0.5 * sin(TIME * 2.0 + time_offset);
        float fade_factor = smoothstep(0.0, fade_duration, abs(sin(TIME * 2.0 + time_offset)));
        brightness *= fade_factor;

        if (brightness > 0.0) {
            float distance_to_star = distance(UV, star_position);
            if (distance_to_star < star_size / 1000.0) {
                COLOR += vec4(1.0, 1.0, 1.0, brightness);
            }
        }
    }

    // Рисуем созвездие
    for (int i = 0; i < 7; i++) {
        vec2 star_position = constellation_stars[i];
        float brightness = 1.0;
        float distance_to_star = distance(UV, star_position);

        if (distance_to_star < star_size * 1.5 / 1000.0) {
            COLOR += vec4(1.0, 1.0, 1.0, brightness);
        }

        // Рисуем линии, соединяющие звезды созвездия
        if (i < 6) {
            vec2 next_star_position = constellation_stars[i + 1];
            vec2 line_direction = normalize(next_star_position - star_position);
            float line_length = distance(star_position, next_star_position);

            for (float j = 0.0; j < line_length; j += 0.001) {
                vec2 line_point = star_position + line_direction * j;
                float distance_to_line = distance(UV, line_point);

                if (distance_to_line < 0.002) {
                    COLOR += vec4(1.0, 1.0, 0.0, 1.0);
                }
            }
        }
    }
}