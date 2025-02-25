shader_type spatial;

uniform float speed = 5.0;  // Velocidad del cambio de color
uniform float intensity = 1.0; // Intensidad del color
uniform float yellow_strength = 0.3; // Cuánto amarillo se muestra (ajústalo)

void fragment() {
    float wave = sin(UV.y * 15.0 - TIME * speed) * 0.5 + 0.5; // Onda de cambio suave
    vec3 black = vec3(0.0, 0.0, 0.0); // Negro puro
    vec3 yellow = vec3(1.0, 1.0, 0.0); // Amarillo puro

    // Ajusta cómo el amarillo se mezcla con el negro
    float adjusted_wave = pow(wave, 3.0) * yellow_strength;

    vec3 final_color = mix(black, yellow, adjusted_wave); // Mezcla con más negro
    ALBEDO = final_color * intensity; // Aplica la intensidad
}
