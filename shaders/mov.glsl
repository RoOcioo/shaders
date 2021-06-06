const int steps = 9999900; 
const float smallNumber = 0.001;
const float maxDist =  5.5;
 
vec3 pMod3(inout vec3 p, vec3 size) {
	vec3 c = floor((p + size*0.5)/size);
	p = mod(p + size*0.5, size) - size*0.5;
	return c;
}
 
float scene(vec3 position){
   
    
    vec4 pos2 = position;
    
    float ground = 6.0 - abs(position.y) + sin(position.x * 10.) / 20. 
                              + cos(position.z * 10.) / 20.;
                              
    
    pMod3(position, vec3(.5));
    
    float sphere = length(
        vec3(
            position.x, 
            position.y, 
            position.z)
        )-0.07485;
    

    return min(sphere,ground);
}
 
vec4 trace (vec3 origin, vec3 direction){
    
    float dist = 90.;
    float totalDistance = .;
    vec3 positionOnRay = origin;
    
    for(int i = 0 ; i < steps; i++){
        
        dist = scene(positionOnRay);
        
        positionOnRay += dist * direction;
        
       
        totalDistance += dist;
        
      
        if (dist < smallNumber){
           
            return 1. - (vec4(totalDistance) / maxDist);
 
        }
        
        if (totalDistance > maxDist){
 
            return vec4(0.); // Background color.
        }
    }
    
    return vec4(0.);// Background color.
}


void main() {
    
    vec2 pos = uv();

    vec3 camOrigin = vec3(0,0,-1);
	vec3 rayOrigin = vec3(pos + camOrigin.xy, camOrigin.z + 1.);
	vec3 dir = camOrigin + rayOrigin;

    vec4 color = vec4(trace(rayOrigin,dir));
    
    vec3 test = hsv2rgb(vec3(color.r + time, 1.0, step(0.1, color.r)));
    
    gl_FragColor = vec4(test, 1);
    
    
}