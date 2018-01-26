#include<iostream>
#include<queue>
using namespace std;
queue<int> q1,q2;

void display(){
  cout<<"High Queue : ";
  if(!q1.empty()){
    queue<int> temp=q1;
    for(int i=0;i<q1.size();i++){
      cout<<temp.front()<<" , ";
      temp.pop();
    }
    cout<<"\n";
  }
  else
    cout<<"Empty High Queue\n";
  cout<<"Low Queue : ";
    if(!q2.empty()){
      queue<int> temp=q2;
      for(int i=0;i<q2.size();i++){
        cout<<temp.front()<<" , ";
        temp.pop();
      }
      cout<<"\n";
    }
    else
      cout<<"Empty Low Queue\n";
}

void sendData(){
  cout<<"Sending Data ";
  if(!q1.empty()){
    cout<<q1.front()<<" \n";
    q1.pop();
  }
  else{
    if(!q2.empty()){
      cout<<q2.front()<<"\n";
      q2.pop();
    }
    else{
      cout<<"No data to Send\n";
    }
  }
}
void insertData(int data,int pri){
  if(pri==1 && q1.size()<=3){
    q1.push(data);
  }
  else{
    cout<<"Packet Dropped\n";
  }
  if(pri==2 && q2.size()<=3){
    q2.push(data);
  }
  else if(pri==2){
    cout<<"Packet Dropped\n";
  }
}
int main(){
  int data,pri,ch;
  cout<<"Size of q1 and q2 "<<q1.size()<<" --  "<<q2.size()<<"\n";
  while(true){
    cout<<"Enter the choice \n";
    cin>>ch;
    display();
    switch(ch){
      case 1:
              cout<<"Enter data \n";
              cin>>data;
              cout<<"Enter priority\n";
              cin>>pri;
              insertData(data,pri);
              break;
      case 2:
              sendData();
              break;
      case 3:
              return 0;
      default:
              break;
    }
  }
}
