/*
 * calcDp.c
 *
 * Code generation for function 'calcDp'
 *
 * C source code generated on: Sat Nov 17 15:52:36 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "calcDp.h"
#include "calcDp_emxutil.h"
#include "distm.h"
#include "monitor_function.h"
#include "calcDp_mexutil.h"
#include "calcDp_data.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 7, "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m" };

static emlrtRSInfo b_emlrtRSI = { 13, "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m" };

static emlrtRSInfo c_emlrtRSI = { 14, "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m" };

static emlrtRSInfo d_emlrtRSI = { 15, "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m" };

static emlrtRSInfo k_emlrtRSI = { 49, "eml_int_forloop_overflow_check",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m"
};

static emlrtRSInfo eb_emlrtRSI = { 17, "sum",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/datafun/sum.m" };

static emlrtRSInfo fb_emlrtRSI = { 20, "sum",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/datafun/sum.m" };

static emlrtRSInfo gb_emlrtRSI = { 11, "eml_li_find",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_li_find.m" };

static emlrtRSInfo hb_emlrtRSI = { 14, "eml_li_find",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_li_find.m" };

static emlrtRSInfo ib_emlrtRSI = { 26, "eml_li_find",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_li_find.m" };

static emlrtRSInfo jb_emlrtRSI = { 39, "eml_li_find",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_li_find.m" };

static emlrtRSInfo kb_emlrtRSI = { 16, "min",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/datafun/min.m" };

static emlrtRSInfo lb_emlrtRSI = { 18, "eml_min_or_max",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_min_or_max.m"
};

static emlrtRSInfo mb_emlrtRSI = { 38, "eml_min_or_max",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_min_or_max.m"
};

static emlrtRSInfo nb_emlrtRSI = { 73, "eml_min_or_max",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_min_or_max.m"
};

static emlrtRSInfo ob_emlrtRSI = { 88, "eml_min_or_max",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_min_or_max.m"
};

static emlrtRSInfo pb_emlrtRSI = { 219, "eml_min_or_max",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_min_or_max.m"
};

static emlrtRSInfo qb_emlrtRSI = { 192, "eml_min_or_max",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_min_or_max.m"
};

static emlrtMCInfo c_emlrtMCI = { 50, 9, "eml_int_forloop_overflow_check",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m"
};

static emlrtMCInfo d_emlrtMCI = { 49, 15, "eml_int_forloop_overflow_check",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m"
};

static emlrtMCInfo k_emlrtMCI = { 18, 9, "sum",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/datafun/sum.m" };

static emlrtMCInfo l_emlrtMCI = { 17, 19, "sum",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/datafun/sum.m" };

static emlrtMCInfo m_emlrtMCI = { 23, 9, "sum",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/datafun/sum.m" };

static emlrtMCInfo n_emlrtMCI = { 20, 19, "sum",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/datafun/sum.m" };

static emlrtMCInfo o_emlrtMCI = { 14, 5, "eml_li_find",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_li_find.m" };

static emlrtMCInfo p_emlrtMCI = { 41, 9, "eml_min_or_max",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_min_or_max.m"
};

static emlrtMCInfo q_emlrtMCI = { 38, 19, "eml_min_or_max",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_min_or_max.m"
};

static emlrtMCInfo r_emlrtMCI = { 74, 9, "eml_min_or_max",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_min_or_max.m"
};

static emlrtMCInfo s_emlrtMCI = { 73, 19, "eml_min_or_max",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_min_or_max.m"
};

static emlrtRTEInfo emlrtRTEI = { 1, 15, "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m" };

static emlrtRTEInfo b_emlrtRTEI = { 17, 9, "eml_li_find",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_li_find.m" };

static emlrtRTEInfo c_emlrtRTEI = { 7, 5, "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m" };

static emlrtRTEInfo d_emlrtRTEI = { 13, 13, "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m" };

static emlrtECInfo emlrtECI = { -1, 15, 29, "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m" };

static emlrtBCInfo emlrtBCI = { -1, -1, 13, 47, "Dp", "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m", 0 };

static emlrtBCInfo b_emlrtBCI = { -1, -1, 13, 28, "X", "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m", 0 };

static emlrtBCInfo c_emlrtBCI = { -1, -1, 11, 37, "Dp", "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m", 0 };

static emlrtBCInfo d_emlrtBCI = { -1, -1, 11, 29, "Dp", "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m", 0 };

static emlrtBCInfo e_emlrtBCI = { -1, -1, 12, 22, "Dp", "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m", 0 };

static emlrtBCInfo f_emlrtBCI = { -1, -1, 18, 17, "Dp", "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m", 0 };

static emlrtBCInfo g_emlrtBCI = { -1, -1, 18, 25, "MF", "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m", 0 };

static emlrtBCInfo h_emlrtBCI = { -1, -1, 15, 29, "MF", "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m", 0 };

static emlrtBCInfo i_emlrtBCI = { -1, -1, 15, 17, "Dp", "calcDp",
  "/Users/schaluck/Documents/MATLAB/MT/1D/calcDp.m", 0 };

/* Function Declarations */
static const mxArray *b_message(const mxArray *b, const mxArray *c, emlrtMCInfo *
  location);

