/*
 * repmat.c
 *
 * Code generation for function 'repmat'
 *
 * C source code generated on: Wed Nov 14 02:13:55 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "distm.h"
#include "repmat.h"
#include "distm_emxutil.h"
#include "distm_mexutil.h"
#include "distm_data.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static emlrtRSInfo f_emlrtRSI = { 19, "repmat",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elmat/repmat.m" };

static emlrtRSInfo i_emlrtRSI = { 63, "repmat",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elmat/repmat.m" };

static emlrtRSInfo j_emlrtRSI = { 48, "eml_assert_valid_size_arg",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_assert_valid_size_arg.m"
};

static emlrtMCInfo c_emlrtMCI = { 49, 13, "eml_assert_valid_size_arg",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_assert_valid_size_arg.m"
};

static emlrtMCInfo d_emlrtMCI = { 48, 23, "eml_assert_valid_size_arg",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_assert_valid_size_arg.m"
};

/* Function Declarations */

/* Function Definitions */
void repmat(const emxArray_real_T *a, real_T n, emxArray_real_T *b)
{
  boolean_T b_n;
  const mxArray *y;
  static const int32_T iv5[2] = { 1, 28 };

  const mxArray *m2;
  static const char_T cv4[28] = { 'C', 'o', 'd', 'e', 'r', ':', 'M', 'A', 'T',
    'L', 'A', 'B', ':', 'N', 'o', 'n', 'I', 'n', 't', 'e', 'g', 'e', 'r', 'I',
    'n', 'p', 'u', 't' };

  int32_T mv[2];
  int32_T b_a[2];
  int32_T outsize[2];
  int32_T ib;
  boolean_T b1;
  int32_T jtilecol;
  int32_T ia;
  boolean_T overflow;
  int32_T k;
  emlrtPushRtStackR2012b(&f_emlrtRSI, emlrtRootTLSGlobal);
  if (n != n) {
    b_n = FALSE;
  } else {
    b_n = TRUE;
  }

  if (b_n) {
  } else {
    emlrtPushRtStackR2012b(&j_emlrtRSI, emlrtRootTLSGlobal);
    y = NULL;
    m2 = mxCreateCharArray(2, iv5);
    emlrtInitCharArray(28, m2, cv4);
    emlrtAssign(&y, m2);
    error(b_message(y, &c_emlrtMCI), &d_emlrtMCI);
    emlrtPopRtStackR2012b(&j_emlrtRSI, emlrtRootTLSGlobal);
  }

  emlrtPopRtStackR2012b(&f_emlrtRSI, emlrtRootTLSGlobal);
  mv[0] = 1;
  mv[1] = (int32_T)n;
  b_a[0] = a->size[0];
  b_a[1] = 1;
  for (ib = 0; ib < 2; ib++) {
    outsize[ib] = b_a[ib] * mv[ib];
  }

  ib = b->size[0] * b->size[1];
  b->size[0] = outsize[0];
  b->size[1] = outsize[1];
  emxEnsureCapacity((emxArray__common *)b, ib, (int32_T)sizeof(real_T),
                    &b_emlrtRTEI);
  if ((outsize[0] == 0) || (outsize[1] == 0)) {
  } else {
    ib = 0;
    emlrtPushRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPushRtStackR2012b(&d_emlrtRSI, emlrtRootTLSGlobal);
    if (1 > (int32_T)n) {
      b1 = FALSE;
    } else {
      b1 = ((int32_T)n > 2147483646);
    }

    check_forloop_overflow_error(b1);
    emlrtPopRtStackR2012b(&d_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&g_emlrtRSI, emlrtRootTLSGlobal);
    for (jtilecol = 1; jtilecol <= (int32_T)n; jtilecol++) {
      emlrtPushRtStackR2012b(&h_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPushRtStackR2012b(&d_emlrtRSI, emlrtRootTLSGlobal);
      check_forloop_overflow_error(FALSE);
      emlrtPopRtStackR2012b(&d_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPopRtStackR2012b(&h_emlrtRSI, emlrtRootTLSGlobal);
      ia = 0;
      emlrtPushRtStackR2012b(&i_emlrtRSI, emlrtRootTLSGlobal);
      if (1 > a->size[0]) {
        overflow = FALSE;
      } else {
        overflow = (a->size[0] > 2147483646);
      }

      emlrtPushRtStackR2012b(&d_emlrtRSI, emlrtRootTLSGlobal);
      check_forloop_overflow_error(overflow);
      emlrtPopRtStackR2012b(&d_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPopRtStackR2012b(&i_emlrtRSI, emlrtRootTLSGlobal);
      for (k = 1; k <= a->size[0]; k++) {
        b->data[ib] = a->data[ia];
        ia++;
        ib++;
      }
    }
  }
}

/* End of code generation (repmat.c) */
