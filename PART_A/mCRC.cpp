#include<iostream>
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<time.h>
using namespace std;
# define N strlen(g)

char t[28],cs[28],g[28];
int a,e,c,d,k;

void xor1(){
  for(c=0;c<N;c++){
    cs[c]=(cs[c]==g[c])?'0':'1';
  }
}

void crc(){
  for(e=0;e<N;e++){
    cs[e]=t[e];
  }
  do{
    if(cs[0]=='1'){
      xor1();
    }
    for(c=0;c<N-1;c++){
      cs[c]=cs[c+1];
    }
    cs[c]=t[e++];
  }while(e<=a+N-1);
}

int main(){
  cout<<"Enter the string :";
  cin>>t;
  cout<<"\nEnter the divisor : ";
  cin>>g;
  a=strlen(t);
  for(e=a;e<a+N-1;e++){
    t[e]='0';
  }
  cout<<"\nModified string : "<<t<<"\n";
  crc();
  cout<<"Checksum is : "<<cs<<"\n";
  for(e=a;e<a+N-1;e++){
    t[e]=cs[e-a];
  }
  cout<<"The final codeword : "<<t<<" \n";
  cout<<"Error addtion 0 -1 \n";
  cin>>e;
  if(e==0){
    cout<<"Enter the no. of error\n";
    cin>>d;
    srand(time(0));
    for(int j=0;j<d;j++){
      k=rand()%strlen(t)-1;
      if(t[k]=='0')
        t[k]=='1';
      else
          t[k]='0';
    }
  }
  cout<<"Error data : "<<t<<"\n";
  crc();
  for(e=0;(e<N-1)&&(cs[e]=='0');e++);
  if(e<N-1){
    cout<<"Error Detected"<<" Checksum : "<<cs<<"\n";
  }
  else{
    cout<<"No error "<<" Checksum : "<<cs<<"\n";
  }
}
