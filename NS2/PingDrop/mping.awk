BEGIN{
	d=0;
}
{
	event =$1;
	if(event=="d"){
		d++;
	}
}
END{
	printf("Dropped %d",d);
}
