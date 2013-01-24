use strict;
use warnings;
use Test::More;


use Catalyst::Test 'test_app2';
use test_app2::Controller::TC;

ok( request('/tc')->is_success, 'Request should succeed' );
done_testing();
