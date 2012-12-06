/*
 * Riley.c
 *
 * Code generation for function 'Riley'
 *
 * C source code generated on: Thu Dec  6 20:27:30 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "Riley.h"
#include "Riley_emxutil.h"
#include "mldivide.h"
#include "chol.h"
#include "Riley_mexutil.h"
#include "Riley_data.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 3, "Riley",
  "/Users/schaluck/Documents/MATLAB/MT/1D/Riley.m" };

static emlrtRSInfo b_emlrtRSI = { 4, "Riley",
  "/Users/schaluck/Documents/MATLAB/MT/1D/Riley.m" };

static emlrtRSInfo c_emlrtRSI = { 5, "Riley",
  "/Users/schaluck/Documents/MATLAB/MT/1D/Riley.m" };

static emlrtRSInfo d_emlrtRSI = { 6, "Riley",
  "/Users/schaluck/Documents/MATLAB/MT/1D/Riley.m" };

static emlrtRSInfo e_emlrtRSI = { 9, "Riley",
  "/Users/schaluck/Documents/MATLAB/MT/1D/Riley.m" };

static emlrtRSInfo f_emlrtRSI = { 10, "Riley",
  "/Users/schaluck/Documents/MATLAB/MT/1D/Riley.m" };

static emlrtRSInfo g_emlrtRSI = { 20, "eye",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elmat/eye.m" };

static emlrtRSInfo h_emlrtRSI = { 50, "eye",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elmat/eye.m" };

static emlrtRSInfo i_emlrtRSI = { 59, "eye",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elmat/eye.m" };

static emlrtRSInfo k_emlrtRSI = { 52, "eml_assert_valid_size_arg",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_assert_valid_size_arg.m"
};

static emlrtMCInfo c_emlrtMCI = { 53, 5, "eml_assert_valid_size_arg",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_assert_valid_size_arg.m"
};

static emlrtMCInfo d_emlrtMCI = { 52, 15, "eml_assert_valid_size_arg",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_assert_valid_size_arg.m"
};

static emlrtRTEInfo emlrtRTEI = { 1, 14, "Riley",
  "/Users/schaluck/Documents/MATLAB/MT/1D/Riley.m" };

static emlrtRTEInfo b_emlrtRTEI = { 4, 5, "Riley",
  "/Users/schaluck/Documents/MATLAB/MT/1D/Riley.m" };

static emlrtRTEInfo c_emlrtRTEI = { 5, 5, "Riley",
  "/Users/schaluck/Documents/MATLAB/MT/1D/Riley.m" };

static emlrtECInfo emlrtECI = { 2, 3, 9, "Riley",
  "/Users/schaluck/Documents/MATLAB/MT/1D/Riley.m" };

static emlrtECInfo b_emlrtECI = { 2, 11, 13, "Riley",
  "/Users/schaluck/Documents/MATLAB/MT/1D/Riley.m" };

/* Function Declarations */

