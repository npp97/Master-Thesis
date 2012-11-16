/*
 * calcDp.c
 *
 * Code generation for function 'calcDp'
 *
 * C source code generated on: Wed Nov 14 18:19:50 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "calcDp.h"
#include "calcDp_emxutil.h"
#include "sum.h"
#include "power.h"
#include "gradllh.h"
#include "distm.h"
#include "calcDp_mexutil.h"
#include "calcDp_data.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 12, "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m" };

static emlrtRSInfo b_emlrtRSI = { 13, "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m" };

static emlrtRSInfo c_emlrtRSI = { 14, "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m" };

static emlrtRSInfo d_emlrtRSI = { 17, "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m" };

static emlrtRSInfo h_emlrtRSI = { 49, "eml_int_forloop_overflow_check",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m"
};

static emlrtRSInfo db_emlrtRSI = { 11, "eml_li_find",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_li_find.m" };

static emlrtRSInfo eb_emlrtRSI = { 14, "eml_li_find",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_li_find.m" };

static emlrtRSInfo fb_emlrtRSI = { 26, "eml_li_find",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_li_find.m" };

static emlrtRSInfo gb_emlrtRSI = { 39, "eml_li_find",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_li_find.m" };

static emlrtRSInfo hb_emlrtRSI = { 4, "monitor_function",
  "/Users/schaluck/Documents/MATLAB/MT/1D/monitor_function.m" };

static emlrtRSInfo pb_emlrtRSI = { 14, "sqrt",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elfun/sqrt.m" };

static emlrtRSInfo qb_emlrtRSI = { 20, "eml_error",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_error.m" };

static emlrtRSInfo rb_emlrtRSI = { 16, "min",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/datafun/min.m" };

static emlrtRSInfo sb_emlrtRSI = { 18, "eml_min_or_max",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_min_or_max.m"
};

static emlrtRSInfo tb_emlrtRSI = { 38, "eml_min_or_max",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_min_or_max.m"
};

static emlrtRSInfo ub_emlrtRSI = { 73, "eml_min_or_max",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_min_or_max.m"
};

static emlrtRSInfo vb_emlrtRSI = { 88, "eml_min_or_max",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_min_or_max.m"
};

static emlrtRSInfo wb_emlrtRSI = { 219, "eml_min_or_max",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_min_or_max.m"
};

static emlrtRSInfo xb_emlrtRSI = { 192, "eml_min_or_max",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_min_or_max.m"
};

static emlrtMCInfo emlrtMCI = { 50, 9, "eml_int_forloop_overflow_check",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m"
};

static emlrtMCInfo b_emlrtMCI = { 49, 15, "eml_int_forloop_overflow_check",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m"
};

static emlrtMCInfo m_emlrtMCI = { 14, 5, "eml_li_find",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_li_find.m" };

static emlrtMCInfo r_emlrtMCI = { 20, 11, "eml_error",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_error.m" };

static emlrtMCInfo s_emlrtMCI = { 20, 5, "eml_error",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_error.m" };

static emlrtMCInfo t_emlrtMCI = { 41, 9, "eml_min_or_max",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_min_or_max.m"
};

static emlrtMCInfo u_emlrtMCI = { 38, 19, "eml_min_or_max",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_min_or_max.m"
};

static emlrtMCInfo v_emlrtMCI = { 74, 9, "eml_min_or_max",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_min_or_max.m"
};

static emlrtMCInfo w_emlrtMCI = { 73, 19, "eml_min_or_max",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_min_or_max.m"
};

static emlrtRTEInfo emlrtRTEI = { 1, 15, "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m" };

static emlrtRTEInfo b_emlrtRTEI = { 17, 9, "eml_li_find",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_li_find.m" };

static emlrtRTEInfo e_emlrtRTEI = { 12, 13, "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m" };

static emlrtBCInfo emlrtBCI = { -1, -1, 10, 37, "Dp", "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m", 0 };

static emlrtBCInfo b_emlrtBCI = { -1, -1, 12, 28, "X", "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m", 0 };

static emlrtBCInfo c_emlrtBCI = { -1, -1, 12, 47, "Dp", "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m", 0 };

static emlrtBCInfo d_emlrtBCI = { -1, -1, 17, 44, "X", "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m", 0 };

static emlrtBCInfo e_emlrtBCI = { -1, -1, 10, 29, "Dp", "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m", 0 };

static emlrtBCInfo f_emlrtBCI = { -1, -1, 11, 22, "Dp", "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m", 0 };

static emlrtBCInfo g_emlrtBCI = { -1, -1, 17, 17, "Dp", "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m", 0 };

static emlrtBCInfo h_emlrtBCI = { -1, -1, 14, 49, "Xp", "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m", 0 };

static emlrtBCInfo i_emlrtBCI = { -1, -1, 14, 17, "Dp", "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m", 0 };

/* Function Declarations */
static void eml_error(void);
static const mxArray *message(const mxArray *b, const mxArray *c, emlrtMCInfo
  *location);

