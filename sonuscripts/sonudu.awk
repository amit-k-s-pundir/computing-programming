BEGIN{
	default_size=5
}

{
	if(0 == index($1, "K"))
		{
			size = substr($1, 1, index($1, "M") - 1) + 0
			print size 
			if(size >= default_size){print $0};
		}
	
}


