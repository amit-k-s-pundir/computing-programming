#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  tc_utils.pl
#
#        USAGE:  ./tc_utils.pl  
#
#  DESCRIPTION:  Utilities for helping with TopCoder work.
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  YOUR NAME (), 
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  Wednesday 17 March 2010 03:24:21  IST
#     REVISION:  ---
#===============================================================================

package TC::Utils;

use strict;
use warnings;

use feature "switch";
use feature ":5.10";

use File::Copy "cp", "mv";
use LWP;
use LWP::UserAgent;
use XML::LibXML;
use lib qw(/home/sonu/workspace/programming/perl/lib);

#package TC::Utils;

BEGIN{
#  push @INC, ('/home/sonu/workspace/programming/perl/lib');
  use Exporter();
  our($VERSION, @ISA, @EXPORT, @EXPORT_OK, %EXPORT_TAGS);
  @ISA = qw(Exporter);
  @EXPORT = qw(&setup_tc_proj, &get_active_assembly_contests, &show_active_assembly_contests);
  %EXPORT_TAGS = ();
}

#package Utils;
sub setup_tc_proj{
    my($proj_name, $base_dir, $download_dir, $downloaded_files_ref, $tc_url) = @_;
    my $proj_dir = $base_dir . "/$proj_name";
    my @downloaded_files = @{$downloaded_files_ref};

    mkdir($proj_dir) unless -d $proj_dir; 
    chdir($proj_dir) or die "Problem creating and changing
    to the projects directory: $!";

    map({cp($_, $proj_dir)} map({+glob $_} map({+$download_dir . "/" .
                    $_} @downloaded_files)));    

    unless(-d $proj_dir . "/old_jars"){
        mkdir($proj_dir . "/old_jars")  or die "Can't make the directory \"old_jars\": $!";
    }

    map({cp $_, "old_jars"} glob("*.jar"));

    map({if($_ =~ /^(.+)\.jar$/){my $new_name = $1 . ".zip"; mv $_,
                $new_name;};} glob("*.jar"));

    foreach my $zip_file (glob("*.zip")){
        `unzip "$zip_file" -d "$1"` if $zip_file =~ /^(.+)\.zip$/;
    }

    unless(-d $proj_dir . "/inputs"){
        mkdir($proj_dir . "/inputs") or die "Can't create the directory \"inputs\": $!";
    }

    `mv *.zip ./inputs/`;

    say "\nProject created successfully!
    \nProject directory is: $proj_dir";
};

sub fix_tc_build_file{
    # 1. Fix the cobertura library dependency.
    my $build_file = shift;
    my $new_build_file = shift;
    my $cobertura_dir = "/usr/share/java";

    $build_file = "./build.xml" unless $build_file;
    $new_build_file = "./build.xml.new" unless $new_build_file;

    open(my $fh, $build_file) or die "Can't open ${build_file}: $!";
    open(my $new_fh, ">> $new_build_file") or die "Can't open ${new_build_file}: $!";

    while(<$fh>){
        if(/name="cobertura\.dir"/){
             my $line = "<!-- " . $_ . " -->";
            say ${new_fh} $line;
            # Now write the modified $line;
            $_ =~ s/(value="\$\{ext_libdir\}.*>)/value="$cobertura_dir"\/>/;
            print $1 if defined $1;
            say ${new_fh} $_;
            next;
        }
        print ${new_fh} $_;
    }

    # 2. Fix the topcoder_global.properties file.
};

my $ua = LWP::UserAgent->new;
my $content_file;

=head2 get_active_assembly_contests

=cut

sub get_active_assembly_contests_to_file{
  my ($url, $file) = @_;
  
  get_url_to_file($url, $file);
}

sub get_url_to_file{
  my ($url, $file) = @_;
  my $req = HTTP::Request->new(GET => $url);
  my $res = $ua->request($req, $file);
}

sub parse_assembly_contests{
    # This is old style loading/parsing interface.
    #    my $doc = XML::LibXML->new->parse_file($content_file);
    my $doc = XML::LibXML->load_html(location => $content_file, recover => 2, suppress_errors => 1);
    my $xc = XML::LibXML::XPathContext->new($doc);
    my $root_xpath = "/html/body/table/tbody/tr/td[2]/table[3]";
    my @nodes = $xc->findnodes($root_xpath);
    my $length = scalar(@nodes);
    say $length;
    foreach my $node (@nodes ) {
        say $node->to_literal();
    }

    return \@nodes;
}


#&main;

#sub main{
#    &setup_tc_proj("regular_expression_parser_1.0.0.0_dev_proj", "/home/sonu/workspace/projects/tc/dev",
#        "/opt/downloads", ["regular_expression*.jar"], "www.forums.topcoder.com");
#}

END{}

1;


