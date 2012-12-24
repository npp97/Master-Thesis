/*
 * power.c
 *
 * Code generation for function 'power'
 *
 * C source code generated on: Mon Dec 24 12:58:39 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "V1.h"
#include "power.h"
#include "V1_emxutil.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static emlrtRTEInfo e_emlrtRTEI = { 15, 9, "eml_scalexp_alloc",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_scalexp_alloc.m"
};

/* Function Declarations */

/* Function Definitions */
void power(const emxArray_real_T *b, emxArray_real_T *y)
{
  uint32_T unnamed_idx_0;
  int32_T k;
  unnamed_idx_0 = (uint32_T)b->size[0];
  k = y->size[0];
  y->size[0] = (int32_T)unnamed_idx_0;
  emxEnsureCapacity((emxArray__common *)y, k, (int32_T)sizeof(real_T),
                    &e_emlrtRTEI);
  for (k = 0; k < (int32_T)unnamed_idx_0; k++) {
    y->data[k] = muDoubleScalarPower(2.5, b->data[k]);
  }
}

/* End of code generation (power.c) */
