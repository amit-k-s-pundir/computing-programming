#!/usr/bin/perl -w

#package TI;

#use Moose;
use strict;
#use File::Slurp;

my $html;
$| = 1;
while(<>){
#  chomp;
  $html = $html . $_;
  #	sanitize_link(sanitize_meta(sanitize_head($html)));
  #	print $html;
  #	print $_;
 # print $_;
}
#print(
#sanitize_link(sanitize_meta(sanitize_script(sanitize_head($html)))));
#print $html;
print sanitize_script(sanitize_link(sanitize_meta(sanitize_head($html))));
#print sanitize_link(sanitize_meta(sanitize_head($html)));
#print $html;
#my $file = "/home/sonu/workspace/programming/web/apache2/modules/filters/ti.html";
#open my $if, '<', "/home/sonu/workspace/programming/web/apache2/modules/filters/ti.html";
#open my $of, '>>', "/home/sonu/workspace/programming/web/apache2/modules/filters/ti_new.html";
#while(<$if>){
#  my $string = $_;
#$html = read_file($file);
#print $of "First line is: ", "\n", sanitize_link(sanitize_meta(sanitize_head($_)));
 # return $string;
#  print $of $_;

#}

1;

sub sanitize_head{
  my ($string) = @_;
  $string =~ s/<head prefix=.*?>/<head>/sg;
  return $string;
}

sub sanitize_meta{
  my ($string) = @_;
  $string =~ s/<meta content=.*?>//sg;
  return $string;
}

sub sanitize_link{
  my ($string) = @_;
  $string =~ s/<link type.*application.*rss\+xml.*?> | <link
  type=.*image\/x-icon.*?> | <link.*plus\.google\.com.*?>//sg;
  return $string;
}

sub sanitize_script{
  my ($string) = @_;
  my @script_regexes = ("<script type=\"text\/javascript\">((.*?google\.analytics\.com.*?)
			  |(.*?scorecardresearch.*?)
  |(.*?googletagservices.*?) | (.*?double_google_ads.*?) |
  (.*?socialappsintegrator.*?) | (.*?_sf_startpt.*?) |
  (.*?timeslog\.indiatimes\.com.*?) |(.*?google\.analytics\.com.*?ga\.js.*?)
  |(.*?indiatimes.*?) | (.*?document\.write.*?) | (.*?NSCompanion.*?)
  | (.*?googletagservices.*?) | <\/script>)", "<script
  src=.*?>((.*?double_google_ads.*?) | (.*?[Ss]so.*?) |
  (.*socialappsintegrator.*?))<\/script>");
  remove_scripts($string, @script_regexes);
#   $string =~ s/<script type="text\/javascript">((.*?google\.analytics\.com.*?)
# | (.*?scorecardresearch.*?) | (.*?googletagservices.*?) | (.*?double_google_ads.*?)
# | (.*?socialappsintegrator.*?) | ()<\/script>)
# | (
  return $string;
}

sub remove_item{
my($string, $regex) = @_;
$string =~ s/$regex//sg;
return $string;
}

sub remove_script{
  my ($string, $regex) = @_;
  remove_item($string, $regex);
}
sub remove_scripts{
  my ($string, @regexes) = @_;
  for (@regexes){
    remove_script($string, $_);
  }
}

sub clean_header{
}

sub clean_body{
}
