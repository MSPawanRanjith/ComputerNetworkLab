#include<iostream>
using namespace std;

int main(){
  int buff,buffiled=0,data,ch,rate;
  cout<<"Enter the buff size : \n";
  cin>>buff;
  cout<<"Enter the rate of :\n";
  cin>>rate;
  while(true){
    cout<<"Enter the choice \n";
    cin>>ch;
    switch (ch) {
      case 1:
        cout<<"Data Size :\n";
        cin>>data;
        if(data+buffiled>buff){
          cout<<"Insufficient storage dropped \n"<<endl;
        }
        else{
          cout<<"Packet Added\n";
          buffiled+=data;
        }
      case 2:
        if(!buffiled){
          cout<<"No data sent\n";
        }
        if(buffiled>=rate){
          buffiled-=rate;
          cout<<rate<<" bytes sent\n";
          cout<<buffiled<<" bytes remaining\n";
        }
        else{
          cout<<buffiled<<" bytes sent\n";
          buffiled=0;
          cout<<buffiled<<" bytes remaining\n";
        }
        break;
      case 3:
          return 0;
    }
  }
  return 0;
}
