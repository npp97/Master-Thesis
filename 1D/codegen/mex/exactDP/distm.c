/*
 * distm.c
 *
 * Code generation for function 'distm'
 *
 * C source code generated on: Thu Nov 22 10:38:55 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "exactDp.h"
#include "distm.h"
#include "exactDp_emxutil.h"
#include "repmat.h"
#include "sum.h"
#include "exactDp_mexutil.h"
#include "exactDp_data.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static emlrtRSInfo h_emlrtRSI = { 9, "distm",
  "/Users/schaluck/Documents/MATLAB/Meshfree/distm.m" };

static emlrtRSInfo n_emlrtRSI = { 55, "mtimes",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/mtimes.m" };

static emlrtRSInfo o_emlrtRSI = { 21, "mtimes",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/mtimes.m" };

static emlrtRSInfo p_emlrtRSI = { 89, "mtimes",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/mtimes.m" };

static emlrtRSInfo q_emlrtRSI = { 84, "mtimes",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/mtimes.m" };

static emlrtRSInfo r_emlrtRSI = { 54, "eml_xgemm",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/eml_xgemm.m"
};

static emlrtRSInfo t_emlrtRSI = { 32, "eml_blas_xgemm",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xgemm.m"
};

static emlrtRSInfo ab_emlrtRSI = { 103, "eml_blas_xgemm",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xgemm.m"
};

static emlrtRSInfo bb_emlrtRSI = { 72, "sum",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/datafun/sum.m" };

static emlrtRSInfo cb_emlrtRSI = { 76, "sum",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/datafun/sum.m" };

static emlrtRSInfo db_emlrtRSI = { 60, "repmat",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elmat/repmat.m" };

static emlrtMCInfo g_emlrtMCI = { 85, 13, "mtimes",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/mtimes.m" };

static emlrtMCInfo h_emlrtMCI = { 84, 23, "mtimes",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/mtimes.m" };

static emlrtMCInfo i_emlrtMCI = { 90, 13, "mtimes",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/mtimes.m" };

static emlrtMCInfo j_emlrtMCI = { 89, 23, "mtimes",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/mtimes.m" };

static emlrtRTEInfo g_emlrtRTEI = { 1, 14, "distm",
  "/Users/schaluck/Documents/MATLAB/Meshfree/distm.m" };

static emlrtRTEInfo h_emlrtRTEI = { 55, 1, "sum",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/datafun/sum.m" };

static emlrtRTEInfo i_emlrtRTEI = { 45, 1, "repmat",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elmat/repmat.m" };

static emlrtECInfo b_emlrtECI = { 2, 9, 5, "distm",
  "/Users/schaluck/Documents/MATLAB/Meshfree/distm.m" };

/* Function Declarations */

