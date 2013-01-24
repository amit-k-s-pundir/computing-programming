#!/usr/bin/perl -w
# run_video_camera_mencoder.pl --- Runs the video camera - specifically mencoder - at well
# defined time and intervals.
# Author: Amit K S Pundir <sonu@localhost>
# Created: 06 Nov 2011
# Version: 0.01

use warnings;
use strict;

use feature ":5.10";
use feature "switch";

sub run_video_camera_for_duration{
    my($video_output_file_path, $video_command, $duration, $special_suffix) = @_;
    unless ($video_output_file_path) {
      my $video_output_file_name = "webcam_" .`date +%H_%M_%S_%Z_%a_%d_%b_%Y` ".avi";
      $video_output_file_path = "/home/sonu/Videos/Webcam/"
        . $video_output_file_name . $special_prefix;
    };
        
    unless ($video_command) {
      $video_command = qq {echo "sonu" | sudo -S mencoder tv:// \\
driver=v4l2:width:height=240:device=/dev/video0 -ovc lavc -o $video_output_file_path};
    };
    unless ($duration) {
      $duration = 120;
    };
    
    run_command_for_duration($video_command, $duration);
  };

sub run_command_for_duration{
my($command, $duration) = @_;
sub sigALARM_handler{
kill TERM $$;
}
alarm 125;

}

__END__

=head1 NAME

run_video_camera_mencoder.pl - Describe the usage of script briefly

=head1 SYNOPSIS

run_video_camera_mencoder.pl [options] args

      -opt --long      Option description

=head1 DESCRIPTION

Stub documentation for run_video_camera_mencoder.pl, 

=head1 AUTHOR

Amit K S Pundir, E<lt>sonu@localhostE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011 by Amit K S Pundir

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.2 or,
at your option, any later version of Perl 5 you may have available.

=head1 BUGS

None reported... yet.

=cut
