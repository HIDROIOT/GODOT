shader_type spatial;

uniform vec2 flow_speed = vec2(0.0, -1); // Velocidad del flujo hacia abajo
uniform sampler2D noise_texture;          // Textura de ruido
uniform vec3 water_color = vec3(0.3, 0.5, 0.8); // Color del agua
uniform vec3 foam_color = vec3(1.0, 1.0, 1.0);  // Color de la espuma
uniform float foam_threshold = 0.6;       // Umbral para generar espuma
uniform float transparency = 0.5;         // Transparencia del agua

void fragment() {
    vec2 uv = UV;

    // Movimiento hacia abajo y algo de oscilación horizontal
    uv.y += TIME * flow_speed.y;
    uv.x += sin(TIME * 3.0) * 0.02;

    // Obtener valores de ruido para turbulencias
    vec4 noise = texture(noise_texture, uv * 4.0);

    // Generar espuma en las áreas más brillantes del ruido
    float foam = smoothstep(foam_threshold, 1.0, noise.r);

    // Mezclar colores de agua y espuma
    vec3 final_color = mix(water_color, foam_color, foam);

    ALBEDO = final_color;  // Color del material
    ALPHA = transparency;  // Transparencia
}

