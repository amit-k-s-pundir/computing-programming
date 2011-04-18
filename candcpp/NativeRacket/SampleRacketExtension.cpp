 #include "escheme.h"
 
 Scheme_Object *scheme_initialize(Scheme_Env *env) {
   
   return scheme_make_utf8_string("hello world");
   
 }
 
 Scheme_Object *scheme_reload(Scheme_Env *env) {
   
   return scheme_initialize(env); /* Nothing special for reload */
   
 }
 
 Scheme_Object *scheme_module_name() {
   
   return scheme_false;
   
 }