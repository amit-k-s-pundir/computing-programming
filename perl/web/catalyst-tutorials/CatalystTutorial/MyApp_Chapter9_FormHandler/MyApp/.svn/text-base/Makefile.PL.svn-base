#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install;

name 'MyApp';
all_from 'lib/MyApp.pm';

requires 'Catalyst::Runtime' => '5.80018';
requires 'Catalyst::Authentication::Realm::SimpleDB';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Plugin::StackTrace';
requires 'Catalyst::Plugin::Authentication';
requires 'Catalyst::Plugin::Authorization::Roles';
requires 'Catalyst::Plugin::Session';
requires 'Catalyst::Plugin::Session::Store::FastMmap';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'Catalyst::Action::RenderView';
requires 'Catalyst::View::TT';
requires 'HTML::FormHandler::Model::DBIC';
requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
requires 'Perl6::Junction';
test_requires 'Test::More' => '0.88';

catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