/* Function Definitions */
static const mxArray *b_message(const mxArray *b, const mxArray *c, emlrtMCInfo *
  location)
{
  const mxArray *pArrays[2];
  const mxArray *m7;
  pArrays[0] = b;
  pArrays[1] = c;
  return emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m7, 2, pArrays, "message",
    TRUE, location);
}

void calcDp(const emxArray_real_T *X, const emxArray_real_T *Xp, real_T rstar,
            real_T Dzero, const emxArray_real_T *DF, emxArray_real_T *Dp)
{
  int32_T i0;
  int32_T loop_ub;
  emxArray_real_T *MF;
  int32_T j;
  emxArray_boolean_T *ind;
  emxArray_int32_T *r0;
  emxArray_real_T *r1;
  emxArray_real_T *b_X;
  emxArray_real_T *b_MF;
  emxArray_real_T *c_MF;
  emxArray_real_T *d_MF;
  emxArray_real_T *e_MF;
  emxArray_real_T *f_MF;
  emxArray_real_T *g_MF;
  emxArray_real_T *h_MF;
  emxArray_real_T *i_MF;
  emxArray_real_T *j_MF;
  emxArray_real_T *k_MF;
  emxArray_real_T *l_MF;
  real_T Dp_old;
  int32_T k;
  int32_T exitg1;
  real_T x;
  int32_T b_j;
  boolean_T overflow;
  boolean_T p;
  int32_T exitg4;
  const mxArray *y;
  static const int32_T iv0[2] = { 1, 30 };

  const mxArray *m0;
  static const char_T cv0[30] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o', 'o',
    'l', 'b', 'o', 'x', ':', 's', 'u', 'm', '_', 's', 'p', 'e', 'c', 'i', 'a',
    'l', 'E', 'm', 'p', 't', 'y' };

  const mxArray *b_y;
  static const int32_T iv1[2] = { 1, 36 };

  static const char_T cv1[36] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o', 'o',
    'l', 'b', 'o', 'x', ':', 'a', 'u', 't', 'o', 'D', 'i', 'm', 'I', 'n', 'c',
    'o', 'm', 'p', 'a', 't', 'i', 'b', 'i', 'l', 'i', 't', 'y' };

  int32_T ixstart;
  const mxArray *c_y;
  boolean_T guard1 = FALSE;
  const mxArray *d_y;
  static const int32_T iv2[2] = { 1, 36 };

  const mxArray *e_y;
  static const int32_T iv3[2] = { 1, 39 };

  static const char_T cv2[39] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o', 'o',
    'l', 'b', 'o', 'x', ':', 'e', 'm', 'l', '_', 'm', 'i', 'n', '_', 'o', 'r',
    '_', 'm', 'a', 'x', '_', 'v', 'a', 'r', 'D', 'i', 'm', 'Z', 'e', 'r', 'o' };

  int32_T exitg3;
  int32_T exitg2;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  i0 = Dp->size[0];
  Dp->size[0] = X->size[0];
  emxEnsureCapacity((emxArray__common *)Dp, i0, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  loop_ub = X->size[0];
  for (i0 = 0; i0 < loop_ub; i0++) {
    Dp->data[i0] = Dzero;
  }

  emxInit_real_T(&MF, 2, &c_emlrtRTEI, TRUE);
  emlrtPushRtStackR2012b(&emlrtRSI, emlrtRootTLSGlobal);
  monitor_function(DF, Dzero, MF);
  emlrtPopRtStackR2012b(&emlrtRSI, emlrtRootTLSGlobal);
  j = 1;
  emxInit_boolean_T(&ind, 2, &d_emlrtRTEI, TRUE);
  emxInit_int32_T(&r0, 2, &emlrtRTEI, TRUE);
  emxInit_real_T(&r1, 2, &emlrtRTEI, TRUE);
  emxInit_real_T(&b_X, 2, &emlrtRTEI, TRUE);
  emxInit_real_T(&b_MF, 2, &emlrtRTEI, TRUE);
  emxInit_real_T(&c_MF, 2, &emlrtRTEI, TRUE);
  emxInit_real_T(&d_MF, 2, &emlrtRTEI, TRUE);
  emxInit_real_T(&e_MF, 2, &emlrtRTEI, TRUE);
  emxInit_real_T(&f_MF, 2, &emlrtRTEI, TRUE);
  emxInit_real_T(&g_MF, 2, &emlrtRTEI, TRUE);
  emxInit_real_T(&h_MF, 2, &emlrtRTEI, TRUE);
  emxInit_real_T(&i_MF, 2, &emlrtRTEI, TRUE);
  emxInit_real_T(&j_MF, 2, &emlrtRTEI, TRUE);
  emxInit_real_T(&k_MF, 2, &emlrtRTEI, TRUE);
  emxInit_real_T(&l_MF, 2, &emlrtRTEI, TRUE);
  while (j - 1 <= X->size[0] - 1) {
    Dp_old = rtMinusInf;
    k = 0;
    do {
      exitg1 = 0;
      i0 = Dp->size[0];
      x = Dp_old - Dp->data[emlrtDynamicBoundsCheckFastR2012b(j, 1, i0,
        &d_emlrtBCI, emlrtRootTLSGlobal) - 1];
      i0 = Dp->size[0];
      b_j = (int32_T)(1.0 + (real_T)(j - 1));
      emlrtDynamicBoundsCheckFastR2012b(b_j, 1, i0, &c_emlrtBCI,
        emlrtRootTLSGlobal);
      if ((muDoubleScalarAbs(x) / Dp->data[j - 1] > 0.01) && (k < 15)) {
        i0 = Dp->size[0];
        Dp_old = Dp->data[emlrtDynamicBoundsCheckFastR2012b(j, 1, i0,
          &e_emlrtBCI, emlrtRootTLSGlobal) - 1];
        emlrtPushRtStackR2012b(&b_emlrtRSI, emlrtRootTLSGlobal);
        i0 = Dp->size[0];
        b_j = (int32_T)(1.0 + (real_T)(j - 1));
        emlrtDynamicBoundsCheckFastR2012b(b_j, 1, i0, &emlrtBCI,
          emlrtRootTLSGlobal);
        x = rstar * Dp->data[j - 1];
        loop_ub = X->size[1];
        i0 = X->size[0];
        b_j = emlrtDynamicBoundsCheckFastR2012b(j, 1, i0, &b_emlrtBCI,
          emlrtRootTLSGlobal);
        i0 = b_X->size[0] * b_X->size[1];
        b_X->size[0] = 1;
        b_X->size[1] = loop_ub;
        emxEnsureCapacity((emxArray__common *)b_X, i0, (int32_T)sizeof(real_T),
                          &emlrtRTEI);
        for (i0 = 0; i0 < loop_ub; i0++) {
          b_X->data[b_X->size[0] * i0] = X->data[(b_j + X->size[0] * i0) - 1];
        }

        distm(b_X, Xp, r1);
        i0 = ind->size[0] * ind->size[1];
        ind->size[0] = 1;
        ind->size[1] = r1->size[1];
        emxEnsureCapacity((emxArray__common *)ind, i0, (int32_T)sizeof(boolean_T),
                          &emlrtRTEI);
        loop_ub = r1->size[0] * r1->size[1];
        for (i0 = 0; i0 < loop_ub; i0++) {
          ind->data[i0] = (r1->data[i0] <= x);
        }

        emlrtPopRtStackR2012b(&b_emlrtRSI, emlrtRootTLSGlobal);
        emlrtPushRtStackR2012b(&c_emlrtRSI, emlrtRootTLSGlobal);
        overflow = FALSE;
        p = FALSE;
        b_j = 0;
        do {
          exitg4 = 0;
          if (b_j < 2) {
            if (ind->size[b_j] != 0) {
              exitg4 = 1;
            } else {
              b_j++;
            }
          } else {
            p = TRUE;
            exitg4 = 1;
          }
        } while (exitg4 == 0);

        if (!p) {
        } else {
          overflow = TRUE;
        }

        if (!overflow) {
        } else {
          emlrtPushRtStackR2012b(&eb_emlrtRSI, emlrtRootTLSGlobal);
          y = NULL;
          m0 = mxCreateCharArray(2, iv0);
          emlrtInitCharArray(30, m0, cv0);
          emlrtAssign(&y, m0);
          error(message(y, &k_emlrtMCI), &l_emlrtMCI);
          emlrtPopRtStackR2012b(&eb_emlrtRSI, emlrtRootTLSGlobal);
        }

        if ((ind->size[1] == 1) || (ind->size[1] != 1)) {
          overflow = TRUE;
        } else {
          overflow = FALSE;
        }

        if (overflow) {
        } else {
          emlrtPushRtStackR2012b(&fb_emlrtRSI, emlrtRootTLSGlobal);
          b_y = NULL;
          m0 = mxCreateCharArray(2, iv1);
          emlrtInitCharArray(36, m0, cv1);
          emlrtAssign(&b_y, m0);
          error(message(b_y, &m_emlrtMCI), &n_emlrtMCI);
          emlrtPopRtStackR2012b(&fb_emlrtRSI, emlrtRootTLSGlobal);
        }

        if (ind->size[1] == 0) {
          x = 0.0;
        } else {
          x = (real_T)ind->data[0];
          emlrtPushRtStackR2012b(&i_emlrtRSI, emlrtRootTLSGlobal);
          if (2 > ind->size[1]) {
            overflow = FALSE;
          } else {
            overflow = (ind->size[1] > 2147483646);
          }

          emlrtPushRtStackR2012b(&j_emlrtRSI, emlrtRootTLSGlobal);
          check_forloop_overflow_error(overflow);
          emlrtPopRtStackR2012b(&j_emlrtRSI, emlrtRootTLSGlobal);
          emlrtPopRtStackR2012b(&i_emlrtRSI, emlrtRootTLSGlobal);
          for (b_j = 2; b_j <= ind->size[1]; b_j++) {
            x += (real_T)ind->data[b_j - 1];
          }
        }

        emlrtPopRtStackR2012b(&c_emlrtRSI, emlrtRootTLSGlobal);
        if (x > 0.0) {
          emlrtPushRtStackR2012b(&d_emlrtRSI, emlrtRootTLSGlobal);
          emlrtPushRtStackR2012b(&gb_emlrtRSI, emlrtRootTLSGlobal);
          b_j = 0;
          emlrtPushRtStackR2012b(&jb_emlrtRSI, emlrtRootTLSGlobal);
          emlrtPushRtStackR2012b(&j_emlrtRSI, emlrtRootTLSGlobal);
          check_forloop_overflow_error(FALSE);
          emlrtPopRtStackR2012b(&j_emlrtRSI, emlrtRootTLSGlobal);
          emlrtPopRtStackR2012b(&jb_emlrtRSI, emlrtRootTLSGlobal);
          for (ixstart = 1; ixstart <= ind->size[1]; ixstart++) {
            if (ind->data[ixstart - 1]) {
              b_j++;
            }
          }

          emlrtPopRtStackR2012b(&gb_emlrtRSI, emlrtRootTLSGlobal);
          if (b_j <= ind->size[1]) {
          } else {
            emlrtPushRtStackR2012b(&hb_emlrtRSI, emlrtRootTLSGlobal);
            c_y = NULL;
            m0 = mxCreateString("Assertion failed.");
            emlrtAssign(&c_y, m0);
            error(c_y, &o_emlrtMCI);
            emlrtPopRtStackR2012b(&hb_emlrtRSI, emlrtRootTLSGlobal);
          }

          i0 = r0->size[0] * r0->size[1];
          r0->size[0] = 1;
          r0->size[1] = b_j;
          emxEnsureCapacity((emxArray__common *)r0, i0, (int32_T)sizeof(int32_T),
                            &b_emlrtRTEI);
          b_j = 0;
          emlrtPushRtStackR2012b(&ib_emlrtRSI, emlrtRootTLSGlobal);
          emlrtPushRtStackR2012b(&j_emlrtRSI, emlrtRootTLSGlobal);
          check_forloop_overflow_error(FALSE);
          emlrtPopRtStackR2012b(&j_emlrtRSI, emlrtRootTLSGlobal);
          emlrtPopRtStackR2012b(&ib_emlrtRSI, emlrtRootTLSGlobal);
          for (ixstart = 1; ixstart <= ind->size[1]; ixstart++) {
            if (ind->data[ixstart - 1]) {
              r0->data[b_j] = ixstart;
              b_j++;
            }
          }

          emlrtPopRtStackR2012b(&d_emlrtRSI, emlrtRootTLSGlobal);
          emlrtMatrixMatrixIndexCheckR2012b(*(int32_T (*)[2])MF->size, 2,
            *(int32_T (*)[2])r0->size, 2, &emlrtECI, emlrtRootTLSGlobal);
          emlrtPushRtStackR2012b(&d_emlrtRSI, emlrtRootTLSGlobal);
          loop_ub = r0->size[0] * r0->size[1];
          for (i0 = 0; i0 < loop_ub; i0++) {
            b_j = MF->size[0] * MF->size[1];
            ixstart = r0->data[i0];
            emlrtDynamicBoundsCheckFastR2012b(ixstart, 1, b_j, &h_emlrtBCI,
              emlrtRootTLSGlobal);
          }

          emlrtPushRtStackR2012b(&kb_emlrtRSI, emlrtRootTLSGlobal);
          emlrtPushRtStackR2012b(&lb_emlrtRSI, emlrtRootTLSGlobal);
          i0 = b_MF->size[0] * b_MF->size[1];
          b_MF->size[0] = 1;
          b_MF->size[1] = r0->size[1];
          emxEnsureCapacity((emxArray__common *)b_MF, i0, (int32_T)sizeof(real_T),
                            &emlrtRTEI);
          loop_ub = r0->size[1];
          for (i0 = 0; i0 < loop_ub; i0++) {
            b_MF->data[b_MF->size[0] * i0] = MF->data[r0->data[r0->size[0] * i0]
              - 1];
          }

          guard1 = FALSE;
          if (b_MF->size[1] == 1) {
            guard1 = TRUE;
          } else {
            i0 = c_MF->size[0] * c_MF->size[1];
            c_MF->size[0] = 1;
            c_MF->size[1] = r0->size[1];
            emxEnsureCapacity((emxArray__common *)c_MF, i0, (int32_T)sizeof
                              (real_T), &emlrtRTEI);
            loop_ub = r0->size[1];
            for (i0 = 0; i0 < loop_ub; i0++) {
              c_MF->data[c_MF->size[0] * i0] = MF->data[r0->data[r0->size[0] *
                i0] - 1];
            }

            if (c_MF->size[1] != 1) {
              guard1 = TRUE;
            } else {
              overflow = FALSE;
            }
          }

          if (guard1 == TRUE) {
            overflow = TRUE;
          }

          if (overflow) {
          } else {
            emlrtPushRtStackR2012b(&mb_emlrtRSI, emlrtRootTLSGlobal);
            d_y = NULL;
            m0 = mxCreateCharArray(2, iv2);
            emlrtInitCharArray(36, m0, cv1);
            emlrtAssign(&d_y, m0);
            error(message(d_y, &p_emlrtMCI), &q_emlrtMCI);
            emlrtPopRtStackR2012b(&mb_emlrtRSI, emlrtRootTLSGlobal);
          }

          i0 = d_MF->size[0] * d_MF->size[1];
          d_MF->size[0] = 1;
          d_MF->size[1] = r0->size[1];
          emxEnsureCapacity((emxArray__common *)d_MF, i0, (int32_T)sizeof(real_T),
                            &emlrtRTEI);
          loop_ub = r0->size[1];
          for (i0 = 0; i0 < loop_ub; i0++) {
            d_MF->data[d_MF->size[0] * i0] = MF->data[r0->data[r0->size[0] * i0]
              - 1];
          }

          if (d_MF->size[1] > 0) {
          } else {
            emlrtPushRtStackR2012b(&nb_emlrtRSI, emlrtRootTLSGlobal);
            e_y = NULL;
            m0 = mxCreateCharArray(2, iv3);
            emlrtInitCharArray(39, m0, cv2);
            emlrtAssign(&e_y, m0);
            error(message(e_y, &r_emlrtMCI), &s_emlrtMCI);
            emlrtPopRtStackR2012b(&nb_emlrtRSI, emlrtRootTLSGlobal);
          }

          emlrtPushRtStackR2012b(&ob_emlrtRSI, emlrtRootTLSGlobal);
          ixstart = 1;
          x = MF->data[r0->data[0] - 1];
          i0 = e_MF->size[0] * e_MF->size[1];
          e_MF->size[0] = 1;
          e_MF->size[1] = r0->size[1];
          emxEnsureCapacity((emxArray__common *)e_MF, i0, (int32_T)sizeof(real_T),
                            &emlrtRTEI);
          loop_ub = r0->size[1];
          for (i0 = 0; i0 < loop_ub; i0++) {
            e_MF->data[e_MF->size[0] * i0] = MF->data[r0->data[r0->size[0] * i0]
              - 1];
          }

          if (e_MF->size[1] > 1) {
            if (muDoubleScalarIsNaN(x)) {
              emlrtPushRtStackR2012b(&qb_emlrtRSI, emlrtRootTLSGlobal);
              i0 = f_MF->size[0] * f_MF->size[1];
              f_MF->size[0] = 1;
              f_MF->size[1] = r0->size[1];
              emxEnsureCapacity((emxArray__common *)f_MF, i0, (int32_T)sizeof
                                (real_T), &emlrtRTEI);
              loop_ub = r0->size[1];
              for (i0 = 0; i0 < loop_ub; i0++) {
                f_MF->data[f_MF->size[0] * i0] = MF->data[r0->data[r0->size[0] *
                  i0] - 1];
              }

              if (2 > f_MF->size[1]) {
                overflow = FALSE;
              } else {
                i0 = g_MF->size[0] * g_MF->size[1];
                g_MF->size[0] = 1;
                g_MF->size[1] = r0->size[1];
                emxEnsureCapacity((emxArray__common *)g_MF, i0, (int32_T)sizeof
                                  (real_T), &emlrtRTEI);
                loop_ub = r0->size[1];
                for (i0 = 0; i0 < loop_ub; i0++) {
                  g_MF->data[g_MF->size[0] * i0] = MF->data[r0->data[r0->size[0]
                    * i0] - 1];
                }

                overflow = (g_MF->size[1] > 2147483646);
              }

              emlrtPushRtStackR2012b(&j_emlrtRSI, emlrtRootTLSGlobal);
              check_forloop_overflow_error(overflow);
              emlrtPopRtStackR2012b(&j_emlrtRSI, emlrtRootTLSGlobal);
              emlrtPopRtStackR2012b(&qb_emlrtRSI, emlrtRootTLSGlobal);
              b_j = 2;
              do {
                exitg3 = 0;
                i0 = h_MF->size[0] * h_MF->size[1];
                h_MF->size[0] = 1;
                h_MF->size[1] = r0->size[1];
                emxEnsureCapacity((emxArray__common *)h_MF, i0, (int32_T)sizeof
                                  (real_T), &emlrtRTEI);
                loop_ub = r0->size[1];
                for (i0 = 0; i0 < loop_ub; i0++) {
                  h_MF->data[h_MF->size[0] * i0] = MF->data[r0->data[r0->size[0]
                    * i0] - 1];
                }

                if (b_j <= h_MF->size[1]) {
                  ixstart = b_j;
                  if (!muDoubleScalarIsNaN(MF->data[r0->data[r0->size[0] * (b_j
                        - 1)] - 1])) {
                    x = MF->data[r0->data[r0->size[0] * (b_j - 1)] - 1];
                    exitg3 = 1;
                  } else {
                    b_j++;
                  }
                } else {
                  exitg3 = 1;
                }
              } while (exitg3 == 0);
            }

            i0 = i_MF->size[0] * i_MF->size[1];
            i_MF->size[0] = 1;
            i_MF->size[1] = r0->size[1];
            emxEnsureCapacity((emxArray__common *)i_MF, i0, (int32_T)sizeof
                              (real_T), &emlrtRTEI);
            loop_ub = r0->size[1];
            for (i0 = 0; i0 < loop_ub; i0++) {
              i_MF->data[i_MF->size[0] * i0] = MF->data[r0->data[r0->size[0] *
                i0] - 1];
            }

            if (ixstart < i_MF->size[1]) {
              emlrtPushRtStackR2012b(&pb_emlrtRSI, emlrtRootTLSGlobal);
              i0 = j_MF->size[0] * j_MF->size[1];
              j_MF->size[0] = 1;
              j_MF->size[1] = r0->size[1];
              emxEnsureCapacity((emxArray__common *)j_MF, i0, (int32_T)sizeof
                                (real_T), &emlrtRTEI);
              loop_ub = r0->size[1];
              for (i0 = 0; i0 < loop_ub; i0++) {
                j_MF->data[j_MF->size[0] * i0] = MF->data[r0->data[r0->size[0] *
                  i0] - 1];
              }

              if (ixstart + 1 > j_MF->size[1]) {
                overflow = FALSE;
              } else {
                i0 = k_MF->size[0] * k_MF->size[1];
                k_MF->size[0] = 1;
                k_MF->size[1] = r0->size[1];
                emxEnsureCapacity((emxArray__common *)k_MF, i0, (int32_T)sizeof
                                  (real_T), &emlrtRTEI);
                loop_ub = r0->size[1];
                for (i0 = 0; i0 < loop_ub; i0++) {
                  k_MF->data[k_MF->size[0] * i0] = MF->data[r0->data[r0->size[0]
                    * i0] - 1];
                }

                overflow = (k_MF->size[1] > 2147483646);
              }

              emlrtPushRtStackR2012b(&j_emlrtRSI, emlrtRootTLSGlobal);
              check_forloop_overflow_error(overflow);
              emlrtPopRtStackR2012b(&j_emlrtRSI, emlrtRootTLSGlobal);
              emlrtPopRtStackR2012b(&pb_emlrtRSI, emlrtRootTLSGlobal);
              do {
                exitg2 = 0;
                i0 = l_MF->size[0] * l_MF->size[1];
                l_MF->size[0] = 1;
                l_MF->size[1] = r0->size[1];
                emxEnsureCapacity((emxArray__common *)l_MF, i0, (int32_T)sizeof
                                  (real_T), &emlrtRTEI);
                loop_ub = r0->size[1];
                for (i0 = 0; i0 < loop_ub; i0++) {
                  l_MF->data[l_MF->size[0] * i0] = MF->data[r0->data[r0->size[0]
                    * i0] - 1];
                }

                if (ixstart + 1 <= l_MF->size[1]) {
                  if (MF->data[r0->data[r0->size[0] * ixstart] - 1] < x) {
                    x = MF->data[r0->data[r0->size[0] * ixstart] - 1];
                  }

                  ixstart++;
                } else {
                  exitg2 = 1;
                }
              } while (exitg2 == 0);
            }
          }

          emlrtPopRtStackR2012b(&ob_emlrtRSI, emlrtRootTLSGlobal);
          emlrtPopRtStackR2012b(&lb_emlrtRSI, emlrtRootTLSGlobal);
          emlrtPopRtStackR2012b(&kb_emlrtRSI, emlrtRootTLSGlobal);
          i0 = Dp->size[0];
          Dp->data[emlrtDynamicBoundsCheckFastR2012b(j, 1, i0, &i_emlrtBCI,
            emlrtRootTLSGlobal) - 1] = x;
          emlrtPopRtStackR2012b(&d_emlrtRSI, emlrtRootTLSGlobal);
          k++;
          emlrtBreakCheckFastR2012b(emlrtBreakCheckR2012bFlagVar,
            emlrtRootTLSGlobal);
        } else {
          i0 = Dp->size[0];
          b_j = MF->size[0] * MF->size[1];
          Dp->data[emlrtDynamicBoundsCheckFastR2012b(j, 1, i0, &f_emlrtBCI,
            emlrtRootTLSGlobal) - 1] = MF->
            data[emlrtDynamicBoundsCheckFastR2012b(j, 1, b_j, &g_emlrtBCI,
            emlrtRootTLSGlobal) - 1];
          exitg1 = 1;
        }
      } else {
        exitg1 = 1;
      }
    } while (exitg1 == 0);

    j++;
    emlrtBreakCheckFastR2012b(emlrtBreakCheckR2012bFlagVar, emlrtRootTLSGlobal);
  }

  emxFree_real_T(&l_MF);
  emxFree_real_T(&k_MF);
  emxFree_real_T(&j_MF);
  emxFree_real_T(&i_MF);
  emxFree_real_T(&h_MF);
  emxFree_real_T(&g_MF);
  emxFree_real_T(&f_MF);
  emxFree_real_T(&e_MF);
  emxFree_real_T(&d_MF);
  emxFree_real_T(&c_MF);
  emxFree_real_T(&b_MF);
  emxFree_real_T(&b_X);
  emxFree_real_T(&r1);
  emxFree_int32_T(&r0);
  emxFree_boolean_T(&ind);
  emxFree_real_T(&MF);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

void check_forloop_overflow_error(boolean_T overflow)
{
  const mxArray *y;
  static const int32_T iv8[2] = { 1, 34 };

  const mxArray *m3;
  static const char_T cv6[34] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o', 'o',
    'l', 'b', 'o', 'x', ':', 'i', 'n', 't', '_', 'f', 'o', 'r', 'l', 'o', 'o',
    'p', '_', 'o', 'v', 'e', 'r', 'f', 'l', 'o', 'w' };

  const mxArray *b_y;
  static const int32_T iv9[2] = { 1, 23 };

  static const char_T cv7[23] = { 'c', 'o', 'd', 'e', 'r', '.', 'i', 'n', 't',
    'e', 'r', 'n', 'a', 'l', '.', 'i', 'n', 'd', 'e', 'x', 'I', 'n', 't' };

  if (!overflow) {
  } else {
    emlrtPushRtStackR2012b(&k_emlrtRSI, emlrtRootTLSGlobal);
    y = NULL;
    m3 = mxCreateCharArray(2, iv8);
    emlrtInitCharArray(34, m3, cv6);
    emlrtAssign(&y, m3);
    b_y = NULL;
    m3 = mxCreateCharArray(2, iv9);
    emlrtInitCharArray(23, m3, cv7);
    emlrtAssign(&b_y, m3);
    error(b_message(y, b_y, &c_emlrtMCI), &d_emlrtMCI);
    emlrtPopRtStackR2012b(&k_emlrtRSI, emlrtRootTLSGlobal);
  }
}

/* End of code generation (calcDp.c) */
