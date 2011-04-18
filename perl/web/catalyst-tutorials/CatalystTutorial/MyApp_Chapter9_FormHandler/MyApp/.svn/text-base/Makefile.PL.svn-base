# IMPORTANT: if you delete this file your app will not work as
# expected.  you have been warned
use inc::Module::Install;

name 'MyApp';
all_from 'lib/MyApp.pm';

requires 'Catalyst::Runtime' => '5.80004';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'parent';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats

# Add modules required for this app
requires (
    'Catalyst::Plugin::Authentication' => '0',
    'Catalyst::Plugin::Session' => '0',
    'Catalyst::Plugin::Session::Store::FastMmap' => '0',
    'Catalyst::Plugin::Session::State::Cookie' => '0',
    'Catalyst::Plugin::Authorization::Roles' => '0',
    'Catalyst::Authentication::Realm::SimpleDB'=> '0',
    'DBIx::Class::EncodedColumn' => 0,
    'Perl6::Junction' => 0,
    'HTML::FormHandler::Model::DBIC' => 0,
);

catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
