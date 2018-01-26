#include<iostream>
#include<stdio.h>
#include<string.h>
using namespace std;

int check(int f1){
  char in[100];
  int i,n,temp,sum=0;
//  if(f1!=1){
  cout<<"Enter the string \n";
  cin>>in;


  if(strlen(in)%2!=0)
    n=(strlen(in)+1)/2;
  else
    n=strlen(in)/2;
  for(i=0;i<n;i++){
    temp=in[i*2];
    temp=(temp*256)+in[(i*2)+1];
    sum+=temp;
  }

  //printf("Sum %x \n",&sum);
  if(f1==1){
    cout<<"Enter the checksum \n";
    scanf("%x",&temp );
    //cin>>temp;
    sum +=temp;
  }
  if(sum%65536!=0){
    n=sum%65536;
    sum=(sum/65536)+n;
  }
  sum=65535-sum;
  printf("sum %x \n",sum);
  cout<<"sum in decimal "<<sum<<"\n";
  return sum;
}
int main(){
  int ch,sum=0;
  do{
    cout<<"Enter the choice :\n";
    cin>>ch;
    switch(ch){
      case 1:
      sum=check(0);
      break;
      case 2:
      sum=check(1);
      if(sum!=0)
        cout<<"Invalid \n";
      else
        cout<<"Valid \n";
      break;

    }
  }while(ch<2);
  return 0;
}
