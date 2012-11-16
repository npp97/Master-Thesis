/*
 * distm.c
 *
 * Code generation for function 'distm'
 *
 * C source code generated on: Wed Nov 14 18:19:50 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "calcDp.h"
#include "distm.h"
#include "calcDp_emxutil.h"
#include "sum.h"
#include "repmat.h"
#include "calcDp_mexutil.h"
#include "calcDp_data.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static emlrtRSInfo e_emlrtRSI = { 9, "distm",
  "/Users/schaluck/Documents/MATLAB/Meshfree/distm.m" };

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

static emlrtRSInfo ab_emlrtRSI = { 60, "repmat",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elmat/repmat.m" };

static emlrtMCInfo e_emlrtMCI = { 85, 13, "mtimes",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/mtimes.m" };

static emlrtMCInfo f_emlrtMCI = { 84, 23, "mtimes",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/mtimes.m" };

static emlrtMCInfo g_emlrtMCI = { 90, 13, "mtimes",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/mtimes.m" };

static emlrtMCInfo h_emlrtMCI = { 89, 23, "mtimes",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/mtimes.m" };

static emlrtRTEInfo f_emlrtRTEI = { 1, 14, "distm",
  "/Users/schaluck/Documents/MATLAB/Meshfree/distm.m" };

static emlrtRTEInfo g_emlrtRTEI = { 45, 1, "repmat",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elmat/repmat.m" };

static emlrtECInfo emlrtECI = { 2, 9, 5, "distm",
  "/Users/schaluck/Documents/MATLAB/Meshfree/distm.m" };

/* Function Declarations */

