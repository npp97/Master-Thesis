/*
 * monitor_function.c
 *
 * Code generation for function 'monitor_function'
 *
 * C source code generated on: Sat Nov 17 15:52:36 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "calcDp.h"
#include "monitor_function.h"
#include "calcDp_emxutil.h"
#include "calcDp_mexutil.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static emlrtRSInfo e_emlrtRSI = { 4, "monitor_function",
  "/Users/schaluck/Documents/MATLAB/MT/1D/monitor_function.m" };

static emlrtRSInfo f_emlrtRSI = { 14, "sqrt",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elfun/sqrt.m" };

static emlrtRSInfo g_emlrtRSI = { 20, "eml_error",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_error.m" };

static emlrtMCInfo emlrtMCI = { 20, 11, "eml_error",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_error.m" };

static emlrtMCInfo b_emlrtMCI = { 20, 5, "eml_error",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_error.m" };

static emlrtRTEInfo e_emlrtRTEI = { 15, 9, "eml_scalexp_alloc",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_scalexp_alloc.m"
};

static emlrtRTEInfo f_emlrtRTEI = { 1, 22, "monitor_function",
  "/Users/schaluck/Documents/MATLAB/MT/1D/monitor_function.m" };

/* Function Declarations */
static void eml_error(void);

/* Function Definitions */
static void eml_error(void)
{
  const mxArray *y;
  static const int32_T iv4[2] = { 1, 30 };

  const mxArray *m1;
  static const char_T cv3[30] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o', 'o',
    'l', 'b', 'o', 'x', ':', 's', 'q', 'r', 't', '_', 'd', 'o', 'm', 'a', 'i',
    'n', 'E', 'r', 'r', 'o', 'r' };

  emlrtPushRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
  y = NULL;
  m1 = mxCreateCharArray(2, iv4);
  emlrtInitCharArray(30, m1, cv3);
  emlrtAssign(&y, m1);
  error(message(y, &emlrtMCI), &b_emlrtMCI);
  emlrtPopRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
}

void monitor_function(const emxArray_real_T *DF, real_T Dzero, emxArray_real_T
                      *Ddash)
{
  uint32_T uv0[2];
  int32_T b_Ddash;
  int32_T k;

  /* UNTITLED Summary of this function goes here */
  /*    Detailed explanation goes here */
  emlrtPushRtStackR2012b(&e_emlrtRSI, emlrtRootTLSGlobal);
  for (b_Ddash = 0; b_Ddash < 2; b_Ddash++) {
    uv0[b_Ddash] = (uint32_T)DF->size[b_Ddash];
  }

  b_Ddash = Ddash->size[0] * Ddash->size[1];
  Ddash->size[0] = (int32_T)uv0[0];
  Ddash->size[1] = (int32_T)uv0[1];
  emxEnsureCapacity((emxArray__common *)Ddash, b_Ddash, (int32_T)sizeof(real_T),
                    &e_emlrtRTEI);
  b_Ddash = (int32_T)uv0[0] * (int32_T)uv0[1];
  for (k = 0; k < b_Ddash; k++) {
    Ddash->data[(int32_T)(1.0 + (real_T)k) - 1] = muDoubleScalarPower(DF->data
      [(int32_T)(1.0 + (real_T)k) - 1], 2.0);
  }

  b_Ddash = Ddash->size[0] * Ddash->size[1];
  Ddash->size[0] = Ddash->size[0];
  Ddash->size[1] = Ddash->size[1];
  emxEnsureCapacity((emxArray__common *)Ddash, b_Ddash, (int32_T)sizeof(real_T),
                    &f_emlrtRTEI);
  k = Ddash->size[0];
  b_Ddash = Ddash->size[1];
  k *= b_Ddash;
  for (b_Ddash = 0; b_Ddash < k; b_Ddash++) {
    Ddash->data[b_Ddash]++;
  }

  b_Ddash = Ddash->size[0] * Ddash->size[1];
  for (k = 0; k < b_Ddash; k++) {
    if (Ddash->data[(int32_T)(1.0 + (real_T)k) - 1] < 0.0) {
      emlrtPushRtStackR2012b(&f_emlrtRSI, emlrtRootTLSGlobal);
      eml_error();
      emlrtPopRtStackR2012b(&f_emlrtRSI, emlrtRootTLSGlobal);
    }
  }

  b_Ddash = Ddash->size[0] * Ddash->size[1];
  for (k = 0; k < b_Ddash; k++) {
    Ddash->data[(int32_T)(1.0 + (real_T)k) - 1] = muDoubleScalarSqrt(Ddash->
      data[(int32_T)(1.0 + (real_T)k) - 1]);
  }

  b_Ddash = Ddash->size[0] * Ddash->size[1];
  Ddash->size[0] = Ddash->size[0];
  Ddash->size[1] = Ddash->size[1];
  emxEnsureCapacity((emxArray__common *)Ddash, b_Ddash, (int32_T)sizeof(real_T),
                    &f_emlrtRTEI);
  k = Ddash->size[0];
  b_Ddash = Ddash->size[1];
  k *= b_Ddash;
  for (b_Ddash = 0; b_Ddash < k; b_Ddash++) {
    Ddash->data[b_Ddash] = Dzero / Ddash->data[b_Ddash];
  }

  emlrtPopRtStackR2012b(&e_emlrtRSI, emlrtRootTLSGlobal);
}

/* End of code generation (monitor_function.c) */
