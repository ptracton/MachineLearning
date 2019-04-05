#ifndef __DECISION_TREE_H__
#define __DECISION_TREE_H__

#include <stdint.h>
#include <math.h>

#define MAX_TREE_DEPTH (3)
#define MAX_TREE_ELEMENTS  (7) //(uint32_t) pow(2, (MAX_TREE_DEPTH))-1
#define MAX_NODE_NAME 16

struct node{
  int16_t data;
  int16_t threshold;
  int16_t output;
  uint8_t nodeName[MAX_NODE_NAME];
  struct node * left;
  struct node * right;
};


typedef struct{
  uint16_t temperature;

  uint16_t time0;
  uint16_t time1;

  uint16_t precipitation0;
  uint16_t precipitation1;
  uint16_t precipitation2;
  uint16_t precipitation3;

} nodeThreshold_TypeDef;

typedef struct{
  uint16_t temperature;
  uint16_t time;
  uint16_t precipitation;
} nodeDate_TypeDef;

void node_Init(struct node * n);
void node_LoadWeights(struct node * n, const nodeThreshold_TypeDef * d);
void node_LoadData(struct node *n, nodeDate_TypeDef *d);
void node_Print(struct node *n);
void node_Connect(struct node *n);
int16_t  node_Run(struct node *n);

#endif