/* Function Definitions */
void distm(const emxArray_real_T *X, const emxArray_real_T *Y, emxArray_real_T
           *D)
{
  emxArray_real_T *b_X;
  int32_T i1;
  int32_T loop_ub;
  emxArray_real_T *r5;
  emxArray_real_T *y;
  emxArray_real_T *b;
  int32_T ib;
  int32_T iacol;
  const mxArray *b_y;
  static const int32_T iv2[2] = { 1, 45 };

  const mxArray *m1;
  static const char_T cv2[45] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o', 'o',
    'l', 'b', 'o', 'x', ':', 'm', 't', 'i', 'm', 'e', 's', '_', 'n', 'o', 'D',
    'y', 'n', 'a', 'm', 'i', 'c', 'S', 'c', 'a', 'l', 'a', 'r', 'E', 'x', 'p',
    'a', 'n', 's', 'i', 'o', 'n' };

  const mxArray *c_y;
  static const int32_T iv3[2] = { 1, 21 };

  static const char_T cv3[21] = { 'C', 'o', 'd', 'e', 'r', ':', 'M', 'A', 'T',
    'L', 'A', 'B', ':', 'i', 'n', 'n', 'e', 'r', 'd', 'i', 'm' };

  emxArray_real_T *C;
  emxArray_real_T *r6;
  int32_T k;
  uint32_T unnamed_idx_1;
  int32_T n;
  real_T absxi;
  real_T absxr;
  char_T TRANSB;
  char_T TRANSA;
  int32_T iv4[2];
  int32_T outsize[2];
  emxArray_real_T *b_Y;
  emxArray_real_T *r7;
  boolean_T overflow;
  emxArray_creal_T *x;
  emxArray_creal_T *b_x;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_X, 2, &f_emlrtRTEI, TRUE);

  /*  DISTM   Distance matrix. */
  /*   DISTM(X,Y) is the matrix of pairwise euclidean */
  /*   distances between the points in the rows of X and Y */
  /*   code by Paritosh Mokhasi and Gregory Fasshauer */
  emlrtPushRtStackR2012b(&e_emlrtRSI, emlrtRootTLSGlobal);
  i1 = b_X->size[0] * b_X->size[1];
  b_X->size[0] = 1;
  b_X->size[1] = X->size[1];
  emxEnsureCapacity((emxArray__common *)b_X, i1, (int32_T)sizeof(real_T),
                    &f_emlrtRTEI);
  loop_ub = X->size[0] * X->size[1];
  for (i1 = 0; i1 < loop_ub; i1++) {
    b_X->data[i1] = X->data[i1] * X->data[i1];
  }

  emxInit_real_T(&r5, 2, &f_emlrtRTEI, TRUE);
  emxInit_real_T(&y, 2, &f_emlrtRTEI, TRUE);
  repmat(sum(b_X), (real_T)Y->size[0], r5);
  emlrtPopRtStackR2012b(&e_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPushRtStackR2012b(&e_emlrtRSI, emlrtRootTLSGlobal);
  i1 = y->size[0] * y->size[1];
  y->size[0] = 1;
  y->size[1] = X->size[1];
  emxEnsureCapacity((emxArray__common *)y, i1, (int32_T)sizeof(real_T),
                    &f_emlrtRTEI);
  loop_ub = X->size[0] * X->size[1];
  emxFree_real_T(&b_X);
  for (i1 = 0; i1 < loop_ub; i1++) {
    y->data[i1] = 2.0 * X->data[i1];
  }

  emxInit_real_T(&b, 2, &f_emlrtRTEI, TRUE);
  i1 = b->size[0] * b->size[1];
  b->size[0] = Y->size[1];
  b->size[1] = Y->size[0];
  emxEnsureCapacity((emxArray__common *)b, i1, (int32_T)sizeof(real_T),
                    &f_emlrtRTEI);
  loop_ub = Y->size[0];
  for (i1 = 0; i1 < loop_ub; i1++) {
    ib = Y->size[1];
    for (iacol = 0; iacol < ib; iacol++) {
      b->data[iacol + b->size[0] * i1] = Y->data[i1 + Y->size[0] * iacol];
    }
  }

  emlrtPushRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
  if (!(y->size[1] == b->size[0])) {
    if ((y->size[1] == 1) || ((b->size[0] == 1) && (b->size[1] == 1))) {
      emlrtPushRtStackR2012b(&n_emlrtRSI, emlrtRootTLSGlobal);
      b_y = NULL;
      m1 = mxCreateCharArray(2, iv2);
      emlrtInitCharArray(45, m1, cv2);
      emlrtAssign(&b_y, m1);
      error(b_message(b_y, &e_emlrtMCI), &f_emlrtMCI);
      emlrtPopRtStackR2012b(&n_emlrtRSI, emlrtRootTLSGlobal);
    } else {
      emlrtPushRtStackR2012b(&m_emlrtRSI, emlrtRootTLSGlobal);
      c_y = NULL;
      m1 = mxCreateCharArray(2, iv3);
      emlrtInitCharArray(21, m1, cv3);
      emlrtAssign(&c_y, m1);
      error(b_message(c_y, &g_emlrtMCI), &h_emlrtMCI);
      emlrtPopRtStackR2012b(&m_emlrtRSI, emlrtRootTLSGlobal);
    }
  }

  emlrtPopRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
  emxInit_real_T(&C, 2, &f_emlrtRTEI, TRUE);
  emxInit_real_T(&r6, 2, &f_emlrtRTEI, TRUE);
  if ((y->size[1] == 1) || (b->size[0] == 1)) {
    i1 = C->size[0] * C->size[1];
    C->size[0] = 1;
    C->size[1] = b->size[1];
    emxEnsureCapacity((emxArray__common *)C, i1, (int32_T)sizeof(real_T),
                      &f_emlrtRTEI);
    loop_ub = b->size[1];
    for (i1 = 0; i1 < loop_ub; i1++) {
      C->data[C->size[0] * i1] = 0.0;
      ib = y->size[1];
      for (iacol = 0; iacol < ib; iacol++) {
        C->data[C->size[0] * i1] += y->data[y->size[0] * iacol] * b->data[iacol
          + b->size[0] * i1];
      }
    }
  } else {
    k = y->size[1];
    unnamed_idx_1 = (uint32_T)b->size[1];
    i1 = r6->size[0] * r6->size[1];
    r6->size[0] = 1;
    emxEnsureCapacity((emxArray__common *)r6, i1, (int32_T)sizeof(real_T),
                      &f_emlrtRTEI);
    i1 = r6->size[0] * r6->size[1];
    r6->size[1] = (int32_T)unnamed_idx_1;
    emxEnsureCapacity((emxArray__common *)r6, i1, (int32_T)sizeof(real_T),
                      &f_emlrtRTEI);
    loop_ub = (int32_T)unnamed_idx_1;
    for (i1 = 0; i1 < loop_ub; i1++) {
      r6->data[i1] = 0.0;
    }

    n = b->size[1];
    emlrtPushRtStackR2012b(&k_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPushRtStackR2012b(&o_emlrtRSI, emlrtRootTLSGlobal);
    i1 = C->size[0] * C->size[1];
    C->size[0] = 1;
    emxEnsureCapacity((emxArray__common *)C, i1, (int32_T)sizeof(real_T),
                      &f_emlrtRTEI);
    i1 = C->size[0] * C->size[1];
    C->size[1] = (int32_T)unnamed_idx_1;
    emxEnsureCapacity((emxArray__common *)C, i1, (int32_T)sizeof(real_T),
                      &f_emlrtRTEI);
    loop_ub = (int32_T)unnamed_idx_1;
    for (i1 = 0; i1 < loop_ub; i1++) {
      C->data[i1] = 0.0;
    }

    if ((b->size[1] < 1) || (y->size[1] < 1)) {
    } else {
      emlrtPushRtStackR2012b(&q_emlrtRSI, emlrtRootTLSGlobal);
      ib = 1;
      absxi = 1.0;
      iacol = 1;
      absxr = 0.0;
      loop_ub = 1;
      TRANSB = 'N';
      TRANSA = 'N';
      emlrtPushRtStackR2012b(&w_emlrtRSI, emlrtRootTLSGlobal);
      dgemm32(&TRANSA, &TRANSB, &ib, &n, &k, &absxi, &y->data[0], &iacol,
              &b->data[0], &k, &absxr, &C->data[0], &loop_ub);
      emlrtPopRtStackR2012b(&w_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPopRtStackR2012b(&q_emlrtRSI, emlrtRootTLSGlobal);
    }

    emlrtPopRtStackR2012b(&o_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&k_emlrtRSI, emlrtRootTLSGlobal);
  }

  emxFree_real_T(&b);
  emlrtPopRtStackR2012b(&e_emlrtRSI, emlrtRootTLSGlobal);
  for (i1 = 0; i1 < 2; i1++) {
    iv4[i1] = r5->size[i1];
  }

  for (i1 = 0; i1 < 2; i1++) {
    outsize[i1] = C->size[i1];
  }

  emxInit_real_T(&b_Y, 2, &f_emlrtRTEI, TRUE);
  emlrtSizeEqCheck2DFastR2012b(iv4, outsize, &emlrtECI, emlrtRootTLSGlobal);
  emlrtPushRtStackR2012b(&e_emlrtRSI, emlrtRootTLSGlobal);
  i1 = b_Y->size[0] * b_Y->size[1];
  b_Y->size[0] = Y->size[0];
  b_Y->size[1] = Y->size[1];
  emxEnsureCapacity((emxArray__common *)b_Y, i1, (int32_T)sizeof(real_T),
                    &f_emlrtRTEI);
  loop_ub = Y->size[0] * Y->size[1];
  for (i1 = 0; i1 < loop_ub; i1++) {
    b_Y->data[i1] = Y->data[i1] * Y->data[i1];
  }

  b_emxInit_real_T(&r7, 1, &f_emlrtRTEI, TRUE);
  b_sum(b_Y, r7);
  i1 = y->size[0] * y->size[1];
  y->size[0] = 1;
  emxEnsureCapacity((emxArray__common *)y, i1, (int32_T)sizeof(real_T),
                    &f_emlrtRTEI);
  ib = r7->size[0];
  i1 = y->size[0] * y->size[1];
  y->size[1] = ib;
  emxEnsureCapacity((emxArray__common *)y, i1, (int32_T)sizeof(real_T),
                    &f_emlrtRTEI);
  loop_ub = r7->size[0];
  emxFree_real_T(&b_Y);
  for (i1 = 0; i1 < loop_ub; i1++) {
    y->data[i1] = r7->data[i1];
  }

  emxFree_real_T(&r7);
  for (i1 = 0; i1 < 2; i1++) {
    outsize[i1] = y->size[i1];
  }

  i1 = r6->size[0] * r6->size[1];
  r6->size[0] = 1;
  r6->size[1] = outsize[1];
  emxEnsureCapacity((emxArray__common *)r6, i1, (int32_T)sizeof(real_T),
                    &g_emlrtRTEI);
  if (outsize[1] == 0) {
  } else {
    ib = 0;
    iacol = 0;
    emlrtPushRtStackR2012b(&ab_emlrtRSI, emlrtRootTLSGlobal);
    if (1 > y->size[1]) {
      overflow = FALSE;
    } else {
      overflow = (y->size[1] > 2147483646);
    }

    emlrtPushRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
    check_forloop_overflow_error(overflow);
    emlrtPopRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&ab_emlrtRSI, emlrtRootTLSGlobal);
    for (loop_ub = 1; loop_ub <= y->size[1]; loop_ub++) {
      r6->data[ib] = y->data[iacol];
      ib++;
      iacol++;
    }
  }

  emxFree_real_T(&y);
  emlrtPopRtStackR2012b(&e_emlrtRSI, emlrtRootTLSGlobal);
  for (i1 = 0; i1 < 2; i1++) {
    iv4[i1] = r5->size[i1];
  }

  for (i1 = 0; i1 < 2; i1++) {
    outsize[i1] = r6->size[i1];
  }

  emxInit_creal_T(&x, 2, &f_emlrtRTEI, TRUE);
  emlrtSizeEqCheck2DFastR2012b(iv4, outsize, &emlrtECI, emlrtRootTLSGlobal);
  i1 = x->size[0] * x->size[1];
  x->size[0] = 1;
  x->size[1] = r5->size[1];
  emxEnsureCapacity((emxArray__common *)x, i1, (int32_T)sizeof(creal_T),
                    &f_emlrtRTEI);
  loop_ub = r5->size[0] * r5->size[1];
  for (i1 = 0; i1 < loop_ub; i1++) {
    x->data[i1].re = (r5->data[i1] - C->data[i1]) + r6->data[i1];
    x->data[i1].im = 0.0;
  }

  emxFree_real_T(&r6);
  emxFree_real_T(&C);
  emxFree_real_T(&r5);
  emxInit_creal_T(&b_x, 2, &f_emlrtRTEI, TRUE);
  i1 = b_x->size[0] * b_x->size[1];
  b_x->size[0] = 1;
  b_x->size[1] = x->size[1];
  emxEnsureCapacity((emxArray__common *)b_x, i1, (int32_T)sizeof(creal_T),
                    &f_emlrtRTEI);
  loop_ub = x->size[0] * x->size[1];
  for (i1 = 0; i1 < loop_ub; i1++) {
    b_x->data[i1] = x->data[i1];
  }

  for (k = 0; k < x->size[1]; k++) {
    if (b_x->data[k].im == 0.0) {
      if (b_x->data[k].re < 0.0) {
        absxr = 0.0;
        absxi = muDoubleScalarSqrt(muDoubleScalarAbs(b_x->data[k].re));
      } else {
        absxr = muDoubleScalarSqrt(b_x->data[k].re);
        absxi = 0.0;
      }
    } else if (b_x->data[k].re == 0.0) {
      if (b_x->data[k].im < 0.0) {
        absxr = muDoubleScalarSqrt(-b_x->data[k].im / 2.0);
        absxi = -absxr;
      } else {
        absxr = muDoubleScalarSqrt(b_x->data[k].im / 2.0);
        absxi = absxr;
      }
    } else if (muDoubleScalarIsNaN(b_x->data[k].re) || muDoubleScalarIsNaN
               (b_x->data[k].im)) {
      absxr = rtNaN;
      absxi = rtNaN;
    } else if (muDoubleScalarIsInf(b_x->data[k].im)) {
      absxr = rtInf;
      absxi = b_x->data[k].im;
    } else if (muDoubleScalarIsInf(b_x->data[k].re)) {
      if (b_x->data[k].re < 0.0) {
        absxr = 0.0;
        absxi = rtInf;
      } else {
        absxr = rtInf;
        absxi = 0.0;
      }
    } else {
      absxr = muDoubleScalarAbs(b_x->data[k].re);
      absxi = muDoubleScalarAbs(b_x->data[k].im);
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

      if (b_x->data[k].re > 0.0) {
        absxi = 0.5 * (b_x->data[k].im / absxr);
      } else {
        if (b_x->data[k].im < 0.0) {
          absxi = -absxr;
        } else {
          absxi = absxr;
        }

        absxr = 0.5 * (b_x->data[k].im / absxi);
      }
    }

    b_x->data[k].re = absxr;
    b_x->data[k].im = absxi;
  }

  emxFree_creal_T(&x);
  i1 = D->size[0] * D->size[1];
  D->size[0] = 1;
  D->size[1] = b_x->size[1];
  emxEnsureCapacity((emxArray__common *)D, i1, (int32_T)sizeof(real_T),
                    &f_emlrtRTEI);
  loop_ub = b_x->size[0] * b_x->size[1];
  for (i1 = 0; i1 < loop_ub; i1++) {
    D->data[i1] = b_x->data[i1].re;
  }

  emxFree_creal_T(&b_x);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (distm.c) */
