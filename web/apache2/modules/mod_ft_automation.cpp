#include "apr.h"
#include "apr_strings.h"
#include "apr_buckets.h"
#include "apr_lib.h"
#include "ap_config.h"
#include "util_filter.h"
#include "httpd.h"
#include "http_config.h"
#include "http_log.h"
#include "http_request.h"

module AP_MODULE_DECLARE_DATA ft_automation_module;

typedef struct ft_automation_conf{
} ft_automation_conf;

typedef struct ft_automation_ctx{
} ft_automation_ctx;

/**
 * ft_automation buckets being written to the output filter stack.
 */
static apr_status_t ft_automation_out_filter(ap_filter_t *f, apr_bucket_brigade
*bb){
  apr_bucket *e;
  request_rec *r = f->r;
  buffer_ctx *ctx = f->ctx;
  apr_status_t rv = APR_SUCCESS;
  int move = 0;

  /** Filters are gregistered this way:
   **/
  //  ap_register_output_filter("my-output-filter-name",
  //                                   my_output_filter, NULL,
  //  AP_FTYPE_RESOURCE);
  //  ap_register_input_filter("my-input-filter-name", my_input_filter, NULL,
  //  AP_FTYPE_RESOURCE);



  
