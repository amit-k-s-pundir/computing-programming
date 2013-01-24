#include <iostream>

#include <ngx_config.h>
#include <ngx_core.h>
#include <ngx_http.h>
#include <ngx_crypt.h>

// Local context for this module.
typedef struct{
} ngx_ft_automation_ctx_t;

// Local config for this module.
typedef struct{
} ngx_ft_automation_loc_conf_t;

// Output filter.
static apr_status_t ft_out_filter(ap_filter_t *f,
                                  apr_bucket_brigade *bb){
}

// Input filter.
static apr_status_t ft_in_filter(ap_filter_t *f, apr_bucket_brigade *bb,
                                 ap_input_mode_t mode, apr_read_type_e block,
                                 apr_off_t readbytes){
  apr_bucket* bkt;
  request_rec* r = f->r;
  ft_ctxt* ctxt = f->ctx;
  apr_status_t rv;
  ft_in_filter_config* c;

  if(mode != AP_MODE_READBYTES){
    return ap_get_brigade(f->next, bb, mode, block, readbytes);
  }

  c = ap_get_module_config(r->server->module_config, &ft_module);
  
  if(!ctx){
    /** Only work on main requests - no subrequests **/
    if(!ap_is_initial_req(r)){
      ap_remove_input_filter(f);
      return ap_get_brigade(f->next, bb, mode, block, readbytes);
    }
  }
  
  /** Ther referer value appropriate for Google **/
  const char* refererValue = "Google Referer Value Goes Here!";
  apr_table_set(hdrs, "Referer", refererValue);
}    
static ngx_int_t ngx_ft_automation_handler(ngx_http_req_t* r);
