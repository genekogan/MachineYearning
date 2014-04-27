#define PROCESSING_COLOR_SHADER

#ifdef GL_ES
precision mediump float;
#endif

uniform float time;
uniform vec2 resolution;

uniform float mult;
uniform float phase;
uniform float rad;
uniform float give;
uniform float r, g, b;

uniform float threshLen;
uniform float threshSpeed;

void main( void ) {
	vec2 p = -1.0 + 2.0 * (gl_FragCoord.xy / resolution.xy);

//	float ang = 0.5 * (atan(p.x / abs(p.y)) + atan(p.y/abs(p.x))) / 1.57;
	float ang = atan(p.x / abs(p.y));
	ang = mod(ang + threshSpeed*time, 1.57);
	float thresh = step(ang, threshLen);
	
	float d1 = max(abs(p.x), abs(p.y));
	d1 = mod(mult * d1 + phase, 1.0);
	float d2 = abs(rad - d1);	
	float d3 = smoothstep(give, 0.0, d2);
	gl_FragColor = vec4(d3 * thresh * vec3(r, g, b), 1.0 );
	
}
