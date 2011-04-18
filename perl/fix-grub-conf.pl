#!/usr/bin/perl -w

&main;

sub main{
  &update("2.6.31-18-generic", "2.6.31-19-generic",
		  "grub.conf");
}

sub update{
  my($old_linux_kernel_img_ver, $new_linux_kernel_img_ver, $grub_conf_file)
	= @_;
  open(INFH, "< $grub_conf_file");
#  open(OUTFH, "> ~/notesandtemps/grub.conf.tmp");
  open(OUTFH, "> grub.conf.new");
  
  while(<INFH>){
#	comment_and_replace_line($old_line, $new_line);
	if(/$old_linux_kernel_img_ver/){
	  my($old_line) = "# " . $_;
	  print(OUTFH $old_line);
	  my($new_line) = $_;
	  $new_line =~ s/$old_linux_kernel_img_ver/$new_linux_kernel_img_ver/g;
	  print(OUTFH $new_line);
	  # comment_and_replace_line($old_line, $new_line);
	}else{
	  print(OUTFH $_);
	}
  }
}
