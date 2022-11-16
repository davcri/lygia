#include "map.glsl"
#include "../../math/saturate.glsl"

/*
original_author:  Inigo Quiles
description: calculare Ambient Occlusion
use: <float> raymarchAO( in <vec3> pos, in <vec3> nor ) 
*/

#ifndef RAYMARCH_SAMPLES_AO
#define RAYMARCH_SAMPLES_AO 5
#endif

#ifndef RAYMARCH_MAP_FNC
#define RAYMARCH_MAP_FNC(POS) raymarchMap(POS)
#endif

#ifndef RAYMARCH_MAP_DISTANCE
#define RAYMARCH_MAP_DISTANCE a
#endif

#ifndef FNC_RAYMARCHAO
#define FNC_RAYMARCHAO

// float raymarchAO( in vec3 pos, in vec3 nor ) {
//     float occ = 0.0;
//     float sca = 1.0;
//     for ( int i = 0; i < RAYMARCH_SAMPLES_AO; i++ ) {
//         float hr = 0.01 + 0.12 * float(i) * 0.25;
//         float dd = RAYMARCH_MAP_FNC( nor * hr + pos ).RAYMARCH_MAP_DISTANCE;
//         occ += -(dd-hr)*sca;
//         sca *= 0.95;
//     }
//     return saturate( 1.0 - 3.0*occ );    
// }

float raymarchAO( in vec3 pos, in vec3 nor ) {
    float occ = 0.0;
    float sca = 1.0;
    for( int i = 0; i < RAYMARCH_SAMPLES_AO; i++ ) {
        float hr = 0.01 + 0.12 * float(i) * 0.2;
        float dd = RAYMARCH_MAP_FNC( hr * nor + pos ).RAYMARCH_MAP_DISTANCE;
        occ += (hr-dd)*sca;
        sca *= 0.9;
        if( occ > 0.35 ) 
            break;
    }
    return saturate( 1.0 - 3.0 * occ ) * (0.5+0.5*nor.y);
}

#endif