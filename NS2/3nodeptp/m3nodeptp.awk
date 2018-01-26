BEGIN{
	d=0;
	r=0;
}
{
	event=$1;
	if(event=="d")
		d++;
	if (event =="r")	
		r++;
}
END{
	printf("Dropped Packets %d\n",d);
	printf("Recieved Packets %d\n",r);
	print d " " r >>"mValues.txt"
}
