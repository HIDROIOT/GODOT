shader_type spatial;

uniform float speed = 5.0;  // Velocidad del cambio de color
uniform float intensity = 1.0; // Intensidad del color
uniform float yellow_strength = 0.3; // Cuánto amarillo se muestra (ajústalo)

void fragment() {
    float wave = sin(UV.y * 15.0 - TIME * speed) * 0.5 + 0.5; // Onda de cambio suave
    vec3 red = vec3(1.0, 0.0, 0.0); // Rojo puro
    vec3 yellow = vec3(1.0, 1.0, 0.0); // Amarillo puro

    // Hace que el rojo se vea más tiempo que el amarillo
    float adjusted_wave = pow(wave, 3.0) * yellow_strength;  

    vec3 final_color = mix(red, yellow, adjusted_wave); // Mezcla con más rojo
    ALBEDO = final_color * intensity; // Aplica la intensidad
}
