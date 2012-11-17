/*
 * repmat.c
 *
 * Code generation for function 'repmat'
 *
 * C source code generated on: Sat Nov 17 15:52:36 2012
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
static emlrtRSInfo l_emlrtRSI = { 19, "repmat",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elmat/repmat.m" };

static emlrtRSInfo m_emlrtRSI = { 48, "eml_assert_valid_size_arg",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_assert_valid_size_arg.m"
};

static emlrtMCInfo e_emlrtMCI = { 49, 13, "eml_assert_valid_size_arg",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_assert_valid_size_arg.m"
};

static emlrtMCInfo f_emlrtMCI = { 48, 23, "eml_assert_valid_size_arg",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_assert_valid_size_arg.m"
};

static emlrtRTEInfo j_emlrtRTEI = { 1, 14, "repmat",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/elmat/repmat.m" };

/* Function Declarations */

/* Function Definitions */
void repmat(real_T a, real_T n, emxArray_real_T *b)
{
  boolean_T b_n;
  const mxArray *y;
  static const int32_T iv10[2] = { 1, 28 };

  const mxArray *m4;
  static const char_T cv8[28] = { 'C', 'o', 'd', 'e', 'r', ':', 'M', 'A', 'T',
    'L', 'A', 'B', ':', 'N', 'o', 'n', 'I', 'n', 't', 'e', 'g', 'e', 'r', 'I',
    'n', 'p', 'u', 't' };

  int32_T iv11[2];
  int32_T outsize[2];
  int32_T i1;
  int32_T loop_ub;
  emlrtPushRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
  if (n != n) {
    b_n = FALSE;
  } else {
    b_n = TRUE;
  }

  if (b_n) {
  } else {
    emlrtPushRtStackR2012b(&m_emlrtRSI, emlrtRootTLSGlobal);
    y = NULL;
    m4 = mxCreateCharArray(2, iv10);
    emlrtInitCharArray(28, m4, cv8);
    emlrtAssign(&y, m4);
    error(message(y, &e_emlrtMCI), &f_emlrtMCI);
    emlrtPopRtStackR2012b(&m_emlrtRSI, emlrtRootTLSGlobal);
  }

  emlrtPopRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
  iv11[0] = 1;
  iv11[1] = (int32_T)n;
  for (i1 = 0; i1 < 2; i1++) {
    outsize[i1] = iv11[i1];
  }

  i1 = b->size[0] * b->size[1];
  b->size[0] = 1;
  emxEnsureCapacity((emxArray__common *)b, i1, (int32_T)sizeof(real_T),
                    &j_emlrtRTEI);
  i1 = b->size[0] * b->size[1];
  b->size[1] = outsize[1];
  emxEnsureCapacity((emxArray__common *)b, i1, (int32_T)sizeof(real_T),
                    &j_emlrtRTEI);
  loop_ub = outsize[1];
  for (i1 = 0; i1 < loop_ub; i1++) {
    b->data[i1] = a;
  }
}

/* End of code generation (repmat.c) */
