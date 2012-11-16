/*
 * gradllh.c
 *
 * Code generation for function 'gradllh'
 *
 * C source code generated on: Wed Nov 14 18:19:51 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "calcDp.h"
#include "gradllh.h"
#include "calcDp_emxutil.h"
#include "sum.h"
#include "power.h"
#include "calcDp_mexutil.h"
#include "calcDp_data.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static emlrtRSInfo jb_emlrtRSI = { 84, "bsxfun",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elmat/bsxfun.m" };

static emlrtRSInfo kb_emlrtRSI = { 78, "bsxfun",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elmat/bsxfun.m" };

static emlrtRSInfo lb_emlrtRSI = { 74, "bsxfun",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elmat/bsxfun.m" };

static emlrtRSInfo nb_emlrtRSI = { 23, "bsxfun",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elmat/bsxfun.m" };

static emlrtRSInfo ob_emlrtRSI = { 21, "bsxfun",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elmat/bsxfun.m" };

static emlrtMCInfo n_emlrtMCI = { 22, 5, "bsxfun",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elmat/bsxfun.m" };

static emlrtMCInfo o_emlrtMCI = { 21, 15, "bsxfun",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elmat/bsxfun.m" };

static emlrtMCInfo p_emlrtMCI = { 24, 5, "bsxfun",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elmat/bsxfun.m" };

static emlrtMCInfo q_emlrtMCI = { 23, 15, "bsxfun",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elmat/bsxfun.m" };

static emlrtRTEInfo k_emlrtRTEI = { 1, 19, "gradllh",
  "/Users/schaluck/Documents/MATLAB/MT/1D/gradllh.m" };

static emlrtRTEInfo l_emlrtRTEI = { 62, 1, "bsxfun",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elmat/bsxfun.m" };

static emlrtRTEInfo m_emlrtRTEI = { 63, 1, "bsxfun",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elmat/bsxfun.m" };

static emlrtRTEInfo n_emlrtRTEI = { 82, 5, "bsxfun",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elmat/bsxfun.m" };

/* Function Declarations */

