#include<iostream>
using namespace std;

int graph[20][20];
int parents[20],key[20],discovered[20];
int sv,V;

void printPath(int parents[],int j){
  if(parents[j]==-1)
    return;
  printPath(parents,parents[j]);
  cout<<j<<" <- ";
}
void print(){
  for(int i=0;i<V;i++){
    cout<<sv<<" to "<<i<<" distance = "<<key[i]<<"\n";
    cout<<"Path : ";
    printPath(parents,i);
    cout<<"\n";
  }
}
int min_index(){
  int i,j=0,mini=999;
  for(i=0;i<V;i++){
    if(key[i]<mini && discovered[i]!=1){
      j=i;
      mini=key[i];
    }
  }
  return j;
}

void djk(){
  int i,j,wt,mindex;
  for(i=0;i<V;i++){
    discovered[i]=0;
    key[i]=999;
  }
  parents[sv]=-1;
  key[sv]=0;
  for(i=0;i<V-1;i++){
    mindex=min_index();
    discovered[mindex]=1;
    for(j=0;j<V;j++){
      wt=graph[mindex][j]+key[mindex];
      if(wt<key[j]&& discovered[j]!=1){
        key[j]=wt;
        parents[j]=mindex;
      }
    }
  }
}

int main(){
  int k;
  cout<<"Enter the number of vertices : \n";
  cin>>V;
  cout<<"Enter the matrix :\n";
  for(int i=0;i<V;i++){
    for(int j=0;j<V;j++){
      cin>>k;
      if(k==0)
        k=999;
      graph[i][j]=k;

    }
  }
  for(int i=0;i<V;i++){
    sv=i;
    cout<<"Node "<<sv<<"\n\n";
    djk();
    print();
  }
  return 0;
}
