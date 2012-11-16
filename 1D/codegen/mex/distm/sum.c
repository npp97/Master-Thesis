/*
 * sum.c
 *
 * Code generation for function 'sum'
 *
 * C source code generated on: Wed Nov 14 02:13:55 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "distm.h"
#include "sum.h"
#include "distm_emxutil.h"
#include "distm_data.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static emlrtRSInfo b_emlrtRSI = { 72, "sum",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/datafun/sum.m" };

static emlrtRSInfo c_emlrtRSI = { 76, "sum",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/datafun/sum.m" };

static emlrtRTEInfo c_emlrtRTEI = { 55, 1, "sum",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/datafun/sum.m" };

static emlrtRTEInfo d_emlrtRTEI = { 1, 14, "sum",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/datafun/sum.m" };

/* Function Declarations */

/* Function Definitions */
void sum(const emxArray_real_T *x, emxArray_real_T *y)
{
  uint32_T sz[2];
  int32_T iy;
  int32_T ixstart;
  boolean_T overflow;
  int32_T j;
  int32_T ix;
  real_T s;
  int32_T k;
  for (iy = 0; iy < 2; iy++) {
    sz[iy] = (uint32_T)x->size[iy];
  }

  iy = y->size[0];
  y->size[0] = (int32_T)sz[0];
  emxEnsureCapacity((emxArray__common *)y, iy, (int32_T)sizeof(real_T),
                    &c_emlrtRTEI);
  if ((x->size[0] == 0) || (x->size[1] == 0)) {
    iy = y->size[0];
    y->size[0] = (int32_T)sz[0];
    emxEnsureCapacity((emxArray__common *)y, iy, (int32_T)sizeof(real_T),
                      &d_emlrtRTEI);
    ixstart = (int32_T)sz[0];
    for (iy = 0; iy < ixstart; iy++) {
      y->data[iy] = 0.0;
    }
  } else {
    iy = -1;
    ixstart = -1;
    emlrtPushRtStackR2012b(&b_emlrtRSI, emlrtRootTLSGlobal);
    overflow = (x->size[0] > 2147483646);
    emlrtPushRtStackR2012b(&d_emlrtRSI, emlrtRootTLSGlobal);
    check_forloop_overflow_error(overflow);
    emlrtPopRtStackR2012b(&d_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&b_emlrtRSI, emlrtRootTLSGlobal);
    for (j = 1; j <= x->size[0]; j++) {
      ixstart++;
      ix = ixstart;
      s = x->data[ixstart];
      emlrtPushRtStackR2012b(&c_emlrtRSI, emlrtRootTLSGlobal);
      if (2 > x->size[1]) {
        overflow = FALSE;
      } else {
        overflow = (x->size[1] > 2147483646);
      }

      emlrtPushRtStackR2012b(&d_emlrtRSI, emlrtRootTLSGlobal);
      check_forloop_overflow_error(overflow);
      emlrtPopRtStackR2012b(&d_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPopRtStackR2012b(&c_emlrtRSI, emlrtRootTLSGlobal);
      for (k = 2; k <= x->size[1]; k++) {
        ix += x->size[0];
        s += x->data[ix];
      }

      iy++;
      y->data[iy] = s;
    }
  }
}

/* End of code generation (sum.c) */
