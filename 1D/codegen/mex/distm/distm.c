/*
 * distm.c
 *
 * Code generation for function 'distm'
 *
 * C source code generated on: Wed Nov 14 02:13:55 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "distm.h"
#include "distm_emxutil.h"
#include "sum.h"
#include "repmat.h"
#include "distm_mexutil.h"
#include "distm_data.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 9, "distm",
  "/Users/schaluck/Documents/MATLAB/Meshfree/distm.m" };

static emlrtRSInfo e_emlrtRSI = { 49, "eml_int_forloop_overflow_check",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m"
};

static emlrtRSInfo k_emlrtRSI = { 55, "mtimes",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/mtimes.m" };

static emlrtRSInfo l_emlrtRSI = { 21, "mtimes",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/mtimes.m" };

static emlrtRSInfo m_emlrtRSI = { 89, "mtimes",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/mtimes.m" };

static emlrtRSInfo n_emlrtRSI = { 84, "mtimes",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/mtimes.m" };

static emlrtRSInfo o_emlrtRSI = { 54, "eml_xgemm",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/eml_xgemm.m"
};

static emlrtRSInfo q_emlrtRSI = { 32, "eml_blas_xgemm",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xgemm.m"
};

static emlrtRSInfo w_emlrtRSI = { 103, "eml_blas_xgemm",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xgemm.m"
};

static emlrtRSInfo x_emlrtRSI = { 10, "repmat",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elmat/repmat.m" };

static emlrtRSInfo y_emlrtRSI = { 60, "repmat",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elmat/repmat.m" };

static emlrtMCInfo emlrtMCI = { 50, 9, "eml_int_forloop_overflow_check",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m"
};

static emlrtMCInfo b_emlrtMCI = { 49, 15, "eml_int_forloop_overflow_check",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m"
};

static emlrtMCInfo e_emlrtMCI = { 85, 13, "mtimes",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/mtimes.m" };

static emlrtMCInfo f_emlrtMCI = { 84, 23, "mtimes",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/mtimes.m" };

static emlrtMCInfo g_emlrtMCI = { 90, 13, "mtimes",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/mtimes.m" };

static emlrtMCInfo h_emlrtMCI = { 89, 23, "mtimes",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/mtimes.m" };

static emlrtRTEInfo emlrtRTEI = { 1, 14, "distm",
  "/Users/schaluck/Documents/MATLAB/Meshfree/distm.m" };

static emlrtECInfo emlrtECI = { 2, 9, 5, "distm",
  "/Users/schaluck/Documents/MATLAB/Meshfree/distm.m" };

/* Function Declarations */
static const mxArray *message(const mxArray *b, const mxArray *c, emlrtMCInfo
  *location);

/* Function Definitions */
static const mxArray *message(const mxArray *b, const mxArray *c, emlrtMCInfo
  *location)
{
  const mxArray *pArrays[2];
  const mxArray *m4;
  pArrays[0] = b;
  pArrays[1] = c;
  return emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m4, 2, pArrays, "message",
    TRUE, location);
}

void check_forloop_overflow_error(boolean_T overflow)
{
  const mxArray *y;
  static const int32_T iv3[2] = { 1, 34 };

  const mxArray *m1;
  static const char_T cv2[34] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o', 'o',
    'l', 'b', 'o', 'x', ':', 'i', 'n', 't', '_', 'f', 'o', 'r', 'l', 'o', 'o',
    'p', '_', 'o', 'v', 'e', 'r', 'f', 'l', 'o', 'w' };

  const mxArray *b_y;
  static const int32_T iv4[2] = { 1, 23 };

  static const char_T cv3[23] = { 'c', 'o', 'd', 'e', 'r', '.', 'i', 'n', 't',
    'e', 'r', 'n', 'a', 'l', '.', 'i', 'n', 'd', 'e', 'x', 'I', 'n', 't' };

  if (!overflow) {
  } else {
    emlrtPushRtStackR2012b(&e_emlrtRSI, emlrtRootTLSGlobal);
    y = NULL;
    m1 = mxCreateCharArray(2, iv3);
    emlrtInitCharArray(34, m1, cv2);
    emlrtAssign(&y, m1);
    b_y = NULL;
    m1 = mxCreateCharArray(2, iv4);
    emlrtInitCharArray(23, m1, cv3);
    emlrtAssign(&b_y, m1);
    error(message(y, b_y, &emlrtMCI), &b_emlrtMCI);
    emlrtPopRtStackR2012b(&e_emlrtRSI, emlrtRootTLSGlobal);
  }
}

