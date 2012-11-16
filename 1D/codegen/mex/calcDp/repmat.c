/*
 * repmat.c
 *
 * Code generation for function 'repmat'
 *
 * C source code generated on: Wed Nov 14 18:19:51 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "calcDp.h"
#include "repmat.h"
#include "calcDp_emxutil.h"
#include "calcDp_mexutil.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static emlrtRSInfo i_emlrtRSI = { 19, "repmat",
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

static emlrtRTEInfo h_emlrtRTEI = { 1, 14, "repmat",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elmat/repmat.m" };

/* Function Declarations */

/* Function Definitions */
void repmat(real_T a, real_T n, emxArray_real_T *b)
{
  boolean_T b_n;
  const mxArray *y;
  static const int32_T iv7[2] = { 1, 28 };

  const mxArray *m3;
  static const char_T cv6[28] = { 'C', 'o', 'd', 'e', 'r', ':', 'M', 'A', 'T',
    'L', 'A', 'B', ':', 'N', 'o', 'n', 'I', 'n', 't', 'e', 'g', 'e', 'r', 'I',
    'n', 'p', 'u', 't' };

  int32_T iv8[2];
  int32_T outsize[2];
  int32_T i2;
  int32_T loop_ub;
  emlrtPushRtStackR2012b(&i_emlrtRSI, emlrtRootTLSGlobal);
  if (n != n) {
    b_n = FALSE;
  } else {
    b_n = TRUE;
  }

  if (b_n) {
  } else {
    emlrtPushRtStackR2012b(&j_emlrtRSI, emlrtRootTLSGlobal);
    y = NULL;
    m3 = mxCreateCharArray(2, iv7);
    emlrtInitCharArray(28, m3, cv6);
    emlrtAssign(&y, m3);
    error(b_message(y, &c_emlrtMCI), &d_emlrtMCI);
    emlrtPopRtStackR2012b(&j_emlrtRSI, emlrtRootTLSGlobal);
  }

  emlrtPopRtStackR2012b(&i_emlrtRSI, emlrtRootTLSGlobal);
  iv8[0] = 1;
  iv8[1] = (int32_T)n;
  for (i2 = 0; i2 < 2; i2++) {
    outsize[i2] = iv8[i2];
  }

  i2 = b->size[0] * b->size[1];
  b->size[0] = 1;
  emxEnsureCapacity((emxArray__common *)b, i2, (int32_T)sizeof(real_T),
                    &h_emlrtRTEI);
  i2 = b->size[0] * b->size[1];
  b->size[1] = outsize[1];
  emxEnsureCapacity((emxArray__common *)b, i2, (int32_T)sizeof(real_T),
                    &h_emlrtRTEI);
  loop_ub = outsize[1];
  for (i2 = 0; i2 < loop_ub; i2++) {
    b->data[i2] = a;
  }
}

/* End of code generation (repmat.c) */
