/*
 * =====================================================================================
 *
 *       Filename:  mod_example.cpp
 *
 *    Description:  A sample apache module in C++ for practice.
 *
 *        Version:  1.0
 *        Created:  Sunday 26 August 2012 04:07:59  IST
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  YOUR NAME (), 
 *        Company:  
 *
 * =====================================================================================
 */

#include <string>

#include "httpd.h"
#include "http_config.h"
#include "http_core.h"
#include "http_log.h"
#include "apr_general.h"
#include "apr_strings.h"
#include "apr_strmatch.h"
#include "apr_lib.h"
#include "util_filter.h"
#include "util_varbuf.h"
#include "apr_buckets.h"
#include "http_request.h"
#define APR_WANT_STRFUNC
#include "apr_want.h"


using namespace std;

string example_filter_name = "EXAMPLE";
module AP_MODULE_DECLARE_DATA example_module;

typedef struct{
} example_module_ctx;

static do_something(ap_filter_t* f, apr_bucket* inb, apr_bucket_brigade* mybb, apr_pool_t* pool){
}



int main(){
        s.a
}