void distm(const emxArray_real_T *X, const emxArray_real_T *Y, emxArray_real_T
           *D)
{
  emxArray_real_T *b_X;
  int32_T i0;
  int32_T loop_ub;
  emxArray_real_T *r0;
  emxArray_real_T *y;
  emxArray_real_T *r1;
  emxArray_real_T *b;
  int32_T k;
  int32_T m;
  const mxArray *b_y;
  static const int32_T iv0[2] = { 1, 45 };

  const mxArray *m0;
  static const char_T cv0[45] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o', 'o',
    'l', 'b', 'o', 'x', ':', 'm', 't', 'i', 'm', 'e', 's', '_', 'n', 'o', 'D',
    'y', 'n', 'a', 'm', 'i', 'c', 'S', 'c', 'a', 'l', 'a', 'r', 'E', 'x', 'p',
    'a', 'n', 's', 'i', 'o', 'n' };

  const mxArray *c_y;
  static const int32_T iv1[2] = { 1, 21 };

  static const char_T cv1[21] = { 'C', 'o', 'd', 'e', 'r', ':', 'M', 'A', 'T',
    'L', 'A', 'B', ':', 'i', 'n', 'n', 'e', 'r', 'd', 'i', 'm' };

  emxArray_real_T *C;
  emxArray_real_T *r2;
  int32_T n;
  int32_T jcol;
  uint32_T unnamed_idx_0;
  uint32_T unnamed_idx_1;
  real_T absxi;
  real_T absxr;
  char_T TRANSB;
  char_T TRANSA;
  int32_T iv2[2];
  int32_T outsize[2];
  emxArray_real_T *b_Y;
  emxArray_real_T *a;
  int32_T mv[2];
  boolean_T overflow;
  boolean_T b0;
  emxArray_creal_T *x;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_X, 2, &emlrtRTEI, TRUE);

  /*  DISTM   Distance matrix. */
  /*   DISTM(X,Y) is the matrix of pairwise euclidean */
  /*   distances between the points in the rows of X and Y */
  /*   code by Paritosh Mokhasi and Gregory Fasshauer */
  emlrtPushRtStackR2012b(&emlrtRSI, emlrtRootTLSGlobal);
  i0 = b_X->size[0] * b_X->size[1];
  b_X->size[0] = X->size[0];
  b_X->size[1] = X->size[1];
  emxEnsureCapacity((emxArray__common *)b_X, i0, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  loop_ub = X->size[0] * X->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_X->data[i0] = X->data[i0] * X->data[i0];
  }

  emxInit_real_T(&r0, 2, &emlrtRTEI, TRUE);
  emxInit_real_T(&y, 2, &emlrtRTEI, TRUE);
  b_emxInit_real_T(&r1, 1, &emlrtRTEI, TRUE);
  sum(b_X, r1);
  repmat(r1, (real_T)Y->size[0], r0);
  emlrtPopRtStackR2012b(&emlrtRSI, emlrtRootTLSGlobal);
  emlrtPushRtStackR2012b(&emlrtRSI, emlrtRootTLSGlobal);
  i0 = y->size[0] * y->size[1];
  y->size[0] = X->size[0];
  y->size[1] = X->size[1];
  emxEnsureCapacity((emxArray__common *)y, i0, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  loop_ub = X->size[0] * X->size[1];
  emxFree_real_T(&b_X);
  for (i0 = 0; i0 < loop_ub; i0++) {
    y->data[i0] = 2.0 * X->data[i0];
  }

  emxInit_real_T(&b, 2, &emlrtRTEI, TRUE);
  i0 = b->size[0] * b->size[1];
  b->size[0] = Y->size[1];
  b->size[1] = Y->size[0];
  emxEnsureCapacity((emxArray__common *)b, i0, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  loop_ub = Y->size[0];
  for (i0 = 0; i0 < loop_ub; i0++) {
    k = Y->size[1];
    for (m = 0; m < k; m++) {
      b->data[m + b->size[0] * i0] = Y->data[i0 + Y->size[0] * m];
    }
  }

  emlrtPushRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
  if (!(y->size[1] == b->size[0])) {
    if (((y->size[0] == 1) && (y->size[1] == 1)) || ((b->size[0] == 1) &&
         (b->size[1] == 1))) {
      emlrtPushRtStackR2012b(&n_emlrtRSI, emlrtRootTLSGlobal);
      b_y = NULL;
      m0 = mxCreateCharArray(2, iv0);
      emlrtInitCharArray(45, m0, cv0);
      emlrtAssign(&b_y, m0);
      error(b_message(b_y, &e_emlrtMCI), &f_emlrtMCI);
      emlrtPopRtStackR2012b(&n_emlrtRSI, emlrtRootTLSGlobal);
    } else {
      emlrtPushRtStackR2012b(&m_emlrtRSI, emlrtRootTLSGlobal);
      c_y = NULL;
      m0 = mxCreateCharArray(2, iv1);
      emlrtInitCharArray(21, m0, cv1);
      emlrtAssign(&c_y, m0);
      error(b_message(c_y, &g_emlrtMCI), &h_emlrtMCI);
      emlrtPopRtStackR2012b(&m_emlrtRSI, emlrtRootTLSGlobal);
    }
  }

  emlrtPopRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
  emxInit_real_T(&C, 2, &emlrtRTEI, TRUE);
  emxInit_real_T(&r2, 2, &emlrtRTEI, TRUE);
  if ((y->size[1] == 1) || (b->size[0] == 1)) {
    i0 = C->size[0] * C->size[1];
    C->size[0] = y->size[0];
    C->size[1] = b->size[1];
    emxEnsureCapacity((emxArray__common *)C, i0, (int32_T)sizeof(real_T),
                      &emlrtRTEI);
    loop_ub = y->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      k = b->size[1];
      for (m = 0; m < k; m++) {
        C->data[i0 + C->size[0] * m] = 0.0;
        n = y->size[1];
        for (jcol = 0; jcol < n; jcol++) {
          C->data[i0 + C->size[0] * m] += y->data[i0 + y->size[0] * jcol] *
            b->data[jcol + b->size[0] * m];
        }
      }
    }
  } else {
    k = y->size[1];
    unnamed_idx_0 = (uint32_T)y->size[0];
    unnamed_idx_1 = (uint32_T)b->size[1];
    i0 = r2->size[0] * r2->size[1];
    r2->size[0] = (int32_T)unnamed_idx_0;
    emxEnsureCapacity((emxArray__common *)r2, i0, (int32_T)sizeof(real_T),
                      &emlrtRTEI);
    i0 = r2->size[0] * r2->size[1];
    r2->size[1] = (int32_T)unnamed_idx_1;
    emxEnsureCapacity((emxArray__common *)r2, i0, (int32_T)sizeof(real_T),
                      &emlrtRTEI);
    loop_ub = (int32_T)unnamed_idx_0 * (int32_T)unnamed_idx_1;
    for (i0 = 0; i0 < loop_ub; i0++) {
      r2->data[i0] = 0.0;
    }

    m = y->size[0];
    n = b->size[1];
    emlrtPushRtStackR2012b(&k_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPushRtStackR2012b(&o_emlrtRSI, emlrtRootTLSGlobal);
    i0 = C->size[0] * C->size[1];
    C->size[0] = (int32_T)unnamed_idx_0;
    emxEnsureCapacity((emxArray__common *)C, i0, (int32_T)sizeof(real_T),
                      &emlrtRTEI);
    i0 = C->size[0] * C->size[1];
    C->size[1] = (int32_T)unnamed_idx_1;
    emxEnsureCapacity((emxArray__common *)C, i0, (int32_T)sizeof(real_T),
                      &emlrtRTEI);
    loop_ub = (int32_T)unnamed_idx_0 * (int32_T)unnamed_idx_1;
    for (i0 = 0; i0 < loop_ub; i0++) {
      C->data[i0] = 0.0;
    }

    if ((y->size[0] < 1) || (b->size[1] < 1) || (y->size[1] < 1)) {
    } else {
      emlrtPushRtStackR2012b(&q_emlrtRSI, emlrtRootTLSGlobal);
      absxi = 1.0;
      absxr = 0.0;
      TRANSB = 'N';
      TRANSA = 'N';
      emlrtPushRtStackR2012b(&w_emlrtRSI, emlrtRootTLSGlobal);
      dgemm32(&TRANSA, &TRANSB, &m, &n, &k, &absxi, &y->data[0], &m, &b->data[0],
              &k, &absxr, &C->data[0], &m);
      emlrtPopRtStackR2012b(&w_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPopRtStackR2012b(&q_emlrtRSI, emlrtRootTLSGlobal);
    }

    emlrtPopRtStackR2012b(&o_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&k_emlrtRSI, emlrtRootTLSGlobal);
  }

  emxFree_real_T(&b);
  emxFree_real_T(&y);
  emlrtPopRtStackR2012b(&emlrtRSI, emlrtRootTLSGlobal);
  for (i0 = 0; i0 < 2; i0++) {
    iv2[i0] = r0->size[i0];
  }

  for (i0 = 0; i0 < 2; i0++) {
    outsize[i0] = C->size[i0];
  }

  emxInit_real_T(&b_Y, 2, &emlrtRTEI, TRUE);
  emlrtSizeEqCheck2DFastR2012b(iv2, outsize, &emlrtECI, emlrtRootTLSGlobal);
  emlrtPushRtStackR2012b(&emlrtRSI, emlrtRootTLSGlobal);
  i0 = b_Y->size[0] * b_Y->size[1];
  b_Y->size[0] = Y->size[0];
  b_Y->size[1] = Y->size[1];
  emxEnsureCapacity((emxArray__common *)b_Y, i0, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  loop_ub = Y->size[0] * Y->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_Y->data[i0] = Y->data[i0] * Y->data[i0];
  }

  emxInit_real_T(&a, 2, &emlrtRTEI, TRUE);
  sum(b_Y, r1);
  i0 = a->size[0] * a->size[1];
  a->size[0] = 1;
  emxEnsureCapacity((emxArray__common *)a, i0, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  k = r1->size[0];
  i0 = a->size[0] * a->size[1];
  a->size[1] = k;
  emxEnsureCapacity((emxArray__common *)a, i0, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  loop_ub = r1->size[0];
  emxFree_real_T(&b_Y);
  for (i0 = 0; i0 < loop_ub; i0++) {
    a->data[i0] = r1->data[i0];
  }

  emxFree_real_T(&r1);
  emlrtPushRtStackR2012b(&x_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPopRtStackR2012b(&x_emlrtRSI, emlrtRootTLSGlobal);
  mv[0] = X->size[0];
  mv[1] = 1;
  for (i0 = 0; i0 < 2; i0++) {
    outsize[i0] = a->size[i0] * mv[i0];
  }

  i0 = r2->size[0] * r2->size[1];
  r2->size[0] = outsize[0];
  r2->size[1] = outsize[1];
  emxEnsureCapacity((emxArray__common *)r2, i0, (int32_T)sizeof(real_T),
                    &b_emlrtRTEI);
  if ((outsize[0] == 0) || (outsize[1] == 0)) {
  } else {
    k = 0;
    m = 0;
    emlrtPushRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPushRtStackR2012b(&d_emlrtRSI, emlrtRootTLSGlobal);
    check_forloop_overflow_error(FALSE);
    emlrtPopRtStackR2012b(&d_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
    n = 0;
    emlrtPushRtStackR2012b(&y_emlrtRSI, emlrtRootTLSGlobal);
    if (1 > a->size[1]) {
      overflow = FALSE;
    } else {
      overflow = (a->size[1] > 2147483646);
    }

    emlrtPushRtStackR2012b(&d_emlrtRSI, emlrtRootTLSGlobal);
    check_forloop_overflow_error(overflow);
    emlrtPopRtStackR2012b(&d_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&y_emlrtRSI, emlrtRootTLSGlobal);
    for (jcol = 1; jcol <= a->size[1]; jcol++) {
      emlrtPushRtStackR2012b(&h_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPushRtStackR2012b(&d_emlrtRSI, emlrtRootTLSGlobal);
      if (1 > mv[0]) {
        b0 = FALSE;
      } else {
        b0 = (mv[0] > 2147483646);
      }

      check_forloop_overflow_error(b0);
      emlrtPopRtStackR2012b(&d_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPopRtStackR2012b(&h_emlrtRSI, emlrtRootTLSGlobal);
      for (loop_ub = 1; loop_ub <= mv[0]; loop_ub++) {
        r2->data[m] = a->data[n];
        k = n + 1;
        m++;
      }

      n = k;
    }
  }

  emxFree_real_T(&a);
  emlrtPopRtStackR2012b(&emlrtRSI, emlrtRootTLSGlobal);
  for (i0 = 0; i0 < 2; i0++) {
    iv2[i0] = r0->size[i0];
  }

  for (i0 = 0; i0 < 2; i0++) {
    outsize[i0] = r2->size[i0];
  }

  emxInit_creal_T(&x, 2, &emlrtRTEI, TRUE);
  emlrtSizeEqCheck2DFastR2012b(iv2, outsize, &emlrtECI, emlrtRootTLSGlobal);
  i0 = x->size[0] * x->size[1];
  x->size[0] = r0->size[0];
  x->size[1] = r0->size[1];
  emxEnsureCapacity((emxArray__common *)x, i0, (int32_T)sizeof(creal_T),
                    &emlrtRTEI);
  loop_ub = r0->size[0] * r0->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    x->data[i0].re = (r0->data[i0] - C->data[i0]) + r2->data[i0];
    x->data[i0].im = 0.0;
  }

  emxFree_real_T(&r2);
  emxFree_real_T(&C);
  emxFree_real_T(&r0);
  i0 = x->size[0] * x->size[1];
  for (k = 0; k < i0; k++) {
    if (x->data[(int32_T)(1.0 + (real_T)k) - 1].im == 0.0) {
      if (x->data[(int32_T)(1.0 + (real_T)k) - 1].re < 0.0) {
        absxr = 0.0;
        absxi = muDoubleScalarSqrt(muDoubleScalarAbs(x->data[(int32_T)(1.0 +
          (real_T)k) - 1].re));
      } else {
        absxr = muDoubleScalarSqrt(x->data[(int32_T)(1.0 + (real_T)k) - 1].re);
        absxi = 0.0;
      }
    } else if (x->data[(int32_T)(1.0 + (real_T)k) - 1].re == 0.0) {
      if (x->data[(int32_T)(1.0 + (real_T)k) - 1].im < 0.0) {
        absxr = muDoubleScalarSqrt(-x->data[(int32_T)(1.0 + (real_T)k) - 1].im /
          2.0);
        absxi = -absxr;
      } else {
        absxr = muDoubleScalarSqrt(x->data[(int32_T)(1.0 + (real_T)k) - 1].im /
          2.0);
        absxi = absxr;
      }
    } else if (muDoubleScalarIsNaN(x->data[(int32_T)(1.0 + (real_T)k) - 1].re) ||
               muDoubleScalarIsNaN(x->data[(int32_T)(1.0 + (real_T)k) - 1].im))
    {
      absxr = rtNaN;
      absxi = rtNaN;
    } else if (muDoubleScalarIsInf(x->data[(int32_T)(1.0 + (real_T)k) - 1].im))
    {
      absxr = rtInf;
      absxi = x->data[(int32_T)(1.0 + (real_T)k) - 1].im;
    } else if (muDoubleScalarIsInf(x->data[(int32_T)(1.0 + (real_T)k) - 1].re))
    {
      if (x->data[(int32_T)(1.0 + (real_T)k) - 1].re < 0.0) {
        absxr = 0.0;
        absxi = rtInf;
      } else {
        absxr = rtInf;
        absxi = 0.0;
      }
    } else {
      absxr = muDoubleScalarAbs(x->data[(int32_T)(1.0 + (real_T)k) - 1].re);
      absxi = muDoubleScalarAbs(x->data[(int32_T)(1.0 + (real_T)k) - 1].im);
      if ((absxr > 4.4942328371557893E+307) || (absxi > 4.4942328371557893E+307))
      {
        absxr *= 0.5;
        absxi *= 0.5;
        absxi = muDoubleScalarHypot(absxr, absxi);
        if (absxi > absxr) {
          absxr = muDoubleScalarSqrt(absxi) * muDoubleScalarSqrt(1.0 + absxr /
            absxi);
        } else {
          absxr = muDoubleScalarSqrt(absxi) * 1.4142135623730951;
        }
      } else {
        absxr = muDoubleScalarSqrt((muDoubleScalarHypot(absxr, absxi) + absxr) *
          0.5);
      }

      if (x->data[(int32_T)(1.0 + (real_T)k) - 1].re > 0.0) {
        absxi = 0.5 * (x->data[(int32_T)(1.0 + (real_T)k) - 1].im / absxr);
      } else {
        if (x->data[(int32_T)(1.0 + (real_T)k) - 1].im < 0.0) {
          absxi = -absxr;
        } else {
          absxi = absxr;
        }

        absxr = 0.5 * (x->data[(int32_T)(1.0 + (real_T)k) - 1].im / absxi);
      }
    }

    x->data[(int32_T)(1.0 + (real_T)k) - 1].re = absxr;
    x->data[(int32_T)(1.0 + (real_T)k) - 1].im = absxi;
  }

  i0 = D->size[0] * D->size[1];
  D->size[0] = x->size[0];
  D->size[1] = x->size[1];
  emxEnsureCapacity((emxArray__common *)D, i0, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  loop_ub = x->size[0] * x->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    D->data[i0] = x->data[i0].re;
  }

  emxFree_creal_T(&x);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (distm.c) */
