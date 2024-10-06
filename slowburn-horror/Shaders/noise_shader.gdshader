shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture;
uniform sampler2D noise_texture;
uniform float noise_amount = 0.2;

float random(vec2 uv){
    return fract(cos(uv.x * 83.4827 + uv.y * 92.2842) * 43758.5453123);
}

void fragment(){
    vec2 pos = SCREEN_UV;
    float rand = random(pos + fract(TIME));
    
    float noise = rand * noise_amount;
    
    vec3 colour = texture(SCREEN_TEXTURE, pos).rgb + noise;
    vec2 pos2 = vec2(rand, rand);
    vec3 colour2 = texture(noise_texture, pos2).rgb;
    
    COLOR.rgb = colour - colour2 * noise_amount;
    COLOR.a = 1.0;
}