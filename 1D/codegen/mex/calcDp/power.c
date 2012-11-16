/*
 * power.c
 *
 * Code generation for function 'power'
 *
 * C source code generated on: Wed Nov 14 18:19:51 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "calcDp.h"
#include "power.h"
#include "calcDp_emxutil.h"
#include "calcDp_data.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */

/* Function Definitions */
void b_power(const emxArray_real_T *a, emxArray_real_T *y)
{
  uint32_T uv1[2];
  int32_T k;
  for (k = 0; k < 2; k++) {
    uv1[k] = (uint32_T)a->size[k];
  }

  k = y->size[0] * y->size[1];
  y->size[0] = 1;
  y->size[1] = (int32_T)uv1[1];
  emxEnsureCapacity((emxArray__common *)y, k, (int32_T)sizeof(real_T),
                    &d_emlrtRTEI);
  for (k = 0; k < (int32_T)uv1[1]; k++) {
    y->data[k] = muDoubleScalarPower(a->data[k], 2.0);
  }
}

void power(const emxArray_real_T *a, emxArray_real_T *y)
{
  uint32_T uv0[2];
  int32_T i3;
  int32_T k;
  for (i3 = 0; i3 < 2; i3++) {
    uv0[i3] = (uint32_T)a->size[i3];
  }

  i3 = y->size[0] * y->size[1];
  y->size[0] = (int32_T)uv0[0];
  y->size[1] = (int32_T)uv0[1];
  emxEnsureCapacity((emxArray__common *)y, i3, (int32_T)sizeof(real_T),
                    &d_emlrtRTEI);
  i3 = (int32_T)uv0[0] * (int32_T)uv0[1];
  for (k = 0; k < i3; k++) {
    y->data[(int32_T)(1.0 + (real_T)k) - 1] = muDoubleScalarPower(a->data
      [(int32_T)(1.0 + (real_T)k) - 1], 2.0);
  }
}

/* End of code generation (power.c) */
