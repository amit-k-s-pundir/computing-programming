#include "TestApache.h"
#include "apr_strings.h"
#include "ap_config.h"
#include "ap_provider.h"
#include "httpd.h"
#include "http_config.h"
#include "http_core.h"
#include "http_log.h"
#include "http_protocol.h"
#include "http_request.h"


TestApache::TestApache()
{
}

module AP_MODULE_DECLARE_DATA TestApache = {
        STANDARD20_MODULE_STUFF,
        create_dir_conf,
        merge_dir_conf,
        creat_server_conf,
        directives,
        register_hooks
};

module AP_MODULE_DECLARE_DATA test_apache_module;
