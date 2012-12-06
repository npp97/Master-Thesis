/*
 * colon.c
 *
 * Code generation for function 'colon'
 *
 * C source code generated on: Thu Dec  6 20:27:30 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "Riley.h"
#include "colon.h"
#include "mldivide.h"
#include "Riley_emxutil.h"
#include "Riley_data.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static emlrtRSInfo nc_emlrtRSI = { 151, "colon",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/colon.m" };

static emlrtRTEInfo h_emlrtRTEI = { 147, 1, "colon",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/colon.m" };

/* Function Declarations */

/* Function Definitions */
void eml_signed_integer_colon(int32_T b, emxArray_int32_T *y)
{
  int32_T n;
  int32_T yk;
  boolean_T b0;
  int32_T k;
  if (b < 1) {
    n = 0;
  } else {
    n = b;
  }

  yk = y->size[0] * y->size[1];
  y->size[0] = 1;
  y->size[1] = n;
  emxEnsureCapacity((emxArray__common *)y, yk, (int32_T)sizeof(int32_T),
                    &h_emlrtRTEI);
  if (n > 0) {
    y->data[0] = 1;
    yk = 1;
    emlrtPushRtStackR2012b(&nc_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPushRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
    if (2 > n) {
      b0 = FALSE;
    } else {
      b0 = (n > 2147483646);
    }

    check_forloop_overflow_error(b0);
    emlrtPopRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&nc_emlrtRSI, emlrtRootTLSGlobal);
    for (k = 2; k <= n; k++) {
      yk++;
      y->data[k - 1] = yk;
    }
  }
}

/* End of code generation (colon.c) */
