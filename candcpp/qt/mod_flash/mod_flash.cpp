#include "mod_flash.h"
#include <vector>
#include "httpd.h"
#include "http_config.h"
#include "http_log.h"
#include "apr_lib.h"
#include "apr_strings.h"
#include "apr_general.h"
#include "util_filter.h"
#include "http_request.h"

static const char flashFilterName[] = "FLASH";
module AP_MODULE_DECLARE_DATA flash_module;

typedef struct flash_filter_config_t{
} flash_filter_config;

void sanitize_ti(){
}

static const command_rec flash_filter_cmds[] = {


static void register_hooks(apr_pool_t* p){
        ap_register_output_filter(flash_filter_name, flash_response_filter, NULL,
                                  AP_FTYPE_RESOURCE);
        ap_register_input_filter(flash_filter_name, flash_request_filter, NULL,
                                 AP_FTYPE_RESOURCE);
}

AP_DECLARE_MODULE(flash) = {
                STANDARD20_MODULE_STUFF,
create_flash_dir_cfg,
NULL,
NULL,
NULL,
flash_filter_cmds,
register_hooks
};

