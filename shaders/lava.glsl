
const int steps = 90;
float smallNumber = 0.001;


float scene(vec3 pos){
    
    float ground = pos.y + 0.50
                    + sin(pos.x * 10.)/10.
                    + sin( (5.0+bands.z/1000.) *time + pos.z * 10.)/10.;
                    
    
    // sphere
    //pos = vec3(pos.x + sin(time*2.), pos.yz);
    float sphere = length(pos) -  kale(vec2(pos.x, pos.y), 0.7) * 2. * bands.z;
    // sphere +=);
    
    float v = voronoi(pos.xy*vec2(sin(time/5.)));
    ground += v*1.;
    return min(ground, sphere);
   

}

vec4 trace(vec3 rayOrigin, vec3 dir) {
    vec3 ray = rayOrigin;
    float dist = 0.;
    float totalDist = 0.;
    
    for (int i=0; i < steps; i++) {
        dist = scene(ray);
        ray = ray + (dist * dir);
        totalDist += dist;
        if (dist < smallNumber) {
            // return totalDist/maxDist;
            return vec4(maxDist - totalDist/maxDist, bands.y, bands.x, 0.);
        }
    }
    
    return vec4(0.);
}


void main() {
    
    vec2 uv = uv();
    gl_FragCoord.x;

    // z goes away from camera
    vec3 camOrigin = vec3(0,-0.3,-1.);
	vec3 rayOrigin = vec3(uv + camOrigin.xy, camOrigin.z+1.);

    vec3 dir = rayOrigin + camOrigin;
    
    // vec4 color = vec4(trace(rayOrigin, dir));
    vec4 color = trace(rayOrigin, dir);
    
    //= vec4 color = vec4(scene(rayOrigin));
    
vec3 dir = rayOrigin - 
    vec4 color = vec4(trace(rayOrigin,dir));
    
    vec3 test = hsv2rgb(vec3(color.r + time, 1.0, step(0.1, color.r)));
    
    gl_FragColor = vec4(test, 1);
    
}
