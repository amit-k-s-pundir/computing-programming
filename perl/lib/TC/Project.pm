package Project;
use Moose;

has 'name';
has 'base_dir';
has 'download_dir';
has 'downloaded_files';
has 'tc_url';

package Assembly_Project;
use Moose;

extends 'Project';