/* Function Definitions */
void gradllh(const emxArray_real_T *x, emxArray_real_T *gU)
{
  emxArray_real_T *av;
  emxArray_real_T *r8;
  int32_T k;
  int32_T loop_ub;
  emxArray_real_T *b_x;
  boolean_T overflow;
  const mxArray *y;
  static const int32_T iv11[2] = { 1, 44 };

  const mxArray *m5;
  static const char_T cv9[44] = { 'C', 'o', 'd', 'e', 'r', ':', 'M', 'A', 'T',
    'L', 'A', 'B', ':', 'b', 's', 'x', 'f', 'u', 'n', '_', 'a', 'r', 'r', 'a',
    'y', 'D', 'i', 'm', 'e', 'n', 's', 'i', 'o', 'n', 's', 'M', 'u', 's', 't',
    'M', 'a', 't', 'c', 'h' };

  const mxArray *b_y;
  static const int32_T iv12[2] = { 1, 37 };

  static const char_T cv10[37] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o', 'o',
    'l', 'b', 'o', 'x', ':', 'b', 's', 'x', 'f', 'u', 'n', '_', 'd', 'y', 'n',
    'a', 'm', 'i', 'c', 'E', 'x', 'p', 'a', 'n', 's', 'i', 'o', 'n' };

  emxArray_real_T *bv;
  int32_T bsub;
  int32_T bk;
  int32_T x_idx_0;
  int32_T b;
  int32_T ck;
  emxArray_real_T *cv;
  int32_T exitg1;
  int32_T exitg2;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  b_emxInit_real_T(&av, 1, &l_emlrtRTEI, TRUE);
  emxInit_real_T(&r8, 2, &k_emlrtRTEI, TRUE);

  /* GRADLLH gradient of the log-likelihood function to be approximated */
  emlrtPushRtStackR2012b(&ib_emlrtRSI, emlrtRootTLSGlobal);
  power(x, r8);
  b_sum(r8, av);
  k = av->size[0];
  av->size[0] = av->size[0];
  emxEnsureCapacity((emxArray__common *)av, k, (int32_T)sizeof(real_T),
                    &k_emlrtRTEI);
  loop_ub = av->size[0];
  emxFree_real_T(&r8);
  for (k = 0; k < loop_ub; k++) {
    av->data[k] *= -0.5;
  }

  b_emxInit_real_T(&b_x, 1, &k_emlrtRTEI, TRUE);
  k = b_x->size[0];
  b_x->size[0] = av->size[0];
  emxEnsureCapacity((emxArray__common *)b_x, k, (int32_T)sizeof(real_T),
                    &k_emlrtRTEI);
  loop_ub = av->size[0];
  for (k = 0; k < loop_ub; k++) {
    b_x->data[k] = av->data[k];
  }

  for (k = 0; k < av->size[0]; k++) {
    b_x->data[(int32_T)(1.0 + (real_T)k) - 1] = muDoubleScalarExp(b_x->data
      [(int32_T)(1.0 + (real_T)k) - 1]);
  }

  k = b_x->size[0];
  b_x->size[0] = b_x->size[0];
  emxEnsureCapacity((emxArray__common *)b_x, k, (int32_T)sizeof(real_T),
                    &k_emlrtRTEI);
  loop_ub = b_x->size[0];
  for (k = 0; k < loop_ub; k++) {
    b_x->data[k] = -b_x->data[k];
  }

  if ((b_x->size[0] != 1) && (x->size[0] != 1) && (b_x->size[0] != x->size[0]))
  {
    overflow = FALSE;
  } else {
    overflow = TRUE;
  }

  if (overflow) {
  } else {
    emlrtPushRtStackR2012b(&ob_emlrtRSI, emlrtRootTLSGlobal);
    y = NULL;
    m5 = mxCreateCharArray(2, iv11);
    emlrtInitCharArray(44, m5, cv9);
    emlrtAssign(&y, m5);
    error(b_message(y, &n_emlrtMCI), &o_emlrtMCI);
    emlrtPopRtStackR2012b(&ob_emlrtRSI, emlrtRootTLSGlobal);
  }

  if (b_x->size[0] != x->size[0]) {
    overflow = FALSE;
  } else {
    overflow = TRUE;
  }

  if (overflow) {
  } else {
    emlrtPushRtStackR2012b(&nb_emlrtRSI, emlrtRootTLSGlobal);
    b_y = NULL;
    m5 = mxCreateCharArray(2, iv12);
    emlrtInitCharArray(37, m5, cv10);
    emlrtAssign(&b_y, m5);
    error(b_message(b_y, &p_emlrtMCI), &q_emlrtMCI);
    emlrtPopRtStackR2012b(&nb_emlrtRSI, emlrtRootTLSGlobal);
  }

  b_emxInit_real_T(&bv, 1, &m_emlrtRTEI, TRUE);
  k = gU->size[0] * gU->size[1];
  gU->size[0] = b_x->size[0];
  gU->size[1] = x->size[1];
  emxEnsureCapacity((emxArray__common *)gU, k, (int32_T)sizeof(real_T),
                    &c_emlrtRTEI);
  loop_ub = b_x->size[0];
  k = av->size[0];
  av->size[0] = loop_ub;
  emxEnsureCapacity((emxArray__common *)av, k, (int32_T)sizeof(real_T),
                    &l_emlrtRTEI);
  loop_ub = x->size[0];
  k = bv->size[0];
  bv->size[0] = loop_ub;
  emxEnsureCapacity((emxArray__common *)bv, k, (int32_T)sizeof(real_T),
                    &m_emlrtRTEI);
  bsub = 1;
  bk = 0;
  x_idx_0 = b_x->size[0];
  loop_ub = x->size[1];
  k = b_x->size[0];
  b = x_idx_0 * loop_ub - k;
  emlrtPushRtStackR2012b(&mb_emlrtRSI, emlrtRootTLSGlobal);
  x_idx_0 = b_x->size[0];
  if ((x_idx_0 == 0) || (0 > b)) {
    overflow = FALSE;
  } else {
    x_idx_0 = b_x->size[0];
    overflow = (b > MAX_int32_T - x_idx_0);
  }

  emlrtPushRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
  check_forloop_overflow_error(overflow);
  emlrtPopRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPopRtStackR2012b(&mb_emlrtRSI, emlrtRootTLSGlobal);
  ck = 0;
  b_emxInit_real_T(&cv, 1, &n_emlrtRTEI, TRUE);
  do {
    exitg1 = 0;
    x_idx_0 = b_x->size[0];
    if ((x_idx_0 > 0) && (ck <= b)) {
      emlrtPushRtStackR2012b(&lb_emlrtRSI, emlrtRootTLSGlobal);
      if (1 > b_x->size[0]) {
        overflow = FALSE;
      } else {
        overflow = (b_x->size[0] > 2147483646);
      }

      emlrtPushRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
      check_forloop_overflow_error(overflow);
      emlrtPopRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPopRtStackR2012b(&lb_emlrtRSI, emlrtRootTLSGlobal);
      for (k = 0; k + 1 <= b_x->size[0]; k++) {
        av->data[k] = b_x->data[k];
      }

      emlrtPushRtStackR2012b(&kb_emlrtRSI, emlrtRootTLSGlobal);
      if (1 > x->size[0]) {
        overflow = FALSE;
      } else {
        overflow = (x->size[0] > 2147483646);
      }

      emlrtPushRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
      check_forloop_overflow_error(overflow);
      emlrtPopRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPopRtStackR2012b(&kb_emlrtRSI, emlrtRootTLSGlobal);
      for (k = 0; k + 1 <= x->size[0]; k++) {
        bv->data[k] = x->data[bk + k];
      }

      k = cv->size[0];
      cv->size[0] = av->size[0];
      emxEnsureCapacity((emxArray__common *)cv, k, (int32_T)sizeof(real_T),
                        &k_emlrtRTEI);
      loop_ub = av->size[0];
      for (k = 0; k < loop_ub; k++) {
        cv->data[k] = av->data[k] * bv->data[k];
      }

      emlrtPushRtStackR2012b(&jb_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPushRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
      check_forloop_overflow_error(FALSE);
      emlrtPopRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPopRtStackR2012b(&jb_emlrtRSI, emlrtRootTLSGlobal);
      k = 0;
      do {
        exitg2 = 0;
        x_idx_0 = b_x->size[0];
        if (k + 1 <= x_idx_0) {
          gU->data[ck + k] = cv->data[k];
          k++;
        } else {
          exitg2 = 1;
        }
      } while (exitg2 == 0);

      if (bsub < x->size[1]) {
        bk += x->size[0];
        bsub++;
      } else {
        bsub = 1;
      }

      x_idx_0 = b_x->size[0];
      ck += x_idx_0;
    } else {
      exitg1 = 1;
    }
  } while (exitg1 == 0);

  emxFree_real_T(&cv);
  emxFree_real_T(&bv);
  emxFree_real_T(&av);
  emxFree_real_T(&b_x);
  emlrtPopRtStackR2012b(&ib_emlrtRSI, emlrtRootTLSGlobal);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (gradllh.c) */