/* Function Definitions */
void Riley(const emxArray_real_T *A, const emxArray_real_T *b, real_T mu,
           emxArray_real_T *x)
{
  uint32_T n[2];
  int32_T minval;
  real_T b_n;
  real_T c_n;
  const mxArray *y;
  static const int32_T iv0[2] = { 1, 21 };

  const mxArray *m0;
  static const char_T cv0[21] = { 'C', 'o', 'd', 'e', 'r', ':', 'M', 'A', 'T',
    'L', 'A', 'B', ':', 'p', 'm', 'a', 'x', 's', 'i', 'z', 'e' };

  emxArray_real_T *L;
  int32_T loop_ub;
  int32_T b_A[2];
  int32_T b_L[2];
  emxArray_real_T *z;
  emxArray_real_T *b_z;
  emxArray_real_T *c_z;
  emxArray_real_T *b_mu;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emlrtPushRtStackR2012b(&emlrtRSI, emlrtRootTLSGlobal);
  for (minval = 0; minval < 2; minval++) {
    n[minval] = (uint32_T)A->size[minval];
  }

  emlrtPushRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPushRtStackR2012b(&h_emlrtRSI, emlrtRootTLSGlobal);
  if (n[1] <= 0U) {
    b_n = 0.0;
  } else {
    if (n[0] <= 0U) {
      c_n = 0.0;
    } else {
      c_n = (real_T)n[0];
    }

    b_n = c_n * (real_T)n[1];
  }

  if (2.147483647E+9 >= b_n) {
  } else {
    emlrtPushRtStackR2012b(&k_emlrtRSI, emlrtRootTLSGlobal);
    y = NULL;
    m0 = mxCreateCharArray(2, iv0);
    emlrtInitCharArray(21, m0, cv0);
    emlrtAssign(&y, m0);
    error(message(y, &c_emlrtMCI), &d_emlrtMCI);
    emlrtPopRtStackR2012b(&k_emlrtRSI, emlrtRootTLSGlobal);
  }

  emxInit_real_T(&L, 2, &b_emlrtRTEI, TRUE);
  emlrtPopRtStackR2012b(&h_emlrtRSI, emlrtRootTLSGlobal);
  minval = L->size[0] * L->size[1];
  L->size[0] = (int32_T)n[0];
  emxEnsureCapacity((emxArray__common *)L, minval, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  minval = L->size[0] * L->size[1];
  L->size[1] = (int32_T)n[1];
  emxEnsureCapacity((emxArray__common *)L, minval, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  loop_ub = (int32_T)n[0] * (int32_T)n[1];
  for (minval = 0; minval < loop_ub; minval++) {
    L->data[minval] = 0.0;
  }

  minval = (int32_T)muDoubleScalarMin((real_T)n[0], (real_T)n[1]);
  if (minval > 0) {
    emlrtPushRtStackR2012b(&i_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPushRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
    check_forloop_overflow_error(minval > 2147483646);
    emlrtPopRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&i_emlrtRSI, emlrtRootTLSGlobal);
    for (loop_ub = 0; loop_ub + 1 <= minval; loop_ub++) {
      L->data[loop_ub + L->size[0] * loop_ub] = 1.0;
    }
  }

  emlrtPopRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
  minval = L->size[0] * L->size[1];
  L->size[0] = L->size[0];
  L->size[1] = L->size[1];
  emxEnsureCapacity((emxArray__common *)L, minval, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  loop_ub = L->size[0];
  minval = L->size[1];
  loop_ub *= minval;
  for (minval = 0; minval < loop_ub; minval++) {
    L->data[minval] *= mu;
  }

  emlrtPopRtStackR2012b(&emlrtRSI, emlrtRootTLSGlobal);
  for (minval = 0; minval < 2; minval++) {
    b_A[minval] = A->size[minval];
  }

  for (minval = 0; minval < 2; minval++) {
    b_L[minval] = L->size[minval];
  }

  emlrtSizeEqCheck2DFastR2012b(b_A, b_L, &emlrtECI, emlrtRootTLSGlobal);
  emlrtPushRtStackR2012b(&b_emlrtRSI, emlrtRootTLSGlobal);
  minval = L->size[0] * L->size[1];
  L->size[0] = A->size[0];
  L->size[1] = A->size[1];
  emxEnsureCapacity((emxArray__common *)L, minval, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  loop_ub = A->size[0] * A->size[1];
  for (minval = 0; minval < loop_ub; minval++) {
    L->data[minval] += A->data[minval];
  }

  emxInit_real_T(&z, 2, &c_emlrtRTEI, TRUE);
  emxInit_real_T(&b_z, 2, &emlrtRTEI, TRUE);
  chol(L);
  emlrtPopRtStackR2012b(&b_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPushRtStackR2012b(&c_emlrtRSI, emlrtRootTLSGlobal);
  mldivide(L, b, z);
  emlrtPopRtStackR2012b(&c_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPushRtStackR2012b(&d_emlrtRSI, emlrtRootTLSGlobal);
  minval = b_z->size[0] * b_z->size[1];
  b_z->size[0] = z->size[0];
  b_z->size[1] = z->size[1];
  emxEnsureCapacity((emxArray__common *)b_z, minval, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  loop_ub = z->size[0] * z->size[1];
  for (minval = 0; minval < loop_ub; minval++) {
    b_z->data[minval] = z->data[minval];
  }

  mldivide(L, b_z, z);
  emlrtPopRtStackR2012b(&d_emlrtRSI, emlrtRootTLSGlobal);
  minval = x->size[0] * x->size[1];
  x->size[0] = z->size[0];
  x->size[1] = z->size[1];
  emxEnsureCapacity((emxArray__common *)x, minval, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  loop_ub = z->size[0] * z->size[1];
  emxFree_real_T(&b_z);
  for (minval = 0; minval < loop_ub; minval++) {
    x->data[minval] = z->data[minval];
  }

  emxInit_real_T(&c_z, 2, &emlrtRTEI, TRUE);
  emlrtPushRtStackR2012b(&e_emlrtRSI, emlrtRootTLSGlobal);
  minval = c_z->size[0] * c_z->size[1];
  c_z->size[0] = z->size[0];
  c_z->size[1] = z->size[1];
  emxEnsureCapacity((emxArray__common *)c_z, minval, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  loop_ub = z->size[0] * z->size[1];
  for (minval = 0; minval < loop_ub; minval++) {
    c_z->data[minval] = z->data[minval];
  }

  emxInit_real_T(&b_mu, 2, &emlrtRTEI, TRUE);
  mldivide(L, c_z, z);
  emlrtPopRtStackR2012b(&e_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPushRtStackR2012b(&f_emlrtRSI, emlrtRootTLSGlobal);
  minval = b_mu->size[0] * b_mu->size[1];
  b_mu->size[0] = z->size[0];
  b_mu->size[1] = z->size[1];
  emxEnsureCapacity((emxArray__common *)b_mu, minval, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  loop_ub = z->size[0] * z->size[1];
  emxFree_real_T(&c_z);
  for (minval = 0; minval < loop_ub; minval++) {
    b_mu->data[minval] = mu * z->data[minval];
  }

  mldivide(L, b_mu, z);
  emlrtPopRtStackR2012b(&f_emlrtRSI, emlrtRootTLSGlobal);
  emxFree_real_T(&b_mu);
  emxFree_real_T(&L);
  for (minval = 0; minval < 2; minval++) {
    b_A[minval] = x->size[minval];
  }

  for (minval = 0; minval < 2; minval++) {
    b_L[minval] = z->size[minval];
  }

  emlrtSizeEqCheck2DFastR2012b(b_A, b_L, &b_emlrtECI, emlrtRootTLSGlobal);
  minval = x->size[0] * x->size[1];
  x->size[0] = x->size[0];
  x->size[1] = x->size[1];
  emxEnsureCapacity((emxArray__common *)x, minval, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  loop_ub = x->size[0];
  minval = x->size[1];
  loop_ub *= minval;
  for (minval = 0; minval < loop_ub; minval++) {
    x->data[minval] += z->data[minval];
  }

  emxFree_real_T(&z);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (Riley.c) */
