#include "escheme.h"
Scheme_Object* scheme_initialize(Scheme_Env* env){
	return schem_make_utf8_string("hello world");
}

Scheme_Object* scheme_reload(Scheme_Env* env){
	return scheme_initialize(env);
}

Scheme_Object* scheme_module_name(){
	return scheme_false;
}
