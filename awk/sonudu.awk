{
	if(0 == indexof($1, "K")
		{
			size = substr(1, indexof($1, "M"))
			if(size >= 50){print $0}
		}else{
		print " "
	}
}
