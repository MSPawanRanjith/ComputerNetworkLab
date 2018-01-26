#include<iostream>
using namespace std;

struct node {
  int dist[20];
  int from[20];
}rt[20];

int main(){
  int n,i,j,k,count;
  int costmat[20][20];
  cout<<"Enter the No. of nodes \n";
  cin>>n;
  cout<<"Enter the costmat \n";
  for(i=0;i<n;i++){
    for(j=0;j<n;j++){

      cin>>costmat[i][j];
      costmat[i][i]=0;
      rt[i].dist[j]=costmat[i][j];
      rt[i].from[j]=j;
    }
  }

  do{
    count=0;
    for(i=0;i<n;i++){
      for(j=0;j<n;j++){
        for(k=0;k<n;k++){
          if(rt[i].dist[j]>costmat[i][k]+rt[k].dist[j]){
            rt[i].dist[j]=rt[i].dist[k]+rt[k].dist[j];
            rt[i].from[j]=k;
            count++;
          }
        }
      }
    }
  }while(count!=0);

  for(i=0;i<n;i++){
    cout<<"Router "<<i+1<<"\n";
    for(j=0;j<n;j++){
      cout<<"from "<<j+1<<" to "<<rt[i].from[j]+1<<" distance "<<rt[i].dist[j]<<"\n";
    }
  }


}
