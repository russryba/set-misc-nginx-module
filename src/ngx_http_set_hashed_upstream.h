#include <ngx_core.h>
#include <ngx_config.h>
#include <ngx_http.h>
#include <ndk.h>

#ifndef _NGX_HTTP_HASHED_UPSTREAM
#define _NGX_HTTP_HASHED_UPSTREAM


typedef enum {
    ngx_http_set_misc_distribution_modula,
    ngx_http_set_misc_distribution_random /* XXX not used */
} ngx_http_set_misc_distribution_t;

ndk_upstream_list_t *
ngx_http_set_misc_get_upstream_list(u_char *data, size_t len);

ngx_uint_t ngx_http_set_misc_apply_distribution(ngx_log_t *log, ngx_uint_t hash,
        ndk_upstream_list_t *ul, ngx_http_set_misc_distribution_t type);

char * ngx_http_set_hashed_upstream(ngx_conf_t *cf,
        ngx_command_t *cmd, void *conf);

ngx_int_t ngx_http_set_misc_set_hashed_upstream(ngx_http_request_t *r,
        ngx_str_t *res, ngx_http_variable_value_t *v, void *data);


#endif
