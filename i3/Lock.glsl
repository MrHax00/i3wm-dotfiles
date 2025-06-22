#version 330
in vec2 texcoord;	// texture coordinate of the fragment

uniform sampler2D tex;	// texture of the window

// Default window post-processing:
// 1) invert color
// 2) opacity / transparency
// 3) max-brightness clamping
// 4) rounded corners
vec4 default_post_processing(vec4 c);

// from https://www.shadertoy.com/view/XfjXWw
vec3 rgb_to_hsv(vec3 rgb) {
    float cmax = max(rgb.r,max(rgb.g,rgb.b));
    float cmin = min(rgb.r,min(rgb.g,rgb.b));
    float delta = cmax-cmin;
    
    float h = 0.;
    if (delta == 0.) {
        h = 0.;
    } else if (cmax==rgb.r) {
        h=60.*mod((rgb.g-rgb.b)/delta,6.);
    } else if (cmax==rgb.g) {
        h=60.*((rgb.b-rgb.r)/delta+2.);
    } else if (cmax==rgb.b) {
        h=60.*((rgb.r-rgb.g)/delta+4.);
    }
    
    float s = 0.;
    if (cmax != 0.) s = delta/cmax;
    
    float v = cmax;
    
    return vec3(h,s,v);
}

vec3 hsv_to_rgb(vec3 hsv) {
    float C = hsv.z*hsv.y;
    float X = C*(1.-abs(mod(hsv.x/60.,2.)-1.));
    float m = hsv.z-C;
    
    vec3 rgb = vec3(C,X,0.);
    if (hsv.x <= 120. && hsv.x >= 60.) {
        rgb = vec3(X,C,0.);
    } else if (hsv.x <= 180. && hsv.x >= 120.) {
        rgb = vec3(0.,C,X);
    } else if (hsv.x <= 240. && hsv.x >= 180.) {
        rgb = vec3(0.,X,C);
    } else if (hsv.x <= 300. && hsv.x >= 240.) {
        rgb = vec3(X,0.,C);
    } else if (hsv.x <= 360. && hsv.x >= 300.) {
        rgb = vec3(C,0.,X);
    }
    rgb += m;
    
    return rgb;
}

// Default window shader:
// 1) fetch the specified pixel
// 2) apply default post-processing
vec4 window_shader() {
	vec2 texsize = textureSize(tex, 0);
	vec4 c = texture2D(tex, texcoord / texsize, 0);
	
	// interfeere
	vec3 HSV = rgb_to_hsv(c.xyz);
	if (abs(HSV.x - 95.5) < 2) HSV.x = 200; // turn green sections blue
	if (abs(HSV.x - 106) < 2) HSV.x = 180; // turn the bright green sections cyan
	
	c.xyz = hsv_to_rgb(HSV); // apply the new colors
	c.w = smoothstep(.2, .4, HSV.z) * .8; // make the darker colors transparent
	
	return c;//default_post_processing(c);
}
