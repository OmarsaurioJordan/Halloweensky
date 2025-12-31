// Initialise the global array that allows the lookup of the depth of a given object
// GM2.0 does not have a depth on objects so on import from 1.x a global array is created
// NOTE: MacroExpansion is used to insert the array initialisation at import time
gml_pragma( "global", "__global_object_depths()");

// insert the generated arrays here
global.__objectDepths[0] = 0; // o_control
global.__objectDepths[1] = 0; // o_humano
global.__objectDepths[2] = 0; // o_monstruo
global.__objectDepths[3] = 0; // o_animal
global.__objectDepths[4] = 0; // o_astral
global.__objectDepths[5] = 0; // o_arbol
global.__objectDepths[6] = 0; // o_mobiliario
global.__objectDepths[7] = 0; // o_decorado
global.__objectDepths[8] = 0; // o_casa
global.__objectDepths[9] = 0; // o_bloque
global.__objectDepths[10] = 0; // o_movil
global.__objectDepths[11] = 0; // o_ente
global.__objectDepths[12] = 0; // o_visible
global.__objectDepths[13] = 0; // o_mouse
global.__objectDepths[14] = 0; // o_recurso
global.__objectDepths[15] = 0; // o_luz
global.__objectDepths[16] = 0; // o_proyectil


global.__objectNames[0] = "o_control";
global.__objectNames[1] = "o_humano";
global.__objectNames[2] = "o_monstruo";
global.__objectNames[3] = "o_animal";
global.__objectNames[4] = "o_astral";
global.__objectNames[5] = "o_arbol";
global.__objectNames[6] = "o_mobiliario";
global.__objectNames[7] = "o_decorado";
global.__objectNames[8] = "o_casa";
global.__objectNames[9] = "o_bloque";
global.__objectNames[10] = "o_movil";
global.__objectNames[11] = "o_ente";
global.__objectNames[12] = "o_visible";
global.__objectNames[13] = "o_mouse";
global.__objectNames[14] = "o_recurso";
global.__objectNames[15] = "o_luz";
global.__objectNames[16] = "o_proyectil";


// create another array that has the correct entries
var len = array_length_1d(global.__objectDepths);
global.__objectID2Depth = [];
for( var i=0; i<len; ++i ) {
	var objID = asset_get_index( global.__objectNames[i] );
	if (objID >= 0) {
		global.__objectID2Depth[ objID ] = global.__objectDepths[i];
	} // end if
} // end for