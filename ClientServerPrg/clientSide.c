#include<stdio.h>
#include<stdlib.h>
#include<fcntl.h>
#include<sys/types.h>
#include<sys/stat.h>
#include<sys/socket.h>
#include<unistd.h>
#include<netinet/in.h>

int main(){
	int soc,n;
	char buff[1024],fname[50];
	struct sockaddr_in addr;
	
	soc=socket(PF_INET,SOCK_STREAM,0);
	
	addr.sin_family=AF_INET;
	addr.sin_port=htons(7891);
	addr.sin_addr.s_addr=inet_addr("127.0.0.1");
	
	while(connect(soc,(struct  sockaddr*)&addr,sizeof(addr)));
	printf("Connection Established \n ");
	printf("Enter the file required : \n");
	scanf("%s",fname);
	
	send(soc,fname,50,0);
	
	while((n=recv(soc,buff,sizeof(buff),0))>0){
		printf("%s",buff);
	}
	
	return 0;
	

}
