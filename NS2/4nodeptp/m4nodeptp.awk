BEGIN{
	t=0;
	u=0;
}
{
	type=$5;
	
	if(type=="tcp"){
		t++;
	}
	if(type=="cbr"){
		u++;
	}
}
END{
	printf("UDP %d \n",u);
	printf("TCP %d \n",t);
}
