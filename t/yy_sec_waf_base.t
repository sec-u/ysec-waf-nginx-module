#vi:filetype=perl

use lib 'lib';
use Test::Nginx::Socket;

repeat_each(3);

plan tests => repeat_each() * (blocks() + 1);
no_root_location();
no_long_string();
$ENV{TEST_NGINX_SERVROOT} = server_root();
run_tests();

__DATA__
=== TEST 1: Basic GET request
--- config
default_type text/html;
location / {
    basic_rule <;
    root $TEST_NGINX_SERVROOT/html/;
    index index.html index.htm;
}
--- request
GET /
--- error_code: 200

=== TEST 2: DENY: Short Char Rule
--- config
default_type text/html;
location / {
    basic_rule <;
    root $TEST_NGINX_SERVROOT/html/;
    index index.html index.htm;
}
--- request
GET /?a="<script>alert(1)</script>"
--- error_code: 403