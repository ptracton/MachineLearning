#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>

#include "decision_tree.h"

void node_Init(struct node * n){
  n->data = 0;
  n->threshold = 0;
  n->left = NULL;
  n->right = NULL;
  memset(&n->nodeName[0], 0, MAX_NODE_NAME);
  return;
}

void node_LoadWeights(struct node * n, const nodeThreshold_TypeDef * d){

  n[0].threshold = d->temperature;
  n[0].output = 0;
  memcpy(&n[0].nodeName, "temperature", MAX_NODE_NAME);

  n[1].threshold = d->time0;
  n[1].output = 0;
  memcpy(&n[1].nodeName, "time0", MAX_NODE_NAME);

  n[2].threshold = d->time1;
  n[2].output = 0;
  memcpy(&n[2].nodeName, "time1", MAX_NODE_NAME);

  n[3].threshold = d->precipitation0;
  n[3].output = 2;
  memcpy(&n[3].nodeName, "precipitation0", MAX_NODE_NAME);

  n[4].threshold = d->precipitation1;
  n[4].output = 1;
  memcpy(&n[4].nodeName, "precipitation1", MAX_NODE_NAME);

  n[5].threshold = d->precipitation2;
  n[5].output = -1;
  memcpy(&n[5].nodeName, "precipitation2", MAX_NODE_NAME);

  n[6].threshold = d->precipitation3;
  n[6].output = -2;
  memcpy(&n[6].nodeName, "precipitation3", MAX_NODE_NAME);
  return;
}

void node_LoadData(struct node *n, nodeDate_TypeDef *d){

  n[0].data = d->temperature;
  n[1].data = d->time;
  n[2].data = d->time;
  n[3].data = d->precipitation;
  n[4].data = d->precipitation;
  n[5].data = d->precipitation;
  n[6].data = d->precipitation;
  return;
}


void node_Print(struct node *n){
  printf("NODE: %s THRESHOLD: %d DATA: %d\n", n->nodeName, n->threshold, n->data);
  return;
}

void node_Connect(struct node *n){
  n[0].left = &n[1];
  n[0].right = &n[2];


  n[1].left = &n[3];
  n[1].right = &n[4];

  n[2].left = &n[5];
  n[2].right = &n[6];

  return;
}

bool node_Compare(int16_t data, int16_t threshold){
    return (data < threshold);
}

int16_t  node_Run(struct node *n){
  int16_t ret_val = 0;
  uint32_t i;
  struct node * m;
  m = n;

  for (i=0; i<MAX_TREE_DEPTH; i++){
    ret_val = m->output;
    node_Print(m);
    if (node_Compare(m->data, m->threshold)){
      m=m->left;
    }else{
      m=m->right;
    }
  }


  return ret_val;
}
