BEGIN{
	numtel=0;
	numftp=0;
	tottel=0;
	totftp=0;
	pktftp=0;
	pkttel=0;
}
{
	event=$1;
	type=$5;
	size=$6;
	from=$9;
	to=$10;
	
	if(event=="r" && type=="tcp" && from=="0.0" && to=="3.0"){
		numftp++;
		pktftp=size;
	}
	if(event=="r" && type=="tcp" && from=="1.0" && to=="3.1"){
		numtel++;
		pkttel=size;
	}
}
END{
	tottel=numtel*pkttel*8;
	totftp=numftp*pktftp*8;
	printf("Through put FTP %d",totftp/24);
	printf("Through put TEL %d",tottel/24);	
}