/* Function Definitions */
void distm(const emxArray_real_T *X, const emxArray_real_T *Y, emxArray_real_T
           *D)
{
  emxArray_real_T *b_X;
  int32_T ix;
  int32_T loop_ub;
  emxArray_real_T *r2;
  emxArray_real_T *y;
  emxArray_real_T *b;
  int32_T iy;
  int32_T ixstart;
  const mxArray *b_y;
  static const int32_T iv5[2] = { 1, 45 };

  const mxArray *m2;
  static const char_T cv4[45] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o', 'o',
    'l', 'b', 'o', 'x', ':', 'm', 't', 'i', 'm', 'e', 's', '_', 'n', 'o', 'D',
    'y', 'n', 'a', 'm', 'i', 'c', 'S', 'c', 'a', 'l', 'a', 'r', 'E', 'x', 'p',
    'a', 'n', 's', 'i', 'o', 'n' };

  const mxArray *c_y;
  static const int32_T iv6[2] = { 1, 21 };

  static const char_T cv5[21] = { 'C', 'o', 'd', 'e', 'r', ':', 'M', 'A', 'T',
    'L', 'A', 'B', ':', 'i', 'n', 'n', 'e', 'r', 'd', 'i', 'm' };

  emxArray_real_T *C;
  emxArray_real_T *r3;
  int32_T k;
  uint32_T sz[2];
  int32_T n;
  real_T s;
  real_T absxr;
  char_T TRANSB;
  char_T TRANSA;
  int32_T iv7[2];
  int32_T outsize[2];
  emxArray_real_T *d_y;
  boolean_T overflow;
  emxArray_creal_T *x;
  emxArray_creal_T *b_x;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_X, 2, &g_emlrtRTEI, TRUE);

  /*  DISTM   Distance matrix. */
  /*   DISTM(X,Y) is the matrix of pairwise euclidean */
  /*   distances between the points in the rows of X and Y */
  /*   code by Paritosh Mokhasi and Gregory Fasshauer */
  emlrtPushRtStackR2012b(&h_emlrtRSI, emlrtRootTLSGlobal);
  ix = b_X->size[0] * b_X->size[1];
  b_X->size[0] = 1;
  b_X->size[1] = X->size[1];
  emxEnsureCapacity((emxArray__common *)b_X, ix, (int32_T)sizeof(real_T),
                    &g_emlrtRTEI);
  loop_ub = X->size[0] * X->size[1];
  for (ix = 0; ix < loop_ub; ix++) {
    b_X->data[ix] = X->data[ix] * X->data[ix];
  }

  emxInit_real_T(&r2, 2, &g_emlrtRTEI, TRUE);
  emxInit_real_T(&y, 2, &g_emlrtRTEI, TRUE);
  repmat(sum(b_X), (real_T)Y->size[0], r2);
  emlrtPopRtStackR2012b(&h_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPushRtStackR2012b(&h_emlrtRSI, emlrtRootTLSGlobal);
  ix = y->size[0] * y->size[1];
  y->size[0] = 1;
  y->size[1] = X->size[1];
  emxEnsureCapacity((emxArray__common *)y, ix, (int32_T)sizeof(real_T),
                    &g_emlrtRTEI);
  loop_ub = X->size[0] * X->size[1];
  emxFree_real_T(&b_X);
  for (ix = 0; ix < loop_ub; ix++) {
    y->data[ix] = 2.0 * X->data[ix];
  }

  emxInit_real_T(&b, 2, &g_emlrtRTEI, TRUE);
  ix = b->size[0] * b->size[1];
  b->size[0] = Y->size[1];
  b->size[1] = Y->size[0];
  emxEnsureCapacity((emxArray__common *)b, ix, (int32_T)sizeof(real_T),
                    &g_emlrtRTEI);
  loop_ub = Y->size[0];
  for (ix = 0; ix < loop_ub; ix++) {
    iy = Y->size[1];
    for (ixstart = 0; ixstart < iy; ixstart++) {
      b->data[ixstart + b->size[0] * ix] = Y->data[ix + Y->size[0] * ixstart];
    }
  }

  emlrtPushRtStackR2012b(&o_emlrtRSI, emlrtRootTLSGlobal);
  if (!(y->size[1] == b->size[0])) {
    if ((y->size[1] == 1) || ((b->size[0] == 1) && (b->size[1] == 1))) {
      emlrtPushRtStackR2012b(&q_emlrtRSI, emlrtRootTLSGlobal);
      b_y = NULL;
      m2 = mxCreateCharArray(2, iv5);
      emlrtInitCharArray(45, m2, cv4);
      emlrtAssign(&b_y, m2);
      error(message(b_y, &g_emlrtMCI), &h_emlrtMCI);
      emlrtPopRtStackR2012b(&q_emlrtRSI, emlrtRootTLSGlobal);
    } else {
      emlrtPushRtStackR2012b(&p_emlrtRSI, emlrtRootTLSGlobal);
      c_y = NULL;
      m2 = mxCreateCharArray(2, iv6);
      emlrtInitCharArray(21, m2, cv5);
      emlrtAssign(&c_y, m2);
      error(message(c_y, &i_emlrtMCI), &j_emlrtMCI);
      emlrtPopRtStackR2012b(&p_emlrtRSI, emlrtRootTLSGlobal);
    }
  }

  emlrtPopRtStackR2012b(&o_emlrtRSI, emlrtRootTLSGlobal);
  emxInit_real_T(&C, 2, &g_emlrtRTEI, TRUE);
  emxInit_real_T(&r3, 2, &g_emlrtRTEI, TRUE);
  if ((y->size[1] == 1) || (b->size[0] == 1)) {
    ix = C->size[0] * C->size[1];
    C->size[0] = 1;
    C->size[1] = b->size[1];
    emxEnsureCapacity((emxArray__common *)C, ix, (int32_T)sizeof(real_T),
                      &g_emlrtRTEI);
    loop_ub = b->size[1];
    for (ix = 0; ix < loop_ub; ix++) {
      C->data[C->size[0] * ix] = 0.0;
      iy = y->size[1];
      for (ixstart = 0; ixstart < iy; ixstart++) {
        C->data[C->size[0] * ix] += y->data[y->size[0] * ixstart] * b->
          data[ixstart + b->size[0] * ix];
      }
    }
  } else {
    k = y->size[1];
    sz[1] = (uint32_T)b->size[1];
    ix = r3->size[0] * r3->size[1];
    r3->size[0] = 1;
    emxEnsureCapacity((emxArray__common *)r3, ix, (int32_T)sizeof(real_T),
                      &g_emlrtRTEI);
    ix = r3->size[0] * r3->size[1];
    r3->size[1] = (int32_T)sz[1];
    emxEnsureCapacity((emxArray__common *)r3, ix, (int32_T)sizeof(real_T),
                      &g_emlrtRTEI);
    loop_ub = (int32_T)sz[1];
    for (ix = 0; ix < loop_ub; ix++) {
      r3->data[ix] = 0.0;
    }

    n = b->size[1];
    emlrtPushRtStackR2012b(&n_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPushRtStackR2012b(&r_emlrtRSI, emlrtRootTLSGlobal);
    ix = C->size[0] * C->size[1];
    C->size[0] = 1;
    emxEnsureCapacity((emxArray__common *)C, ix, (int32_T)sizeof(real_T),
                      &g_emlrtRTEI);
    ix = C->size[0] * C->size[1];
    C->size[1] = (int32_T)sz[1];
    emxEnsureCapacity((emxArray__common *)C, ix, (int32_T)sizeof(real_T),
                      &g_emlrtRTEI);
    loop_ub = (int32_T)sz[1];
    for (ix = 0; ix < loop_ub; ix++) {
      C->data[ix] = 0.0;
    }

    if ((b->size[1] < 1) || (y->size[1] < 1)) {
    } else {
      emlrtPushRtStackR2012b(&t_emlrtRSI, emlrtRootTLSGlobal);
      iy = 1;
      s = 1.0;
      ixstart = 1;
      absxr = 0.0;
      loop_ub = 1;
      TRANSB = 'N';
      TRANSA = 'N';
      emlrtPushRtStackR2012b(&ab_emlrtRSI, emlrtRootTLSGlobal);
      dgemm32(&TRANSA, &TRANSB, &iy, &n, &k, &s, &y->data[0], &ixstart, &b->
              data[0], &k, &absxr, &C->data[0], &loop_ub);
      emlrtPopRtStackR2012b(&ab_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPopRtStackR2012b(&t_emlrtRSI, emlrtRootTLSGlobal);
    }

    emlrtPopRtStackR2012b(&r_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&n_emlrtRSI, emlrtRootTLSGlobal);
  }

  emlrtPopRtStackR2012b(&h_emlrtRSI, emlrtRootTLSGlobal);
  for (ix = 0; ix < 2; ix++) {
    iv7[ix] = r2->size[ix];
  }

  for (ix = 0; ix < 2; ix++) {
    outsize[ix] = C->size[ix];
  }

  emlrtSizeEqCheck2DFastR2012b(iv7, outsize, &b_emlrtECI, emlrtRootTLSGlobal);
  emlrtPushRtStackR2012b(&h_emlrtRSI, emlrtRootTLSGlobal);
  ix = b->size[0] * b->size[1];
  b->size[0] = Y->size[0];
  b->size[1] = Y->size[1];
  emxEnsureCapacity((emxArray__common *)b, ix, (int32_T)sizeof(real_T),
                    &g_emlrtRTEI);
  loop_ub = Y->size[0] * Y->size[1];
  for (ix = 0; ix < loop_ub; ix++) {
    b->data[ix] = Y->data[ix] * Y->data[ix];
  }

  for (ix = 0; ix < 2; ix++) {
    sz[ix] = (uint32_T)b->size[ix];
  }

  b_emxInit_real_T(&d_y, 1, &g_emlrtRTEI, TRUE);
  ix = d_y->size[0];
  d_y->size[0] = (int32_T)sz[0];
  emxEnsureCapacity((emxArray__common *)d_y, ix, (int32_T)sizeof(real_T),
                    &h_emlrtRTEI);
  if ((b->size[0] == 0) || (b->size[1] == 0)) {
    ix = d_y->size[0];
    d_y->size[0] = (int32_T)sz[0];
    emxEnsureCapacity((emxArray__common *)d_y, ix, (int32_T)sizeof(real_T),
                      &g_emlrtRTEI);
    loop_ub = (int32_T)sz[0];
    for (ix = 0; ix < loop_ub; ix++) {
      d_y->data[ix] = 0.0;
    }
  } else {
    iy = -1;
    ixstart = -1;
    emlrtPushRtStackR2012b(&bb_emlrtRSI, emlrtRootTLSGlobal);
    overflow = (b->size[0] > 2147483646);
    emlrtPushRtStackR2012b(&j_emlrtRSI, emlrtRootTLSGlobal);
    check_forloop_overflow_error(overflow);
    emlrtPopRtStackR2012b(&j_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&bb_emlrtRSI, emlrtRootTLSGlobal);
    for (loop_ub = 1; loop_ub <= b->size[0]; loop_ub++) {
      ixstart++;
      ix = ixstart;
      s = b->data[ixstart];
      emlrtPushRtStackR2012b(&cb_emlrtRSI, emlrtRootTLSGlobal);
      if (2 > b->size[1]) {
        overflow = FALSE;
      } else {
        overflow = (b->size[1] > 2147483646);
      }

      emlrtPushRtStackR2012b(&j_emlrtRSI, emlrtRootTLSGlobal);
      check_forloop_overflow_error(overflow);
      emlrtPopRtStackR2012b(&j_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPopRtStackR2012b(&cb_emlrtRSI, emlrtRootTLSGlobal);
      for (k = 2; k <= b->size[1]; k++) {
        ix += b->size[0];
        s += b->data[ix];
      }

      iy++;
      d_y->data[iy] = s;
    }
  }

  emxFree_real_T(&b);
  ix = y->size[0] * y->size[1];
  y->size[0] = 1;
  emxEnsureCapacity((emxArray__common *)y, ix, (int32_T)sizeof(real_T),
                    &g_emlrtRTEI);
  iy = d_y->size[0];
  ix = y->size[0] * y->size[1];
  y->size[1] = iy;
  emxEnsureCapacity((emxArray__common *)y, ix, (int32_T)sizeof(real_T),
                    &g_emlrtRTEI);
  loop_ub = d_y->size[0];
  for (ix = 0; ix < loop_ub; ix++) {
    y->data[ix] = d_y->data[ix];
  }

  emxFree_real_T(&d_y);
  for (ix = 0; ix < 2; ix++) {
    outsize[ix] = y->size[ix];
  }

  ix = r3->size[0] * r3->size[1];
  r3->size[0] = 1;
  r3->size[1] = outsize[1];
  emxEnsureCapacity((emxArray__common *)r3, ix, (int32_T)sizeof(real_T),
                    &i_emlrtRTEI);
  if (outsize[1] == 0) {
  } else {
    iy = 0;
    ixstart = 0;
    emlrtPushRtStackR2012b(&db_emlrtRSI, emlrtRootTLSGlobal);
    if (1 > y->size[1]) {
      overflow = FALSE;
    } else {
      overflow = (y->size[1] > 2147483646);
    }

    emlrtPushRtStackR2012b(&j_emlrtRSI, emlrtRootTLSGlobal);
    check_forloop_overflow_error(overflow);
    emlrtPopRtStackR2012b(&j_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&db_emlrtRSI, emlrtRootTLSGlobal);
    for (loop_ub = 1; loop_ub <= y->size[1]; loop_ub++) {
      r3->data[iy] = y->data[ixstart];
      iy++;
      ixstart++;
    }
  }

  emxFree_real_T(&y);
  emlrtPopRtStackR2012b(&h_emlrtRSI, emlrtRootTLSGlobal);
  for (ix = 0; ix < 2; ix++) {
    iv7[ix] = r2->size[ix];
  }

  for (ix = 0; ix < 2; ix++) {
    outsize[ix] = r3->size[ix];
  }

  emxInit_creal_T(&x, 2, &g_emlrtRTEI, TRUE);
  emlrtSizeEqCheck2DFastR2012b(iv7, outsize, &b_emlrtECI, emlrtRootTLSGlobal);
  ix = x->size[0] * x->size[1];
  x->size[0] = 1;
  x->size[1] = r2->size[1];
  emxEnsureCapacity((emxArray__common *)x, ix, (int32_T)sizeof(creal_T),
                    &g_emlrtRTEI);
  loop_ub = r2->size[0] * r2->size[1];
  for (ix = 0; ix < loop_ub; ix++) {
    x->data[ix].re = (r2->data[ix] - C->data[ix]) + r3->data[ix];
    x->data[ix].im = 0.0;
  }

  emxFree_real_T(&r3);
  emxFree_real_T(&C);
  emxFree_real_T(&r2);
  emxInit_creal_T(&b_x, 2, &g_emlrtRTEI, TRUE);
  ix = b_x->size[0] * b_x->size[1];
  b_x->size[0] = 1;
  b_x->size[1] = x->size[1];
  emxEnsureCapacity((emxArray__common *)b_x, ix, (int32_T)sizeof(creal_T),
                    &g_emlrtRTEI);
  loop_ub = x->size[0] * x->size[1];
  for (ix = 0; ix < loop_ub; ix++) {
    b_x->data[ix] = x->data[ix];
  }

  for (k = 0; k < x->size[1]; k++) {
    if (b_x->data[k].im == 0.0) {
      if (b_x->data[k].re < 0.0) {
        s = 0.0;
        absxr = muDoubleScalarSqrt(muDoubleScalarAbs(b_x->data[k].re));
      } else {
        s = muDoubleScalarSqrt(b_x->data[k].re);
        absxr = 0.0;
      }
    } else if (b_x->data[k].re == 0.0) {
      if (b_x->data[k].im < 0.0) {
        s = muDoubleScalarSqrt(-b_x->data[k].im / 2.0);
        absxr = -s;
      } else {
        s = muDoubleScalarSqrt(b_x->data[k].im / 2.0);
        absxr = s;
      }
    } else if (muDoubleScalarIsNaN(b_x->data[k].re) || muDoubleScalarIsNaN
               (b_x->data[k].im)) {
      s = rtNaN;
      absxr = rtNaN;
    } else if (muDoubleScalarIsInf(b_x->data[k].im)) {
      s = rtInf;
      absxr = b_x->data[k].im;
    } else if (muDoubleScalarIsInf(b_x->data[k].re)) {
      if (b_x->data[k].re < 0.0) {
        s = 0.0;
        absxr = rtInf;
      } else {
        s = rtInf;
        absxr = 0.0;
      }
    } else {
      absxr = muDoubleScalarAbs(b_x->data[k].re);
      s = muDoubleScalarAbs(b_x->data[k].im);
      if ((absxr > 4.4942328371557893E+307) || (s > 4.4942328371557893E+307)) {
        absxr *= 0.5;
        s *= 0.5;
        s = muDoubleScalarHypot(absxr, s);
        if (s > absxr) {
          s = muDoubleScalarSqrt(s) * muDoubleScalarSqrt(1.0 + absxr / s);
        } else {
          s = muDoubleScalarSqrt(s) * 1.4142135623730951;
        }
      } else {
        s = muDoubleScalarSqrt((muDoubleScalarHypot(absxr, s) + absxr) * 0.5);
      }

      if (b_x->data[k].re > 0.0) {
        absxr = 0.5 * (b_x->data[k].im / s);
      } else {
        if (b_x->data[k].im < 0.0) {
          absxr = -s;
        } else {
          absxr = s;
        }

        s = 0.5 * (b_x->data[k].im / absxr);
      }
    }

    b_x->data[k].re = s;
    b_x->data[k].im = absxr;
  }

  emxFree_creal_T(&x);
  ix = D->size[0] * D->size[1];
  D->size[0] = 1;
  D->size[1] = b_x->size[1];
  emxEnsureCapacity((emxArray__common *)D, ix, (int32_T)sizeof(real_T),
                    &g_emlrtRTEI);
  loop_ub = b_x->size[0] * b_x->size[1];
  for (ix = 0; ix < loop_ub; ix++) {
    D->data[ix] = b_x->data[ix].re;
  }

  emxFree_creal_T(&b_x);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (distm.c) */
