#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <unistd.h>
#include <netinet/in.h>

int main(){
	int welcome,new_soc,fd,n;
	char buff[1024],fname[50];
	struct sockaddr_in addr;
	
	welcome=socket(PF_INET,SOCK_STREAM,0);
	
	addr.sin_family=AF_INET;
	addr.sin_port=htons(7891);
	addr.sin_addr.s_addr=inet_addr("127.0.0.1");
	
	bind(welcome,(struct  sockaddr*)& addr,sizeof(addr));
	printf("Server is online \n");
	
	listen(welcome,5);
	
	new_soc=accept(welcome,NULL,NULL);
	recv(new_soc,fname,50,0);
	printf("%s file requested \n",fname);
	
	fd=open(fname,O_RDONLY);
	if (fd<0){
		send(new_soc,"NOT FOUND",9,0);
	}
	else{
		while((n=read(fd,buff,sizeof(buff)))>0){
			send(new_soc,buff,n,0);
		}
	}
	close(fd);
	return 0;		
}	
	
