/**
 * Created by TonGarcia on 05/05/14.
 */
function get_first_rest_param() {
    url_http_removed = document.URL.split(/\/\//)[1];
    url_domain_removed = url_http_removed.split(/\//)[1];
    first_rest_param = url_domain_removed;
    return first_rest_param;
}

function build_url_idiom() {
    url_http = document.URL.split(/\/\//)[0];
    url_domain = url_http_removed.split(/\//)[0];
    return url_http + '//' + url_domain + '/';
}

function redirecter() {
    index_path = '/publishers';
    current_url = document.URL;
    first_param = get_first_rest_param();

    // Validate if have any parameter (should have at least the idioma on URL, if not, it is putted there)
    if(first_param == '') return current_url += navigator.language.substring(0,2);
    else if(first_param.length != 2) return build_url_idiom() + navigator.language.substring(0,2);
}
