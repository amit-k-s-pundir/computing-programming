/* 
**  mod_testFilter.c -- Apache sample testFilter module
**  [Autogenerated via ``apxs -n testFilter -g'']
**
**  To play with this sample module first compile it into a
**  DSO file and install it into Apache's modules directory 
**  by running:
**
**    $ apxs -c -i mod_testFilter.c
**
**  Then activate it in Apache's httpd.conf file for instance
**  for the URL /testFilter in as follows:
**
**    #   httpd.conf
**    LoadModule testFilter_module modules/mod_testFilter.so
**    <Location /testFilter>
**    SetHandler testFilter
**    </Location>
**
**  Then after restarting Apache via
**
**    $ apachectl restart
**
**  you immediately can request the URL /testFilter and watch for the
**  output of this module. This can be achieved for instance via:
**
**    $ lynx -mime_header http://localhost/testFilter 
**
**  The output should be similar to the following one:
**
**    HTTP/1.1 200 OK
**    Date: Tue, 31 Mar 1998 14:42:22 GMT
**    Server: Apache/1.3.4 (Unix)
**    Connection: close
**    Content-Type: text/html
**  
**    The sample page from mod_testFilter.c
*/ 

#include "httpd.h"
#include "http_config.h"
#include "http_protocol.h"
#include "ap_config.h"

module AP_MODULE_DECLARE_DATA testFilter_module;

static const char* const testFilterName = "testFilter";

typedef struct testFilterConf{
} testFilterConf;

typedef struct testFilterCtx{
} testFilterCtx;

static apr_status_t testFilter(ap_filter_t* f, apr_bucket_brigade* bb,
                               ap_input_mode_t mode, apr_read_type_e
                               block, apr_off_t readbytes){
  apr_bucket* e;
  request_rec* r = f->r;
  testFilterCtx* ctx = f->ctx;
  apr_status_t rv = APR_SUCCESS;
}

static int testFilterInit(conn_rec* c){
}

/* The sample content handler */
static int testFilter_handler(request_rec *r)
{
    if (strcmp(r->handler, "testFilter")) {
        return DECLINED;
    }
    r->content_type = "text/html";      

    if (!r->header_only)
        ap_rputs("The sample page from mod_testFilter.c\n", r);
    return OK;
}

static void testFilter_register_hooks(apr_pool_t *p)
{
    ap_hook_handler(testFilter_handler, NULL, NULL, APR_HOOK_MIDDLE);
}

/* Dispatch list for API hooks */
module AP_MODULE_DECLARE_DATA testFilter_module = {
    STANDARD20_MODULE_STUFF, 
    NULL,                  /* create per-dir    config structures */
    NULL,                  /* merge  per-dir    config structures */
    NULL,                  /* create per-server config structures */
    NULL,                  /* merge  per-server config structures */
    NULL,                  /* table of config file commands       */
    testFilter_register_hooks  /* register hooks                      */
};
