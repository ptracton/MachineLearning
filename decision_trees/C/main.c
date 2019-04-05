
#include <stdio.h>
#include <stdint.h>
#include <string.h>

#include "decision_tree.h"


static struct node tree0[MAX_TREE_ELEMENTS];
const nodeThreshold_TypeDef tree0_weights = {

                                        .temperature=75,

                                        .time0 = 1200,
                                        .time1 = 2359,

                                        .precipitation0 = 1,
                                        .precipitation1 = 10,
                                        .precipitation2 = 100,
                                        .precipitation3 = 200

};

nodeDate_TypeDef tree0_data = {
                               .temperature = 72,
                               .time = 1301,
                               .precipitation = 75
};

int main(void){
  uint32_t i;
  int16_t tree_value = 0;

  printf("Generic C decision Tree\n");
  for (i=0; i< MAX_TREE_ELEMENTS; i++){
    node_Init(&tree0[i]);
  }

  node_Connect(&tree0[0]);
  node_LoadWeights(&tree0[0], &tree0_weights);
  node_LoadData(&tree0[0], &tree0_data);
  tree_value = node_Run(&tree0[0]);
  printf("Tree Value = %d\n\n", tree_value);
  return 0;
}
