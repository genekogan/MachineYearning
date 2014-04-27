#define PROCESSING_COLOR_SHADER

#ifdef GL_ES
precision mediump float;
#endif

uniform float time;
uniform vec2 resolution;

uniform float r1, r2, t1, t2;
uniform float bright;
uniform float mode1, mode2, mode3;


#define PI 0.01

void main( void ) {

	vec2 p = ( gl_FragCoord.xy / resolution.xy ) - 0.5;
	
	float x = mix(p.x, p.y, mode1);
	float y = mix(p.x, p.y, 1.0-mode1);
	float z = mix(p.x, p.y, mode2);
	float w = mix(p.x, p.y, mode3);
	
	float sx = 0.3*sin( r1 * x - t1 * time);
	sx = sx * cos( r2 * x + t2 * time);
	
	float dy = bright / ( 50. * abs(z - sx));
	
	float d = 1.0-smoothstep(0.5 - max(abs(p.x), abs(p.y)), 0.0, 0.008);
	
	vec3 col2 = vec3((w + 0.9) * dy, 1.9 * dy, 1.3*dy-1.35);
	vec3 col = vec3(max(col2.r, d), max(col2.g, d), max(col2.b, 0.0));
	gl_FragColor = vec4( col, 1.0 );

}