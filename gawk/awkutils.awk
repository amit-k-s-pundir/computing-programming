	{
		x = index($1, "M")
		if(0 != x){
			#size = strtonum(substr($1,1,x-1));
			print $0
		}
	}

