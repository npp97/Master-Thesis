/*
 * sum.c
 *
 * Code generation for function 'sum'
 *
 * C source code generated on: Wed Nov 14 18:19:50 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "calcDp.h"
#include "sum.h"
#include "calcDp_emxutil.h"
#include "calcDp_mexutil.h"
#include "calcDp_data.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static emlrtRSInfo f_emlrtRSI = { 61, "sum",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/datafun/sum.m" };

static emlrtRSInfo x_emlrtRSI = { 72, "sum",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/datafun/sum.m" };

static emlrtRSInfo y_emlrtRSI = { 76, "sum",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/datafun/sum.m" };

static emlrtRSInfo bb_emlrtRSI = { 17, "sum",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/datafun/sum.m" };

static emlrtRSInfo cb_emlrtRSI = { 20, "sum",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/datafun/sum.m" };

static emlrtMCInfo i_emlrtMCI = { 18, 9, "sum",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/datafun/sum.m" };

static emlrtMCInfo j_emlrtMCI = { 17, 19, "sum",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/datafun/sum.m" };

static emlrtMCInfo k_emlrtMCI = { 23, 9, "sum",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/datafun/sum.m" };

static emlrtMCInfo l_emlrtMCI = { 20, 19, "sum",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/datafun/sum.m" };

static emlrtRTEInfo i_emlrtRTEI = { 55, 1, "sum",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/datafun/sum.m" };

static emlrtRTEInfo j_emlrtRTEI = { 1, 14, "sum",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/datafun/sum.m" };

/* Function Declarations */

/* Function Definitions */
void b_sum(const emxArray_real_T *x, emxArray_real_T *y)
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
                    &i_emlrtRTEI);
  if ((x->size[0] == 0) || (x->size[1] == 0)) {
    iy = y->size[0];
    y->size[0] = (int32_T)sz[0];
    emxEnsureCapacity((emxArray__common *)y, iy, (int32_T)sizeof(real_T),
                      &j_emlrtRTEI);
    ixstart = (int32_T)sz[0];
    for (iy = 0; iy < ixstart; iy++) {
      y->data[iy] = 0.0;
    }
  } else {
    iy = -1;
    ixstart = -1;
    emlrtPushRtStackR2012b(&x_emlrtRSI, emlrtRootTLSGlobal);
    overflow = (x->size[0] > 2147483646);
    emlrtPushRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
    check_forloop_overflow_error(overflow);
    emlrtPopRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&x_emlrtRSI, emlrtRootTLSGlobal);
    for (j = 1; j <= x->size[0]; j++) {
      ixstart++;
      ix = ixstart;
      s = x->data[ixstart];
      emlrtPushRtStackR2012b(&y_emlrtRSI, emlrtRootTLSGlobal);
      if (2 > x->size[1]) {
        overflow = FALSE;
      } else {
        overflow = (x->size[1] > 2147483646);
      }

      emlrtPushRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
      check_forloop_overflow_error(overflow);
      emlrtPopRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPopRtStackR2012b(&y_emlrtRSI, emlrtRootTLSGlobal);
      for (k = 2; k <= x->size[1]; k++) {
        ix += x->size[0];
        s += x->data[ix];
      }

      iy++;
      y->data[iy] = s;
    }
  }
}

real_T c_sum(const emxArray_boolean_T *x)
{
  real_T y;
  boolean_T overflow;
  boolean_T p;
  int32_T k;
  int32_T exitg1;
  const mxArray *b_y;
  static const int32_T iv9[2] = { 1, 30 };

  const mxArray *m4;
  static const char_T cv7[30] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o', 'o',
    'l', 'b', 'o', 'x', ':', 's', 'u', 'm', '_', 's', 'p', 'e', 'c', 'i', 'a',
    'l', 'E', 'm', 'p', 't', 'y' };

  const mxArray *c_y;
  static const int32_T iv10[2] = { 1, 36 };

  static const char_T cv8[36] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o', 'o',
    'l', 'b', 'o', 'x', ':', 'a', 'u', 't', 'o', 'D', 'i', 'm', 'I', 'n', 'c',
    'o', 'm', 'p', 'a', 't', 'i', 'b', 'i', 'l', 'i', 't', 'y' };

  overflow = FALSE;
  p = FALSE;
  k = 0;
  do {
    exitg1 = 0;
    if (k < 2) {
      if (x->size[k] != 0) {
        exitg1 = 1;
      } else {
        k++;
      }
    } else {
      p = TRUE;
      exitg1 = 1;
    }
  } while (exitg1 == 0);

  if (!p) {
  } else {
    overflow = TRUE;
  }

  if (!overflow) {
  } else {
    emlrtPushRtStackR2012b(&bb_emlrtRSI, emlrtRootTLSGlobal);
    b_y = NULL;
    m4 = mxCreateCharArray(2, iv9);
    emlrtInitCharArray(30, m4, cv7);
    emlrtAssign(&b_y, m4);
    error(b_message(b_y, &i_emlrtMCI), &j_emlrtMCI);
    emlrtPopRtStackR2012b(&bb_emlrtRSI, emlrtRootTLSGlobal);
  }

  if ((x->size[1] == 1) || (x->size[1] != 1)) {
    overflow = TRUE;
  } else {
    overflow = FALSE;
  }

  if (overflow) {
  } else {
    emlrtPushRtStackR2012b(&cb_emlrtRSI, emlrtRootTLSGlobal);
    c_y = NULL;
    m4 = mxCreateCharArray(2, iv10);
    emlrtInitCharArray(36, m4, cv8);
    emlrtAssign(&c_y, m4);
    error(b_message(c_y, &k_emlrtMCI), &l_emlrtMCI);
    emlrtPopRtStackR2012b(&cb_emlrtRSI, emlrtRootTLSGlobal);
  }

  if (x->size[1] == 0) {
    y = 0.0;
  } else {
    y = (real_T)x->data[0];
    emlrtPushRtStackR2012b(&f_emlrtRSI, emlrtRootTLSGlobal);
    if (2 > x->size[1]) {
      overflow = FALSE;
    } else {
      overflow = (x->size[1] > 2147483646);
    }

    emlrtPushRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
    check_forloop_overflow_error(overflow);
    emlrtPopRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&f_emlrtRSI, emlrtRootTLSGlobal);
    for (k = 2; k <= x->size[1]; k++) {
      y += (real_T)x->data[k - 1];
    }
  }

  return y;
}

real_T sum(const emxArray_real_T *x)
{
  real_T y;
  boolean_T overflow;
  int32_T k;
  if (x->size[1] == 0) {
    y = 0.0;
  } else {
    y = x->data[0];
    emlrtPushRtStackR2012b(&f_emlrtRSI, emlrtRootTLSGlobal);
    if (2 > x->size[1]) {
      overflow = FALSE;
    } else {
      overflow = (x->size[1] > 2147483646);
    }

    emlrtPushRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
    check_forloop_overflow_error(overflow);
    emlrtPopRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&f_emlrtRSI, emlrtRootTLSGlobal);
    for (k = 2; k <= x->size[1]; k++) {
      y += x->data[k - 1];
    }
  }

  return y;
}

/* End of code generation (sum.c) */
