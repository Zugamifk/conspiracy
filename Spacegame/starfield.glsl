uniform vec2 camera;

float PHI = 1.61803398874989484820459 * 00000.1; // Golden Ratio
float PI  = 3.14159265358979323846264 * 00000.1; // PI
float SRT = 1.41421356237309504880169 * 10000.0; // Square Root of Two

float gold_noise(in vec2 coordinate, in float seed)
{
    return fract(sin(dot(coordinate*seed, vec2(PHI, PI)))*SRT);
}

float star(in float sd)
{
    float g = sd;
    g = pow(g,20);
    return step(0.99,g);
}

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    float stars = 0;
    float scale = 1;
    float rnd = 0;
    float seed = PHI;
    vec2 pos = floor(camera);
    float st = 1./50.;
    for(int i=0;i<25;i++)
    {
        scale -= st;
        pos = floor(pos*scale);
        rnd = gold_noise(pos+screen_coords, seed);
        stars += star(rnd);
        seed+=PHI;
    }
    vec4 texcolor = Texel(texture, texture_coords);
    return texcolor * color * stars;
}