/* Function Definitions */
static void eml_error(void)
{
  const mxArray *y;
  static const int32_T iv13[2] = { 1, 30 };

  const mxArray *m6;
  static const char_T cv11[30] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o', 'o',
    'l', 'b', 'o', 'x', ':', 's', 'q', 'r', 't', '_', 'd', 'o', 'm', 'a', 'i',
    'n', 'E', 'r', 'r', 'o', 'r' };

  emlrtPushRtStackR2012b(&qb_emlrtRSI, emlrtRootTLSGlobal);
  y = NULL;
  m6 = mxCreateCharArray(2, iv13);
  emlrtInitCharArray(30, m6, cv11);
  emlrtAssign(&y, m6);
  error(b_message(y, &r_emlrtMCI), &s_emlrtMCI);
  emlrtPopRtStackR2012b(&qb_emlrtRSI, emlrtRootTLSGlobal);
}

static const mxArray *message(const mxArray *b, const mxArray *c, emlrtMCInfo
  *location)
{
  const mxArray *pArrays[2];
  const mxArray *m8;
  pArrays[0] = b;
  pArrays[1] = c;
  return emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m8, 2, pArrays, "message",
    TRUE, location);
}

void calcDp(const emxArray_real_T *X, const emxArray_real_T *Xp, real_T rstar,
            real_T Dzero, emxArray_real_T *Dp)
{
  int32_T i0;
  int32_T loop_ub;
  int32_T j;
  emxArray_boolean_T *ind;
  emxArray_int32_T *y;
  emxArray_real_T *gU;
  emxArray_real_T *b_y;
  emxArray_real_T *a;
  emxArray_real_T *r0;
  emxArray_real_T *b_gU;
  emxArray_real_T *b_X;
  emxArray_real_T *c_X;
  emxArray_real_T *r1;
  emxArray_real_T *b_Xp;
  emxArray_int32_T *r2;
  emxArray_int32_T *r3;
  emxArray_int32_T *r4;
  real_T Dp_old;
  int32_T k;
  int32_T exitg1;
  int32_T bsub;
  real_T x;
  boolean_T overflow;
  int32_T bk;
  const mxArray *c_y;
  const mxArray *m0;
  int32_T b_j;
  const mxArray *d_y;
  static const int32_T iv0[2] = { 1, 36 };

  static const char_T cv0[36] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o', 'o',
    'l', 'b', 'o', 'x', ':', 'a', 'u', 't', 'o', 'D', 'i', 'm', 'I', 'n', 'c',
    'o', 'm', 'p', 'a', 't', 'i', 'b', 'i', 'l', 'i', 't', 'y' };

  const mxArray *e_y;
  static const int32_T iv1[2] = { 1, 39 };

  static const char_T cv1[39] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o', 'o',
    'l', 'b', 'o', 'x', ':', 'e', 'm', 'l', '_', 'm', 'i', 'n', '_', 'o', 'r',
    '_', 'm', 'a', 'x', '_', 'v', 'a', 'r', 'D', 'i', 'm', 'Z', 'e', 'r', 'o' };

  boolean_T exitg2;
  int32_T exitg3;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  i0 = Dp->size[0];
  Dp->size[0] = X->size[0];
  emxEnsureCapacity((emxArray__common *)Dp, i0, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  loop_ub = X->size[0];
  for (i0 = 0; i0 < loop_ub; i0++) {
    Dp->data[i0] = Dzero;
  }

  j = 0;
  emxInit_boolean_T(&ind, 2, &e_emlrtRTEI, TRUE);
  emxInit_int32_T(&y, 2, &emlrtRTEI, TRUE);
  emxInit_real_T(&gU, 2, &emlrtRTEI, TRUE);
  b_emxInit_real_T(&b_y, 1, &emlrtRTEI, TRUE);
  b_emxInit_real_T(&a, 1, &emlrtRTEI, TRUE);
  emxInit_real_T(&r0, 2, &emlrtRTEI, TRUE);
  emxInit_real_T(&b_gU, 2, &emlrtRTEI, TRUE);
  emxInit_real_T(&b_X, 2, &emlrtRTEI, TRUE);
  emxInit_real_T(&c_X, 2, &emlrtRTEI, TRUE);
  emxInit_real_T(&r1, 2, &emlrtRTEI, TRUE);
  emxInit_real_T(&b_Xp, 2, &emlrtRTEI, TRUE);
  b_emxInit_int32_T(&r2, 1, &emlrtRTEI, TRUE);
  b_emxInit_int32_T(&r3, 1, &emlrtRTEI, TRUE);
  b_emxInit_int32_T(&r4, 1, &emlrtRTEI, TRUE);
  while (j <= X->size[0] - 1) {
    Dp_old = rtMinusInf;
    k = 0;
    do {
      exitg1 = 0;
      i0 = Dp->size[0];
      bsub = 1 + j;
      x = Dp_old - Dp->data[emlrtDynamicBoundsCheckFastR2012b(bsub, 1, i0,
        &e_emlrtBCI, emlrtRootTLSGlobal) - 1];
      i0 = Dp->size[0];
      bsub = (int32_T)(1.0 + (real_T)j);
      emlrtDynamicBoundsCheckFastR2012b(bsub, 1, i0, &emlrtBCI,
        emlrtRootTLSGlobal);
      if ((muDoubleScalarAbs(x) / Dp->data[j] > 0.01) && (k < 15)) {
        i0 = Dp->size[0];
        bsub = 1 + j;
        Dp_old = Dp->data[emlrtDynamicBoundsCheckFastR2012b(bsub, 1, i0,
          &f_emlrtBCI, emlrtRootTLSGlobal) - 1];
        emlrtPushRtStackR2012b(&emlrtRSI, emlrtRootTLSGlobal);
        i0 = Dp->size[0];
        bsub = (int32_T)(1.0 + (real_T)j);
        emlrtDynamicBoundsCheckFastR2012b(bsub, 1, i0, &c_emlrtBCI,
          emlrtRootTLSGlobal);
        x = rstar * Dp->data[j];
        loop_ub = X->size[1];
        i0 = X->size[0];
        bsub = 1 + j;
        i0 = emlrtDynamicBoundsCheckFastR2012b(bsub, 1, i0, &b_emlrtBCI,
          emlrtRootTLSGlobal);
        bsub = c_X->size[0] * c_X->size[1];
        c_X->size[0] = 1;
        c_X->size[1] = loop_ub;
        emxEnsureCapacity((emxArray__common *)c_X, bsub, (int32_T)sizeof(real_T),
                          &emlrtRTEI);
        for (bsub = 0; bsub < loop_ub; bsub++) {
          c_X->data[c_X->size[0] * bsub] = X->data[(i0 + X->size[0] * bsub) - 1];
        }

        distm(c_X, Xp, gU);
        i0 = ind->size[0] * ind->size[1];
        ind->size[0] = 1;
        ind->size[1] = gU->size[1];
        emxEnsureCapacity((emxArray__common *)ind, i0, (int32_T)sizeof(boolean_T),
                          &emlrtRTEI);
        loop_ub = gU->size[0] * gU->size[1];
        for (i0 = 0; i0 < loop_ub; i0++) {
          ind->data[i0] = (gU->data[i0] <= x);
        }

        emlrtPopRtStackR2012b(&emlrtRSI, emlrtRootTLSGlobal);
        emlrtPushRtStackR2012b(&b_emlrtRSI, emlrtRootTLSGlobal);
        overflow = (c_sum(ind) > 0.0);
        emlrtPopRtStackR2012b(&b_emlrtRSI, emlrtRootTLSGlobal);
        if (overflow) {
          emlrtPushRtStackR2012b(&c_emlrtRSI, emlrtRootTLSGlobal);
          emlrtPushRtStackR2012b(&db_emlrtRSI, emlrtRootTLSGlobal);
          bk = 0;
          emlrtPushRtStackR2012b(&gb_emlrtRSI, emlrtRootTLSGlobal);
          if (1 > ind->size[1]) {
            overflow = FALSE;
          } else {
            overflow = (ind->size[1] > 2147483646);
          }

          emlrtPushRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
          check_forloop_overflow_error(overflow);
          emlrtPopRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
          emlrtPopRtStackR2012b(&gb_emlrtRSI, emlrtRootTLSGlobal);
          for (bsub = 1; bsub <= ind->size[1]; bsub++) {
            if (ind->data[bsub - 1]) {
              bk++;
            }
          }

          emlrtPopRtStackR2012b(&db_emlrtRSI, emlrtRootTLSGlobal);
          if (bk <= ind->size[1]) {
          } else {
            emlrtPushRtStackR2012b(&eb_emlrtRSI, emlrtRootTLSGlobal);
            c_y = NULL;
            m0 = mxCreateString("Assertion failed.");
            emlrtAssign(&c_y, m0);
            error(c_y, &m_emlrtMCI);
            emlrtPopRtStackR2012b(&eb_emlrtRSI, emlrtRootTLSGlobal);
          }

          i0 = y->size[0] * y->size[1];
          y->size[0] = 1;
          y->size[1] = bk;
          emxEnsureCapacity((emxArray__common *)y, i0, (int32_T)sizeof(int32_T),
                            &b_emlrtRTEI);
          b_j = 0;
          emlrtPushRtStackR2012b(&fb_emlrtRSI, emlrtRootTLSGlobal);
          emlrtPushRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
          check_forloop_overflow_error(FALSE);
          emlrtPopRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
          emlrtPopRtStackR2012b(&fb_emlrtRSI, emlrtRootTLSGlobal);
          for (bsub = 1; bsub <= ind->size[1]; bsub++) {
            if (ind->data[bsub - 1]) {
              y->data[b_j] = bsub;
              b_j++;
            }
          }

          loop_ub = y->size[0] * y->size[1];
          for (i0 = 0; i0 < loop_ub; i0++) {
            bsub = Xp->size[0];
            b_j = y->data[i0];
            emlrtDynamicBoundsCheckFastR2012b(b_j, 1, bsub, &h_emlrtBCI,
              emlrtRootTLSGlobal);
          }

          /* UNTITLED Summary of this function goes here */
          /*    Detailed explanation goes here */
          emlrtPushRtStackR2012b(&hb_emlrtRSI, emlrtRootTLSGlobal);
          b_j = y->size[1];
          loop_ub = Xp->size[1];
          i0 = b_Xp->size[0] * b_Xp->size[1];
          b_Xp->size[0] = b_j;
          b_Xp->size[1] = loop_ub;
          emxEnsureCapacity((emxArray__common *)b_Xp, i0, (int32_T)sizeof(real_T),
                            &emlrtRTEI);
          for (i0 = 0; i0 < loop_ub; i0++) {
            for (bsub = 0; bsub < b_j; bsub++) {
              b_Xp->data[bsub + b_Xp->size[0] * i0] = Xp->data[(y->data[bsub] +
                Xp->size[0] * i0) - 1];
            }
          }

          gradllh(b_Xp, r0);
          i0 = r1->size[0] * r1->size[1];
          r1->size[0] = r0->size[0];
          r1->size[1] = r0->size[1];
          emxEnsureCapacity((emxArray__common *)r1, i0, (int32_T)sizeof(real_T),
                            &emlrtRTEI);
          loop_ub = r0->size[0] * r0->size[1];
          for (i0 = 0; i0 < loop_ub; i0++) {
            r1->data[i0] = r0->data[i0];
          }

          power(r1, r0);
          b_sum(r0, a);
          b_j = a->size[0];
          i0 = b_y->size[0];
          b_y->size[0] = b_j;
          emxEnsureCapacity((emxArray__common *)b_y, i0, (int32_T)sizeof(real_T),
                            &d_emlrtRTEI);
          for (bk = 0; bk < b_j; bk++) {
            b_y->data[bk] = muDoubleScalarPower(a->data[bk], 2.0);
          }

          i0 = b_y->size[0];
          b_y->size[0] = b_y->size[0];
          emxEnsureCapacity((emxArray__common *)b_y, i0, (int32_T)sizeof(real_T),
                            &emlrtRTEI);
          loop_ub = b_y->size[0];
          for (i0 = 0; i0 < loop_ub; i0++) {
            b_y->data[i0]++;
          }

          i0 = a->size[0];
          a->size[0] = b_y->size[0];
          emxEnsureCapacity((emxArray__common *)a, i0, (int32_T)sizeof(real_T),
                            &emlrtRTEI);
          loop_ub = b_y->size[0];
          for (i0 = 0; i0 < loop_ub; i0++) {
            a->data[i0] = b_y->data[i0];
          }

          for (bk = 0; bk < b_y->size[0]; bk++) {
            if (b_y->data[bk] < 0.0) {
              emlrtPushRtStackR2012b(&pb_emlrtRSI, emlrtRootTLSGlobal);
              eml_error();
              emlrtPopRtStackR2012b(&pb_emlrtRSI, emlrtRootTLSGlobal);
            }
          }

          for (bk = 0; bk < b_y->size[0]; bk++) {
            a->data[bk] = muDoubleScalarSqrt(a->data[bk]);
          }

          i0 = a->size[0];
          a->size[0] = a->size[0];
          emxEnsureCapacity((emxArray__common *)a, i0, (int32_T)sizeof(real_T),
                            &emlrtRTEI);
          loop_ub = a->size[0];
          for (i0 = 0; i0 < loop_ub; i0++) {
            a->data[i0] = Dzero / a->data[i0];
          }

          emlrtPopRtStackR2012b(&hb_emlrtRSI, emlrtRootTLSGlobal);
          emlrtPushRtStackR2012b(&rb_emlrtRSI, emlrtRootTLSGlobal);
          emlrtPushRtStackR2012b(&sb_emlrtRSI, emlrtRootTLSGlobal);
          if ((a->size[0] == 1) || (a->size[0] != 1)) {
            overflow = TRUE;
          } else {
            overflow = FALSE;
          }

          if (overflow) {
          } else {
            emlrtPushRtStackR2012b(&tb_emlrtRSI, emlrtRootTLSGlobal);
            d_y = NULL;
            m0 = mxCreateCharArray(2, iv0);
            emlrtInitCharArray(36, m0, cv0);
            emlrtAssign(&d_y, m0);
            error(b_message(d_y, &t_emlrtMCI), &u_emlrtMCI);
            emlrtPopRtStackR2012b(&tb_emlrtRSI, emlrtRootTLSGlobal);
          }

          if (a->size[0] > 0) {
          } else {
            emlrtPushRtStackR2012b(&ub_emlrtRSI, emlrtRootTLSGlobal);
            e_y = NULL;
            m0 = mxCreateCharArray(2, iv1);
            emlrtInitCharArray(39, m0, cv1);
            emlrtAssign(&e_y, m0);
            error(b_message(e_y, &v_emlrtMCI), &w_emlrtMCI);
            emlrtPopRtStackR2012b(&ub_emlrtRSI, emlrtRootTLSGlobal);
          }

          emlrtPushRtStackR2012b(&vb_emlrtRSI, emlrtRootTLSGlobal);
          b_j = 1;
          x = a->data[0];
          if (a->size[0] > 1) {
            if (muDoubleScalarIsNaN(a->data[0])) {
              emlrtPushRtStackR2012b(&xb_emlrtRSI, emlrtRootTLSGlobal);
              overflow = (a->size[0] > 2147483646);
              emlrtPushRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
              check_forloop_overflow_error(overflow);
              emlrtPopRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
              emlrtPopRtStackR2012b(&xb_emlrtRSI, emlrtRootTLSGlobal);
              bsub = 2;
              exitg2 = FALSE;
              while ((exitg2 == FALSE) && (bsub <= a->size[0])) {
                b_j = bsub;
                if (!muDoubleScalarIsNaN(a->data[bsub - 1])) {
                  x = a->data[bsub - 1];
                  exitg2 = TRUE;
                } else {
                  bsub++;
                }
              }
            }

            if (b_j < a->size[0]) {
              emlrtPushRtStackR2012b(&wb_emlrtRSI, emlrtRootTLSGlobal);
              if (b_j + 1 > a->size[0]) {
                overflow = FALSE;
              } else {
                overflow = (a->size[0] > 2147483646);
              }

              emlrtPushRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
              check_forloop_overflow_error(overflow);
              emlrtPopRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
              emlrtPopRtStackR2012b(&wb_emlrtRSI, emlrtRootTLSGlobal);
              while (b_j + 1 <= a->size[0]) {
                if (a->data[b_j] < x) {
                  x = a->data[b_j];
                }

                b_j++;
              }
            }
          }

          emlrtPopRtStackR2012b(&vb_emlrtRSI, emlrtRootTLSGlobal);
          emlrtPopRtStackR2012b(&sb_emlrtRSI, emlrtRootTLSGlobal);
          emlrtPopRtStackR2012b(&rb_emlrtRSI, emlrtRootTLSGlobal);
          i0 = Dp->size[0];
          bsub = 1 + j;
          Dp->data[emlrtDynamicBoundsCheckFastR2012b(bsub, 1, i0, &i_emlrtBCI,
            emlrtRootTLSGlobal) - 1] = x;
          emlrtPopRtStackR2012b(&c_emlrtRSI, emlrtRootTLSGlobal);
          k++;
          emlrtBreakCheckFastR2012b(emlrtBreakCheckR2012bFlagVar,
            emlrtRootTLSGlobal);
        } else {
          emlrtPushRtStackR2012b(&d_emlrtRSI, emlrtRootTLSGlobal);
          i0 = X->size[0];
          bsub = (int32_T)(1.0 + (real_T)j);
          emlrtDynamicBoundsCheckFastR2012b(bsub, 1, i0, &d_emlrtBCI,
            emlrtRootTLSGlobal);

          /* UNTITLED Summary of this function goes here */
          /*    Detailed explanation goes here */
          emlrtPushRtStackR2012b(&hb_emlrtRSI, emlrtRootTLSGlobal);

          /* GRADLLH gradient of the log-likelihood function to be approximated */
          emlrtPushRtStackR2012b(&ib_emlrtRSI, emlrtRootTLSGlobal);
          loop_ub = X->size[1];
          i0 = b_X->size[0] * b_X->size[1];
          b_X->size[0] = 1;
          b_X->size[1] = loop_ub;
          emxEnsureCapacity((emxArray__common *)b_X, i0, (int32_T)sizeof(real_T),
                            &emlrtRTEI);
          for (i0 = 0; i0 < loop_ub; i0++) {
            b_X->data[b_X->size[0] * i0] = X->data[j + X->size[0] * i0];
          }

          b_power(b_X, gU);
          x = sum(gU);
          loop_ub = X->size[1];
          i0 = r2->size[0];
          r2->size[0] = loop_ub;
          emxEnsureCapacity((emxArray__common *)r2, i0, (int32_T)sizeof(int32_T),
                            &emlrtRTEI);
          for (i0 = 0; i0 < loop_ub; i0++) {
            r2->data[i0] = 1 + i0;
          }

          i0 = gU->size[0] * gU->size[1];
          gU->size[0] = 1;
          gU->size[1] = r2->size[0];
          emxEnsureCapacity((emxArray__common *)gU, i0, (int32_T)sizeof(real_T),
                            &c_emlrtRTEI);
          bsub = 1;
          bk = 0;
          emlrtPushRtStackR2012b(&mb_emlrtRSI, emlrtRootTLSGlobal);
          emlrtPushRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
          check_forloop_overflow_error(FALSE);
          emlrtPopRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
          emlrtPopRtStackR2012b(&mb_emlrtRSI, emlrtRootTLSGlobal);
          k = 0;
          do {
            exitg3 = 0;
            loop_ub = X->size[1];
            i0 = r3->size[0];
            r3->size[0] = loop_ub;
            emxEnsureCapacity((emxArray__common *)r3, i0, (int32_T)sizeof
                              (int32_T), &emlrtRTEI);
            for (i0 = 0; i0 < loop_ub; i0++) {
              r3->data[i0] = 1 + i0;
            }

            b_j = r3->size[0];
            if (k <= b_j - 1) {
              gU->data[k] = -muDoubleScalarExp(-0.5 * x) * X->data[j + X->size[0]
                * bk];
              loop_ub = X->size[1];
              i0 = r4->size[0];
              r4->size[0] = loop_ub;
              emxEnsureCapacity((emxArray__common *)r4, i0, (int32_T)sizeof
                                (int32_T), &emlrtRTEI);
              for (i0 = 0; i0 < loop_ub; i0++) {
                r4->data[i0] = 1 + i0;
              }

              if (bsub < r4->size[0]) {
                bk++;
                bsub++;
              } else {
                bsub = 1;
              }

              k++;
            } else {
              exitg3 = 1;
            }
          } while (exitg3 == 0);

          emlrtPopRtStackR2012b(&ib_emlrtRSI, emlrtRootTLSGlobal);
          i0 = b_gU->size[0] * b_gU->size[1];
          b_gU->size[0] = 1;
          b_gU->size[1] = gU->size[1];
          emxEnsureCapacity((emxArray__common *)b_gU, i0, (int32_T)sizeof(real_T),
                            &emlrtRTEI);
          loop_ub = gU->size[0] * gU->size[1];
          for (i0 = 0; i0 < loop_ub; i0++) {
            b_gU->data[i0] = gU->data[i0];
          }

          b_power(b_gU, gU);
          x = sum(gU);
          x = muDoubleScalarPower(x, 2.0);
          if (1.0 + x < 0.0) {
            emlrtPushRtStackR2012b(&pb_emlrtRSI, emlrtRootTLSGlobal);
            eml_error();
            emlrtPopRtStackR2012b(&pb_emlrtRSI, emlrtRootTLSGlobal);
          }

          emlrtPopRtStackR2012b(&hb_emlrtRSI, emlrtRootTLSGlobal);
          i0 = Dp->size[0];
          bsub = 1 + j;
          Dp->data[emlrtDynamicBoundsCheckFastR2012b(bsub, 1, i0, &g_emlrtBCI,
            emlrtRootTLSGlobal) - 1] = Dzero / muDoubleScalarSqrt(1.0 + x);
          emlrtPopRtStackR2012b(&d_emlrtRSI, emlrtRootTLSGlobal);
          exitg1 = 1;
        }
      } else {
        exitg1 = 1;
      }
    } while (exitg1 == 0);

    j++;
    emlrtBreakCheckFastR2012b(emlrtBreakCheckR2012bFlagVar, emlrtRootTLSGlobal);
  }

  emxFree_int32_T(&r4);
  emxFree_int32_T(&r3);
  emxFree_int32_T(&r2);
  emxFree_real_T(&b_Xp);
  emxFree_real_T(&r1);
  emxFree_real_T(&c_X);
  emxFree_real_T(&b_X);
  emxFree_real_T(&b_gU);
  emxFree_real_T(&r0);
  emxFree_real_T(&a);
  emxFree_real_T(&b_y);
  emxFree_real_T(&gU);
  emxFree_int32_T(&y);
  emxFree_boolean_T(&ind);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

void check_forloop_overflow_error(boolean_T overflow)
{
  const mxArray *y;
  static const int32_T iv5[2] = { 1, 34 };

  const mxArray *m2;
  static const char_T cv4[34] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o', 'o',
    'l', 'b', 'o', 'x', ':', 'i', 'n', 't', '_', 'f', 'o', 'r', 'l', 'o', 'o',
    'p', '_', 'o', 'v', 'e', 'r', 'f', 'l', 'o', 'w' };

  const mxArray *b_y;
  static const int32_T iv6[2] = { 1, 23 };

  static const char_T cv5[23] = { 'c', 'o', 'd', 'e', 'r', '.', 'i', 'n', 't',
    'e', 'r', 'n', 'a', 'l', '.', 'i', 'n', 'd', 'e', 'x', 'I', 'n', 't' };

  if (!overflow) {
  } else {
    emlrtPushRtStackR2012b(&h_emlrtRSI, emlrtRootTLSGlobal);
    y = NULL;
    m2 = mxCreateCharArray(2, iv5);
    emlrtInitCharArray(34, m2, cv4);
    emlrtAssign(&y, m2);
    b_y = NULL;
    m2 = mxCreateCharArray(2, iv6);
    emlrtInitCharArray(23, m2, cv5);
    emlrtAssign(&b_y, m2);
    error(message(y, b_y, &emlrtMCI), &b_emlrtMCI);
    emlrtPopRtStackR2012b(&h_emlrtRSI, emlrtRootTLSGlobal);
  }
}

/* End of code generation (calcDp.c) */
