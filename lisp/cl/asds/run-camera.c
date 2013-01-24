/*	Compiler: ECL 12.2.1                                          */
/*	Date: 2012/6/6 13:54 (yyyy/mm/dd)                             */
/*	Machine: Linux 2.6.32-41-generic i686                         */
/*	Source: /home/sonu/workspace/programming/lisp/cl/asds/run-camera.lisp */
#include <ecl/ecl-cmp.h>
#include "workspace/programming/lisp/cl/asds/run-camera.eclh"
	
#include "workspace/programming/lisp/cl/asds/run-camera.data"
#ifdef __cplusplus
extern "C"
#endif
ECL_DLLEXPORT void init_fas_CODE(cl_object flag)
{ VT1 VLEX1 CLSR1 STCK1
	const cl_env_ptr cl_env_copy = ecl_process_env();
	cl_object value0;
	cl_object *VVtemp;
	if (flag != OBJNULL){
	Cblock=flag;
	#ifndef ECL_DYNAMIC_VV
	flag->cblock.data = VV;
	#endif
	flag->cblock.data_size = VM;
	flag->cblock.temp_data_size = VMtemp;
	flag->cblock.data_text = compiler_data_text;
	flag->cblock.data_text_size = compiler_data_text_size;
	flag->cblock.cfuns_size = compiler_cfuns_size;
	flag->cblock.cfuns = compiler_cfuns;
	flag->cblock.source = make_constant_base_string("/home/sonu/workspace/programming/lisp/cl/asds/run-camera.lisp");
	return;}
	#ifdef ECL_DYNAMIC_VV
	VV = Cblock->cblock.data;
	#endif
	Cblock->cblock.data_text = "@EcLtAg:init_fas_CODE@";
	VVtemp = Cblock->cblock.temp_data;
	ECL_DEFINE_SETF_FUNCTIONS
	ecl_function_dispatch(cl_env_copy,VV[0])(10,VVtemp[0],Cnil,Cnil,VVtemp[1],Cnil,Cnil,Cnil,Cnil,Cnil,Cnil) /*  DODEFPACKAGE */;
	si_select_package(VVtemp[0])              /*  SELECT-PACKAGE  */;
	cl_format(3,Ct,VVtemp[2],VVtemp[3])       /*  FORMAT          */;
}
