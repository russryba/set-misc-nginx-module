# vi:filetype=perl

use lib 'lib';
use Test::Nginx::Socket;

#repeat_each(3);

plan tests => repeat_each() * 2 * blocks();

no_long_string();

run_tests();

#no_diff();

__DATA__

=== TEST 1: base32 (5 bytes)
--- config
    location /bar {
        set $a 'abcde';
        set_encode_base32 $a;
        set $b $a;
        set_decode_base32 $b;

        echo $a;
        echo $b;
    }
--- request
    GET /bar
--- response_body
c5h66p35
abcde



=== TEST 2: base32 (1 byte)
--- config
    location /bar {
        set $a '!';
        set_encode_base32 $a;
        set $b $a;
        set_decode_base32 $b;

        echo $a;
        echo $b;
    }
--- request
    GET /bar
--- response_body
44======
!



=== TEST 3: base32 (1 byte) - not in-place editing
--- config
    location /bar {
        set $a '!';
        set_encode_base32 $a $a;
        set_decode_base32 $b $a;

        echo $a;
        echo $b;
    }
--- request
    GET /bar
--- response_body
44======
!



=== TEST 4: base32 (hello world)
--- config
    location /bar {
        set $a '"hello, world!\nhiya"';
        set_encode_base32 $a;
        set $b $a;
        set_decode_base32 $b;

        echo $a;
        echo $b;
    }
--- request
    GET /bar
--- response_body
49k6ar3cdsm20trfe9m6888ad1knio92
"hello, world!
hiya"

