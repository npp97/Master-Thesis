/*
 * sum.c
 *
 * Code generation for function 'sum'
 *
 * C source code generated on: Sat Nov 17 15:52:36 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "calcDp.h"
#include "sum.h"
#include "calcDp_data.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */

/* Function Definitions */
real_T sum(const emxArray_real_T *x)
{
  real_T y;
  boolean_T overflow;
  int32_T k;
  if (x->size[1] == 0) {
    y = 0.0;
  } else {
    y = x->data[0];
    emlrtPushRtStackR2012b(&i_emlrtRSI, emlrtRootTLSGlobal);
    if (2 > x->size[1]) {
      overflow = FALSE;
    } else {
      overflow = (x->size[1] > 2147483646);
    }

    emlrtPushRtStackR2012b(&j_emlrtRSI, emlrtRootTLSGlobal);
    check_forloop_overflow_error(overflow);
    emlrtPopRtStackR2012b(&j_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&i_emlrtRSI, emlrtRootTLSGlobal);
    for (k = 2; k <= x->size[1]; k++) {
      y += x->data[k - 1];
    }
  }

  return y;
}

/* End of code generation (sum.c) */
