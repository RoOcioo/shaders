const int steps =90;
float epsilon = 0.001;
float maxDist = 1.;

vec3 pMod3(inout vec3 p, vec3 size) {
    vec3 c = floor((p + size*0.5)/size);
    p = mod(p + size*0.5,size) - size*0.5;
    return c;
}

float scene(vec3 pos) {
    
    float ground = pos.y + 1.
                         + sin(time + pos.x) * .9
                         + sin(time + pos.x) * .22
                         + cos(time + pos.z * 3.);
                         + cos(time + pos.z * 300.);
                         
               
    // ground = smoothstep(.1, .2, ground);
    pos = vec3(pos.x + sin(time * 8.), 
              pos.y + cos(time),
              pos.z + (sin(time) + 1.) * 0.92);
    
    //pMod3(pos, vec3(.8));
    float sphere = length(pos) - .3;
    
    return min(ground, sphere);
    return smoothstep(ground, sphere, pos.x);
}

float march(vec3 rayOrigin, vec3 dir) {
    vec3 ray = rayOrigin;
    float dist = 0.;
    float totalDist = 0.;
    
    for (int i = 0; i < steps; i++) {
        dist = scene(ray);
        ray = ray + (dist * dir);
        totalDist += dist;
        if (dist < epsilon) {
            return maxDist - totalDist / maxDist;
        }
    }
    return 0.;
}

void main () {
    vec2 uv = uv();
    
    vec3 camOrigin = vec3(5.,0.,-3.);
    vec3 rayOrigin = vec3(uv + camOrigin.xy, camOrigin.z + 1.);
    
    vec3 dir = rayOrigin - camOrigin;
    
    vec3 color = vec3(march(rayOrigin, dir), .7, 2.);
    
	gl_FragColor = vec4(color, 1.0);
}